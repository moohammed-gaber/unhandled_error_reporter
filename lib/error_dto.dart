

class ErrorDto {
  ErrorDto({required this.stackTrace, required this.errorObject});

  final StackTrace? stackTrace;
  final Object errorObject;
}
