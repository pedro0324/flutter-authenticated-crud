import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/domain/repositories/auth_repository.dart';
import 'package:teslo_shop/features/auth/infrastructure/datasources/auth_datasource_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  //si existe el data source, solo ocupalo, no lo reemplaces
  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<UserTCA> checkingAuthStatus(String token) {
    return dataSource.checkingAuthStatus(token);
  }

  @override
  Future<UserTCA> login(String email, String password) {
    return dataSource.login(email, password);
  }
}
