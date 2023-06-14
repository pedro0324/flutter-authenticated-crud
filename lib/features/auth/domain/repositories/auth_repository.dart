
import 'package:teslo_shop/features/auth/domain/entities/user.dart';

//* casi lo muismo que en el data Sourc, exceptuando el nombre


abstract class AuthRepository {
  Future<UserTCA> login(String email, String password);

  Future<UserTCA> checkingAuthStatus(String token);
}
