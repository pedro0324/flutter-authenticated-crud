import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviroment.dart';
import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:teslo_shop/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_tca_mapper.dart';
import 'package:encrypt/encrypt.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Enviroment.apiUrl,
  ));

  @override
  Future<UserTCA> checkingAuthStatus(String token) async {
    try {
      final response = await dio.get('/Cuentas/V1/ValidaToken?token=$token',
          // options: Options(headers: {
          //   'Authorization': 'Bearer $token',
          // })
          );

      final user = UserTCAMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) throw CustomError(e.response?.data);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Connection Timeout');
      }

      // error personalizado
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UserTCA> login(String user, String password) async {
    final String u = user;
    final String p = password;

    try {
      final dataBody = {
        "email": "cliente@hupapi.buap",
        "password": "2HiZ83yQU4LSH8YYgLw/6D6U79ZhD3VuaAgBF8CblmA=",
        "tcaUser": u,
        "tcaPwd": _fnEncrypt(p),
        "aplicacion": "codigoAlert"
      };

      final response = await dio.post('/Cuentas/V1/login', data: dataBody);

      final user = UserTCAMapper.userJsonToEntity(response.data);

      return user;
      // print(response);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) throw CustomError(e.response?.data);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Connection Timeout');
      }

      // error personalizado
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

//encryptacion de contraseña
  String _fnEncrypt(String pass) {
    final key = Key.fromUtf8("*UNA0lZyv\$2tR#o3u0YJ*1elhuopZ8a6");
    final iv =
        IV.fromLength(16); // Tamaño del vector de inicialización en bytes

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encrypter.encrypt(pass, iv: iv);

    return encrypted
        .base64; // Devuelve la representación en base64 del texto encriptado
  }
}
