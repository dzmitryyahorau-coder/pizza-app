import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:pizza_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:pizza_app/shared/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/shared/widgets/custom_text_button.dart';
import 'package:pizza_app/shared/widgets/ensure_permission.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    final user = context.read<ProfileCubit>().state.user;

    _emailController = TextEditingController(text: user?.email ?? '');
    _nameController = TextEditingController(text: user?.name ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    // final password = _passwordController.text.trim(); [TODO]

    final user = context.read<ProfileCubit>().state.user;
    final changedName = name != (user?.name ?? '') ? name : null;
    final changedEmail = email != (user?.email ?? '') ? email : null;

    if (changedEmail == null && changedName == null) return;

    context.read<ProfileCubit>().updateProfileSettings(name: changedName);
  }

  Future<void> _chooseSource() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text(context.l10n.avatarFromCamera),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(context.l10n.avatarFromGallery),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) await _pickImage(source);
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final ok = await ensurePermission(
        context,
        Permission.camera,
        deniedMessage: context.l10n.cameraDenied,
      );
      if (!ok || !mounted) return;
    }

    final pickedFile = await ImagePicker().pickImage(
      source: source,
      imageQuality: 70,
      maxWidth: 1024,
    );

    if (pickedFile != null && mounted) {
      context.read<ProfileCubit>().uploadAvatar(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final (colors, l10n) = (context.appColors, context.l10n);

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: colors.onSurface),
      ),
      body: SafeArea(
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listenWhen: (prev, curr) =>
              curr.errorKey != null && curr.errorKey != prev.errorKey,
          listener: (context, state) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(l10n.errorUnknown)));
          },
          builder: (context, state) {
            final isLoading = state.isUpdating;
            final avatarSrc = state.user?.avatarSrc;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.profileSettingsHead,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl * 2),
                  child: Column(
                    spacing: AppSpacing.l,
                    children: [
                      GestureDetector(
                        onTap: isLoading ? null : _chooseSource,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: avatarSrc != null
                                  ? NetworkImage(avatarSrc)
                                  : null,
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : (avatarSrc == null
                                        ? Icon(
                                            Icons.person,
                                            size: 50,
                                            color: colors.onSurface,
                                          )
                                        : null),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: colors.surface,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: colors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _nameController,
                        enabled: !isLoading,
                        decoration: InputDecoration(hintText: l10n.nameHint),
                        keyboardType: TextInputType.name,
                      ),
                      TextField(
                        controller: _emailController,
                        enabled: !isLoading,
                        decoration: InputDecoration(hintText: l10n.emailHint),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        controller: _passwordController,
                        enabled: !isLoading,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: l10n.passwordHint,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.s),
                      PrimaryFilledButton(
                        onPressed: _submit,
                        label: l10n.saveButton,
                      ),
                      const SizedBox(height: AppSpacing.s),
                      CustomTextButton(
                        onPressed: () => context.read<AuthCubit>().logout(),
                        text: l10n.logoutButton,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
