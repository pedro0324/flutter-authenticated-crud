import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/domain/repositories/auth_repository.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastructure/repositories/auth_repository_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();

  return AuthNotifier(authRepository: authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on WrongCredentials{
      logout('Credenciales no son correctas');
    } catch (e) {
      logout('Error no controlado');
    }
    // final user= await authRepository.login(email, password);
    // state=state.copyWith(authStatus, userTCA, errorMessage)
  }

  void checkAuthStatus() {}

  void _setLoggedUser(UserTCA user) {
    // TODO: necesito guardar el token fisicamente
    state.copyWith(
      userTCA: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async {
    //TODO: limpiar token
    state.copyWith(
        authStatus: AuthStatus.noAuthenticated,
        userTCA: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus { checking, authenticated, noAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final UserTCA? userTCA;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.userTCA,
      this.errorMessage = ''});

  AuthState copyWith(
          {AuthStatus? authStatus, UserTCA? userTCA, String? errorMessage}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          userTCA: userTCA ?? this.userTCA,
          errorMessage: errorMessage ?? this.errorMessage);
}
