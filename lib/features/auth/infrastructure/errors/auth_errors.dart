//error de credenciales
class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

class ConnectionTimeOut implements Exception {}

class CustomError implements Exception {
  final String message;


  CustomError(this.message);

}
