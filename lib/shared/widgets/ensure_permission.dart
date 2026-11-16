import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pizza_app/core/di/locator.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/shared/service/permission_handler.dart';

Future<bool> ensurePermission(
  BuildContext context,
  Permission permission, {
  required String deniedMessage,
}) async {
  final result = await sl<PermissionHandler>().request(permission);
  if (!context.mounted) return false;

  final l10n = context.l10n;

  switch (result) {
    case PermissionResult.granted:
      return true;

    case PermissionResult.denied:
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(deniedMessage)));
      return false;

    case PermissionResult.permanentlyDenied:
      await _showSettingsDialog(context);
      return false;

    case PermissionResult.restricted:
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.permissionRestrictedTitle),
          content: Text(l10n.permissionRestrictedMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.ok),
            ),
          ],
        ),
      );
      return false;
  }
}

Future<void> _showSettingsDialog(BuildContext context) async {
  final l10n = context.l10n;

  final openSettings = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.permissionDeniedTitle),
      content: Text(l10n.permissionDeniedMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(l10n.openSettings),
        ),
      ],
    ),
  );

  if (openSettings == true) {
    await openAppSettings();
  }
}
