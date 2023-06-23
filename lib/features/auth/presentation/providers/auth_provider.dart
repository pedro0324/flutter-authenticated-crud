import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/domain/repositories/auth_repository.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // repositorio de metodos para autenticacion
  final authRepository = AuthRepositoryImpl();

  //repositorio de metodos para guardar el token en el storage fisico
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String user, String password) async {
    // await Future.delayed(const Duration(milliseconds: 500));

    try {
      final userTca = await authRepository.login(user, password);
      _setLoggedUser(userTca);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
    // final user= await authRepository.login(email, password);
    // state=state.copyWith(authStatus, userTCA, errorMessage)
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout();

    try {
      final user = await authRepository.checkingAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(UserTCA user) async {
    await keyValueStorageService.setValueKey('token', user.token);

    state=state.copyWith(
      userTCA: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');

    //TODO: limpiar token
    state = state.copyWith(
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
