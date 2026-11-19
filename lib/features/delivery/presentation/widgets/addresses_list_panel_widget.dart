import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_state.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/addresses_list.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/new_address_form.dart';

class AddressesListPanelWidget extends StatefulWidget {
  const AddressesListPanelWidget({super.key});

  @override
  State<AddressesListPanelWidget> createState() => _AddressesListPanelState();
}

class _AddressesListPanelState extends State<AddressesListPanelWidget> {
  bool _isAddingMode = false;

  void _setAddingMode(bool value) => setState(() => _isAddingMode = value);

  @override
  void initState() {
    super.initState();
    context.read<AddressesCubit>().fetchUserAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return PopScope(
      canPop: !_isAddingMode,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _setAddingMode(false);
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.only(
            top: AppSpacing.l,
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            bottom: AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _PanelHandle(),
              const SizedBox(height: 20),
              _PanelHeader(
                isAddingMode: _isAddingMode,
                onNewAddress: () => _setAddingMode(true),
                onBack: () => _setAddingMode(false),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        child: child,
                      ),
                    ),
                    layoutBuilder: (currentChild, previousChildren) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [...previousChildren, ?currentChild],
                    ),
                    child: _isAddingMode
                        ? NewAddressForm(
                            key: const ValueKey('form'),
                            onSaved: () => _setAddingMode(false),
                          )
                        : const _AddressesListSection(key: ValueKey('list')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelHandle extends StatelessWidget {
  const _PanelHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: context.appColors.onSurfaceVariant,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({
    required this.isAddingMode,
    required this.onNewAddress,
    required this.onBack,
  });

  final bool isAddingMode;
  final VoidCallback onNewAddress;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.appColors;

    return Row(
      children: [
        if (isAddingMode)
          IconButton(
            icon: Icon(Icons.arrow_back, color: colors.onSurface),
            onPressed: onBack,
          ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            layoutBuilder: (currentChild, previousChildren) => Stack(
              alignment: Alignment.centerLeft,
              children: [...previousChildren, ?currentChild],
            ),
            child: Text(
              isAddingMode ? l10n.newAddressButton : l10n.myAddressesHead,
              key: ValueKey(isAddingMode),
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (!isAddingMode)
          TextButton.icon(
            onPressed: onNewAddress,
            icon: Icon(Icons.add, color: colors.onChip, size: 16),
            label: Text(
              l10n.newAddressButton,
              style: TextStyle(color: colors.onChip),
            ),
            style: TextButton.styleFrom(
              backgroundColor: colors.chipBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
      ],
    );
  }
}

class _AddressesListSection extends StatelessWidget {
  const _AddressesListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesCubit, AddressesState>(
      builder: (context, state) => AddressesList(
        selectedAddressId: state.selectedId,
        list: state.addresses,
        onSelectAddress: (id) =>
            context.read<AddressesCubit>().selectAddress(id),
      ),
    );
  }
}
