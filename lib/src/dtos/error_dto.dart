import 'package:stack_trace/stack_trace.dart';

class ErrorDto {
  ErrorDto({required this.stackTrace, required this.errorObject});

  final StackTrace? stackTrace;
  final Object errorObject;

  List<Trace> getFormattedStackTrace() {
    return stackTrace == null ? [] : Chain.forTrace(stackTrace!).traces;
  }
}
