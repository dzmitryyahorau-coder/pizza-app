import 'package:flutter/material.dart';
import 'package:pizza_app/core/theme/app_theme.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_header.dart';
import 'package:pizza_app/features/menu/presentation/widgets/menu_sheet.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: SafeArea(child: Column(children: [MenuHeader(), MenuSheet()])),
    );
  }
}
