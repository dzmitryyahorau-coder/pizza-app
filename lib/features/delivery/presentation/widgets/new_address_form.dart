import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/shared/widgets/ensure_permission.dart';

class NewAddressForm extends StatefulWidget {
  const NewAddressForm({super.key});

  @override
  State<NewAddressForm> createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final _formKey = GlobalKey<FormState>();
  final _addressCtrl = TextEditingController();
  final _entranceCtrl = TextEditingController();
  final _floorCtrl = TextEditingController();
  final _intercomCtrl = TextEditingController();
  final _flatCtrl = TextEditingController();
  final _commentCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fillFromLocation());
  }

  Future<void> _fillFromLocation() async {
    final cubit = context.read<AddressesCubit>();

    final ok = await ensurePermission(
      context,
      Permission.locationWhenInUse,
      deniedMessage: '...', // l10n
    );
    if (!ok || !mounted) return;

    final located = await cubit.locateAddress();
    if (!mounted || located == null) return;

    if (_addressCtrl.text.isEmpty) {
      _addressCtrl.text = located.fullAddress;
    }
  }

  @override
  void dispose() {
    _addressCtrl.dispose();

    super.dispose();
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(hintText: hint),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          _buildField(controller: _addressCtrl, hint: l10n.addressFieldHint),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: _buildField(
                  controller: _entranceCtrl,
                  hint: l10n.entranceHint,
                ),
              ),
              Expanded(
                child: _buildField(
                  controller: _intercomCtrl,
                  hint: l10n.intercomHint,
                ),
              ),
            ],
          ),
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: _buildField(
                  controller: _floorCtrl,
                  hint: l10n.floorHint,
                ),
              ),
              Expanded(
                child: _buildField(
                  controller: _flatCtrl,
                  hint: l10n.apartmentHint,
                ),
              ),
            ],
          ),
          _buildField(controller: _commentCtrl, hint: l10n.courierCommentHint),
        ],
      ),
    );
  }
}
