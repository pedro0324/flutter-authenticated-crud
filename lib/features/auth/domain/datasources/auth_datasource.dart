
import 'package:teslo_shop/features/auth/domain/entities/user.dart';

abstract class AuthDataSource {
  Future<UserTCA> login(String email, String password);

  Future<UserTCA> checkingAuthStatus(String token);
}
