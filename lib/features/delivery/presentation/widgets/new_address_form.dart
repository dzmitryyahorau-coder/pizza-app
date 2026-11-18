import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/delivery/data/models/address.dart';
import 'package:pizza_app/features/delivery/presentation/bloc/addresses_cubit.dart';
import 'package:pizza_app/shared/widgets/ensure_permission.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class NewAddressForm extends StatefulWidget {
  const NewAddressForm({super.key, required this.onSaved});

  final VoidCallback onSaved;

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

  final _geocoding = Geocoding();

  bool _isSaving = false;
  double? _lat;
  double? _lng;
  String? _geoText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fillFromLocation());
  }

  Future<void> _fillFromLocation() async {
    final cubit = context.read<AddressesCubit>();
    final l10n = context.l10n;

    final ok = await ensurePermission(
      context,
      Permission.locationWhenInUse,
      deniedMessage: l10n.permissionDeniedLocation,
    );
    if (!ok || !mounted) return;

    final located = await cubit.locateAddress();
    if (!mounted || located == null) return;

    if (_addressCtrl.text.isEmpty) {
      _addressCtrl.text = located.fullAddress;
      _geoText = _addressCtrl.text.trim();
      _lat = located.latitude;
      _lng = located.longitude;
    }
  }

  ({String city, String street, String house})? _parseAddress(String text) {
    final parts = text
        .split(',')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.length < 3) return null;
    return (
      city: parts[0],
      street: parts[1],
      house: parts.sublist(2).join(', '),
    );
  }

  String? _nullIfEmpty(TextEditingController c) {
    final t = c.text.trim();
    return t.isEmpty ? null : t;
  }

  Future<(double, double)?> _resolveCoordinates(String text) async {
    if (text == _geoText && _lat != null && _lng != null) {
      return (_lat!, _lng!);
    }
    try {
      final results = await _geocoding.locationFromAddress(text);
      if (results.isEmpty) return null;
      _geoText = text;
      _lat = results.first.latitude;
      _lng = results.first.longitude;
      return (_lat!, _lng!);
    } catch (e) {
      debugPrint('forward geocoding failed: $e');
      return null;
    }
  }

  Future<void> _onSavePressed() async {
    if (_isSaving || !_formKey.currentState!.validate()) return;

    final cubit = context.read<AddressesCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;

    final text = _addressCtrl.text.trim();
    final parsed = _parseAddress(text)!; // валидатор это гарантирует

    setState(() => _isSaving = true);

    final coords = await _resolveCoordinates(text);
    if (!mounted) return;

    if (coords == null) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.addressNotFound)));
      setState(() => _isSaving = false);
      return;
    }

    final address = Address(
      userId: '', // repository will set real user Id
      label: AddressLabel.other,
      city: parsed.city,
      street: parsed.street,
      house: parsed.house,
      latitude: coords.$1,
      longitude: coords.$2,
      entrance: _nullIfEmpty(_entranceCtrl),
      intercom: _nullIfEmpty(_intercomCtrl),
      floor: _nullIfEmpty(_floorCtrl),
      apartment: _nullIfEmpty(_flatCtrl),
      courierComment: _nullIfEmpty(_commentCtrl),
    );

    final ok = await cubit.addAddress(address);
    if (!mounted) return;

    if (ok) {
      widget.onSaved();
    } else {
      messenger.showSnackBar(SnackBar(content: Text(l10n.addressSaveFailed)));
      setState(() => _isSaving = false);
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
          _buildField(
            controller: _addressCtrl,
            hint: l10n.addressFieldHint,
            validator: (v) => _parseAddress(v ?? '') == null
                ? context.l10n.addressFormatError
                : null,
          ),
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
          const SizedBox(height: AppSpacing.xl),

          Padding(
            padding: EdgeInsetsGeometry.directional(bottom: AppSpacing.l),
            child: PrimaryFilledButton(
              onPressed: _onSavePressed,
              label: l10n.deliverHereButton,
            ),
          ),
        ],
      ),
    );
  }
}
