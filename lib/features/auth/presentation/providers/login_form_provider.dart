//* estado del provider
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
// import 'package:teslo_shop/features/shared/shared.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:formz/formz.dart';

//* statenotifierProvider
// * se coloca autodispose, para limitar el tiempo de vida de los datos del login
final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final String user;
  final String password;

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.user = '',
      this.password = '',
      });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    String? user,
    String? password,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        user: user ?? this.user,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
    LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    user: $user
    password: $password

''';
  }
}

//* notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;
  LoginFormNotifier({required this.loginUserCallback})
      : super(LoginFormState());

//se valida un maximo de 3 caracteres
  onUserChange(String value) {
    final newUser = value;
    state = state.copyWith(
        user: newUser, isValid: newUser.length > 3 ? true : false);
  }

//se valida un maximo de 3 caracteres
  onPasswordChange(String value) {
    final newPassword = value;
    state = state.copyWith(
        password: newPassword, isValid: newPassword.length > 3 ? true : false);
  }

  onFormSubmit() async {
    _touchEveryField();

    if (!state.isValid) return;

    // print(state);
    await loginUserCallback(state.user, state.password);
  }

//valida si se tocaron los campos
  _touchEveryField() {
    final userTCA = state.user;
    final password = state.password;

    state = state.copyWith(
      isFormPosted: true,
      user: userTCA,
      password: password,
      isValid: (userTCA.length > 3 && password.length > 3) ? true : false,
    );
  }
}
