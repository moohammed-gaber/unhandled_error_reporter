import 'package:stack_trace/stack_trace.dart';
import 'package:unhandled_error_reporter/src/enums/error_from.dart';

class ErrorDto {
  ErrorDto(
      {required this.stackTrace, required this.errorFrom, required this.errorObject});

  final ErrorFrom errorFrom;
  final StackTrace? stackTrace;
  final Object errorObject;

  List<String> getFormattedStackTrace() {
    return stackTrace == null
        ? []
        : Chain.forTrace(stackTrace!).traces.map((e) => e.toString()).toList();
  }
}
