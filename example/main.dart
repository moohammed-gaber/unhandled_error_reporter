import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unhandled_error_reporter/unhandled_error_reporter.dart';

class Failure {}

class UnExpectedFailure extends Failure {}

class RiskLevelDeterminer implements IRiskLevelDeterminer {
  @override
  RiskLevel determine(ErrorDto error) {
    if (error.errorObject is UnExpectedFailure) {
      return RiskLevel.high;
    }
    return RiskLevel.low;
  }
}

class RemoteReporter extends IRemoteReporter {
  @override
  Future<void> report(UnhandledError error) async {
    super.report(error);
    print("Remote Monitor");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final errorCapture = ErrorCapture(RemoteReporter(), RiskLevelDeterminer());
  await errorCapture.init();
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = errorCapture.handleFlutterError;
    runApp(MyApp());
  }, errorCapture.handleAsyncDartError);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  void throwError() {
    throw UnExpectedFailure();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: throwError),
    );
  }
}
