import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_tca_mapper.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.apiUrl,
  ));

  @override
  Future<UserTCA> checkingAuthStatus(String token) {
    // TODO: implement checkingAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<UserTCA> login(String email, String password) async {
    try {
      final response = await dio.post('/Cuentas/V1/login', data: {
        "email": "cliente@hupapi.buap",
        "password": "2HiZ83yQU4LSH8YYgLw/6D6U79ZhD3VuaAgBF8CblmA=",
        "tcaUser": "SISTEMA",
        "tcaPwd": "JRKo8q+Ltg7D4UABIPnm2A==",
        "aplicacion": "codigoAlert"
      });

      final user = UserTCAMapper.userJsonToEntity(response.data);

      return user;
      // print(response);
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
