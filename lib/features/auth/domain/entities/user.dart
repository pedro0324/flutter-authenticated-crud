

class UserTCA {
  final String token;
  final String expiracion;
  final String nombreLargo;
  final String fecha;
  final List<dynamic> usuario;
  final String aplicacionLogin;
  final String agente;

  UserTCA({
    required this.token, 
    required this.expiracion, 
    required this.nombreLargo, 
    required this.fecha, 
    required this.usuario, 
    required this.aplicacionLogin, 
    required this.agente
  });
}
