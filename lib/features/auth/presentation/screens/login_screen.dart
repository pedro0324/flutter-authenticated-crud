import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/config/theme/app_theme.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
// import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/presentation/providers/login_form_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 200,
            ),
            const SizedBox(height: 80),
            Container(
              height: size.height - 260, // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [secundario, primario],
                  // center: Alignment.topCenter,
                  // startAngle: BorderSide.strokeAlignCenter
                  stops: [0.2, 0.8],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  // color: secundario,// color del box
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _LoginForm(),
            )
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text(
            'CODIGO ALERT',
            style: textStyles.titleLarge,
          ),
          const SizedBox(height: 90),
          CustomTextFormField(
            label: 'Usuario',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onUserChange,
            errorMessage: (loginForm.isFormPosted && loginForm.user.length < 3)
                ? 'Escriba mas de 3 caracteres'
                : null,
          ),
          const SizedBox(height: 40),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
            errorMessage:
                (loginForm.isFormPosted && loginForm.password.length < 3)
                    ? 'Escriba mas de 3 caracteres'
                    : null,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: Colors.blue.shade800,
              onPressed: () {
                ref.read(loginFormProvider.notifier).onFormSubmit();
              },
            ),
          ),
          const Spacer(flex: 2),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
