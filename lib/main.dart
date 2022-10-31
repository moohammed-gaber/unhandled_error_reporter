import 'dart:async';

import 'package:error_monitoring/enums/risk_level_enum.dart';
import 'package:error_monitoring/error_capture.dart';
import 'package:error_monitoring/error_dto.dart';
import 'package:error_monitoring/remote_monitor.dart';
import 'package:error_monitoring/risk_level_determiner.dart';
import 'package:error_monitoring/thrown_api_error.dart';
import 'package:flutter/material.dart';

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
  final remoteReporter = RemoteReporter();
  final riskLevelDeterminer = RiskLevelDeterminer();
  final errorCapture = ErrorCapture(remoteReporter, riskLevelDeterminer);
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
      home: Scaffold(floatingActionButton: FloatingActionButton(onPressed: () {
        throwError();
      })),
    );
  }
}
