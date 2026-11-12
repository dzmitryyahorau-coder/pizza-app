import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pizza_app/core/l10n_x.dart';
import 'package:pizza_app/core/theme/app_colors.dart';
import 'package:pizza_app/core/theme/app_spacing.dart';
import 'package:pizza_app/features/auth/bloc/auth_cubit.dart';
import 'package:pizza_app/features/auth/bloc/auth_state.dart';
import 'package:pizza_app/shared/widgets/custom_text_button.dart';
import 'package:pizza_app/shared/widgets/primary_filled_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    context.read<AuthCubit>().login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final (colors, l10n) = (context.appColors, context.l10n);

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              String errorMessage = l10n.errorUnknown;

              if (state.messageKey == 'errorEmptyFields') {
                errorMessage = l10n.errorEmptyFields;
              } else if (state.messageKey == 'errorInvalidCredentials') {
                errorMessage = l10n.errorInvalidCredentials;
              }

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(errorMessage)));
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.loginTitle,
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
                        label: l10n.loginButton,
                      ),
                      const SizedBox(height: AppSpacing.s),
                      CustomTextButton(
                        onPressed: () => context.go('/register'),
                        text: l10n.registerButton,
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
