import 'package:teslo_shop/features/auth/domain/entities/user.dart';

class UserTCAMapper {
  static UserTCA userJsonToEntity(Map<String, dynamic> json) => UserTCA(
      token: json['token'],
      expiracion: json['expiracion'],
      nombreLargo: json['nombreLargo'],
      fecha: json['fecha'],
      perfiles: List<dynamic>.from(json['usuario']['perfiles']),
      permisos: List<dynamic>.from(json['usuario']['permisos']),
      aplicacionLogin: json['aplicacionLogin'],
      agente: json['agente']
      );
}
