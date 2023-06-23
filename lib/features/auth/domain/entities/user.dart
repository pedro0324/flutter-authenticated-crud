

class UserTCA {
  final String token;
  final String expiracion;
  final String nombreLargo;
  final String fecha;
  final List<dynamic> permisos;
  final List<dynamic> perfiles;
  final String aplicacionLogin;
  final String? agente;

  UserTCA({
    required this.token, 
    required this.expiracion, 
    required this.nombreLargo, 
    required this.fecha, 
    required this.permisos, 
    required this.perfiles, 
    required this.aplicacionLogin, 
    this.agente=''
  });
}
