import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/pulso_checkbox_label.dart';
import '../../../../shared/widgets/pulso_logo.dart';
import '../../../../shared/widgets/pulso_primary_button.dart';
import '../../../../shared/widgets/pulso_social_button.dart';
import '../../../../shared/widgets/pulso_text_field.dart';
import '../controllers/login_controller.dart';

/// Tela de login do app PULSO.
/// A navegação é controlada automaticamente pelo GoRouter através do
/// estado de autenticação do Firebase.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(loginControllerProvider.notifier).submit(
          _emailController.text.trim(),
          _passwordController.text,
        );

    if (!success && mounted) {
      final message = ref.read(loginControllerProvider).errorMessage;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message ?? 'Não foi possível entrar.',
          ),
        ),
      );
    }

    // Não há navegação aqui.
    // O GoRouter detecta automaticamente quando o usuário é autenticado
    // e redireciona para a Home.
  }

  Future<void> _handleGoogleLogin() async {
    final success =
        await ref.read(loginControllerProvider.notifier).submitWithGoogle();

    if (!success && mounted) {
      final message = ref.read(loginControllerProvider).errorMessage;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message ?? 'Não foi possível entrar com o Google.',
          ),
        ),
      );
    }

    // O GoRouter fará o redirecionamento automaticamente.
  }

  Future<void> _handleAppleLogin() async {
    final success =
        await ref.read(loginControllerProvider.notifier).submitWithApple();

    if (!success && mounted) {
      final message = ref.read(loginControllerProvider).errorMessage;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message ?? 'Não foi possível entrar com a Apple.',
          ),
        ),
      );
    }

    // O GoRouter fará o redirecionamento automaticamente.
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.ink,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    const PulsoLogo(
                      iconSize: 56,
                      wordmarkFontSize: 30,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'entre na sua conta',
                      textAlign: TextAlign.center,
                      style: AppTypography.subtitle,
                    ),
                    const SizedBox(height: 36),
                    PulsoTextField(
                      controller: _emailController,
                      label: 'E-mail',
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: 12),
                    PulsoTextField(
                      controller: _passwordController,
                      label: 'Senha',
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      validator: Validators.password,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        PulsoCheckboxLabel(
                          value: loginState.rememberMe,
                          label: 'Lembrar de mim',
                          onChanged: (_) {
                            ref
                                .read(loginControllerProvider.notifier)
                                .toggleRememberMe();
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Recuperação de senha.
                          },
                          child: const Text(
                            'Esqueci minha senha',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    PulsoPrimaryButton(
                      label: 'Entrar',
                      isLoading: loginState.isSubmitting,
                      onPressed: _handleLogin,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.inputBorder,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Text(
                            'ou',
                            style: AppTypography.bodySecondary,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.inputBorder,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PulsoSocialButton(
                      label: 'Continuar com Google',
                      icon: const _GoogleGlyph(),
                      onPressed: _handleGoogleLogin,
                    ),
                    const SizedBox(height: 12),
                    PulsoSocialButton(
                      label: 'Continuar com Apple',
                      icon: const Icon(
                        Icons.apple,
                        size: 20,
                        color: AppColors.paper,
                      ),
                      onPressed: _handleAppleLogin,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'não tem conta?',
                          style: AppTypography.bodySecondary,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Tela de cadastro.
                          },
                          child: const Text(
                            'Criar conta',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Glifo simples representando o Google.
/// Substituir pelo asset oficial antes da publicação.
class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.paper,
      ),
      child: Text(
        'G',
        style: AppTypography.button.copyWith(
          fontSize: 12,
          color: AppColors.ink,
        ),
      ),
    );
  }
}
