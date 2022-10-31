import 'dart:async';

import 'package:error_monitoring/error_dto.dart';
import 'package:error_monitoring/remote_monitor.dart';
import 'package:error_monitoring/risk_level_determiner.dart';
import 'package:error_monitoring/thrown_api_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorCapture {
  ErrorCapture(
    this._remoteMonitor,
    this._riskLevelDeterminer,
  ) {
    facade = UnhandledErrorFacade(_riskLevelDeterminer, _remoteMonitor);
  }

  Future<void> init() {
    return facade.init();
  }

  final IRiskLevelDeterminer _riskLevelDeterminer;
  final IRemoteReporter _remoteMonitor;
  late final UnhandledErrorFacade facade;

  Future<void> handleAsyncDartError(
    Object exception,
    StackTrace stackTrace,
  ) async {
    print("handle Async Dart Error");
    facade.monitor(ErrorDto(
      errorObject: exception,
      stackTrace: stackTrace,
    ));
  }

  Future<void> handleFlutterError(
    FlutterErrorDetails details,
  ) async {
    print("handle Flutter Error");
    final stackTrace = details.stack;
    final exception = details.exception;
    facade.monitor(ErrorDto(
      errorObject: exception,
      stackTrace: stackTrace,
    ));
  }
}
