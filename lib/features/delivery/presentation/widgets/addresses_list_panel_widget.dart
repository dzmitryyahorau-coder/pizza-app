import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_state.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/addresses_list.dart';
import 'package:pizza_app/features/delivery/presentation/widgets/new_address_form.dart';

// TODO: перенести в тему приложения
const _panelColor = Color(0xFF111318);
const _chipColor = Color(0xFF282D39);

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
    return PopScope(
      canPop: !_isAddingMode,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _setAddingMode(false);
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: _panelColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                    duration: const Duration(milliseconds: 200),
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
        color: Colors.grey[700],
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

    return Row(
      children: [
        if (isAddingMode)
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack,
          ),
        Expanded(
          child: Text(
            isAddingMode ? l10n.newAddressButton : l10n.myAddressesHead,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (!isAddingMode)
          TextButton.icon(
            onPressed: onNewAddress,
            icon: const Icon(Icons.add, color: Colors.white, size: 16),
            label: Text(
              l10n.newAddressButton,
              style: const TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: _chipColor,
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
