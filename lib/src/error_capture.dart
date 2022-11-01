import 'dart:async';

import 'package:unhandled_error_reporter/src/dtos/error_dto.dart';
import 'package:unhandled_error_reporter/src/interfaces/remote_monitor.dart';
import 'package:unhandled_error_reporter/src/interfaces/risk_level_determiner.dart';
import 'package:unhandled_error_reporter/src/facades/unhandled_error_facade.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorCapture {
  ErrorCapture(
    this._remoteMonitor,
    this._riskLevelDeterminer,
  ) {
    facade = UnhandledErrorFacade(_riskLevelDeterminer, _remoteMonitor);
  }
  final IRiskLevelDeterminer _riskLevelDeterminer;
  final IRemoteReporter _remoteMonitor;
  late final UnhandledErrorFacade facade;


  Future<void> init() {
    return facade.init();
  }

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
