class ApiException implements Exception{
  String errorTitle;
  String errorMessage;
  ApiException({required this.errorMessage, required this.errorTitle});

  @override
  String toString() {
    return "$errorTitle : $errorMessage";
  }
}

class BadRequestException extends ApiException{
  BadRequestException({required super.errorMessage}) : super(errorTitle: "Bad Request");
}
class NoInternetException extends ApiException{
  NoInternetException({required super.errorMessage}) : super(errorTitle: "No Internet");
}
class UnauthorizedException extends ApiException{
  UnauthorizedException({required super.errorMessage}) : super(errorTitle: "Unauthorized error");
}
class InvalidInputException extends ApiException{
  InvalidInputException({required super.errorMessage}) : super(errorTitle: "Invalid Input");
}
class FetchDataException extends ApiException{
  FetchDataException({required super.errorMessage}) : super(errorTitle: "Error during communication");
}