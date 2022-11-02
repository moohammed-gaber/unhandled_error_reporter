import 'package:stack_trace/stack_trace.dart';
import 'package:unhandled_error_reporter/src/enums/error_from.dart';

class ErrorDto {
  ErrorDto(
      {required this.stackTrace,
      required this.errorFrom,
      required this.errorObject});

  final ErrorFrom errorFrom;
  final StackTrace? stackTrace;
  final Object errorObject;

  List<Map> getFormattedStackTrace() {
    return stackTrace == null
        ? []
        : Trace.from(stackTrace!).frames.map((e) {
            return {
              'column': e.column,
              'library': e.library,
              'location': e.location,
              'isCore': e.isCore,
              'line': e.line,
              'member': e.member,
              'uri': e.uri.toString(),
              'package': e.package,
            };
          }).toList();
  }
}
