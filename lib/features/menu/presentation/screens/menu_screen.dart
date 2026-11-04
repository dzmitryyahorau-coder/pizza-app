import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/menu/bloc/menu_bloc.dart';
import 'package:pizza_app/features/menu/bloc/menu_event.dart';
import 'package:pizza_app/features/menu/bloc/menu_state.dart';
import 'package:pizza_app/features/menu/data/models/product.dart';
import 'package:pizza_app/features/menu/presentation/widgets/categories_list.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_header.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_sheet.dart';
import 'package:pizza_app/features/menu/presentation/widgets/product_item.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      builder: ((context, state) {
        if ([
          MenuStatus.loading,
          MenuStatus.refreshing,
        ].contains(state.status)) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state.status == MenuStatus.failure && state.categories.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.l,
                children: [
                  const Text('Error during the loading of menu data'),
                  FilledButton(
                    onPressed: () =>
                        context.read<MenuBloc>().add(const MenuLoadRequested()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return MenuView(state: state);
      }),
      listener: (BuildContext context, MenuState state) {},
    );
  }
}

class MenuView extends StatefulWidget {
  final MenuState state;

  const MenuView({super.key, required this.state});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  static const double _tabsHeight = 56;

  late final ScrollController _controller;

  final Map<String, double> _sectionOffsets = {};

  String? selectedCategoryId;
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    selectedCategoryId = widget.state.categories.firstOrNull?.id;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    final bloc = context.read<MenuBloc>();
    if (bloc.state.status == MenuStatus.refreshing) return;

    bloc.add(const MenuLoadRequested());
    await bloc.stream.firstWhere((s) => s.status != MenuStatus.refreshing);
  }

  void _onScroll() {
    if (_isProgrammaticScroll ||
        !_controller.hasClients ||
        _sectionOffsets.isEmpty) {
      return;
    }

    final position = _controller.position;
    final line = position.pixels + _tabsHeight + 1;
    final atBottom = position.pixels >= position.maxScrollExtent - 1;

    String? activeId;
    for (final category in widget.state.categories) {
      final start = _sectionOffsets[category.id];
      if (start == null) continue;

      if (atBottom || start <= line) {
        activeId = category.id;
      } else {
        break;
      }
    }

    activeId ??= widget.state.categories.firstOrNull?.id;
    if (activeId != null && activeId != selectedCategoryId) {
      setState(() => selectedCategoryId = activeId);
    }
  }

  Future<void> _scrollToCategory(String id) async {
    setState(() => selectedCategoryId = id);

    final start = _sectionOffsets[id];
    if (start == null || !_controller.hasClients) return;

    final position = _controller.position;
    final target = (start - _tabsHeight)
        .clamp(position.minScrollExtent, position.maxScrollExtent)
        .toDouble();

    _isProgrammaticScroll = true;
    try {
      await _controller.animateTo(
        target,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } finally {
      _isProgrammaticScroll = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final surface = context.appColors.surface;
    final menu = widget.state;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            controller: _controller,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const MenuHeader(),
                    MenuSheet(storiesList: menu.stories),
                  ],
                ),
              ),
              PinnedHeaderSliver(
                child: ColoredBox(
                  color: surface,
                  child: CategoriesList(
                    categories: menu.categories,
                    activeCategoryId: selectedCategoryId,
                    onChangeActiveCategoryId: _scrollToCategory,
                  ),
                ),
              ),
              for (final category in menu.categories)
                DecoratedSliver(
                  decoration: BoxDecoration(color: surface),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverLayoutBuilder(
                        builder: (context, constraints) {
                          _sectionOffsets[category.id] =
                              constraints.precedingScrollExtent;
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        },
                      ),
                      _ProductsSliver(
                        products:
                            menu.productsByCategory[category.id] ?? const [],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsSliver extends StatelessWidget {
  const _ProductsSliver({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: 8,
        ),
        child: InkWell(
          child: ProductItem(product: products[index]),
          onTap: () => context.push('/products/${products[index].id}'),
        ),
      ),
    );
  }
}
