import 'package:device_info_plus/device_info_plus.dart';
import 'package:unhandled_error_reporter/src/device_info/device_info.dart';
import 'package:unhandled_error_reporter/src/enums/platform.dart';
import 'package:unhandled_error_reporter/src/enums/risk_level_enum.dart';
import 'package:unhandled_error_reporter/src/dtos/error_dto.dart';
import 'package:unhandled_error_reporter/src/interfaces/remote_monitor.dart';
import 'package:unhandled_error_reporter/src/interfaces/risk_level_determiner.dart';

class UnhandledErrorFacade {
  UnhandledErrorFacade(
    this._riskLevelDeterminer,
    this._remoteMonitor,
  );

  final IRemoteReporter _remoteMonitor;

  final IRiskLevelDeterminer _riskLevelDeterminer;

  late final DeviceInfo _deviceInformation;
  late final BaseDeviceInformation _deviceInfo;
  late final Versions? versions;

  Future<void> init({Versions? versions}) async {
    _deviceInformation = MonitorDeviceFactory(DeviceInfoPlugin()).create();
    _deviceInfo = await _deviceInformation.getDeviceInfo();
    this.versions = versions;
  }

  UnhandledError get(
    ErrorDto error,
  ) {
    final riskLevel = _riskLevelDeterminer.determine(error);
    return UnhandledError(
        versions: versions,
        deviceInfo: _deviceInfo,
        platform: _deviceInfo.platform,
        riskLevel: riskLevel,
        errorDto: error);
  }

  Future<void> monitor(ErrorDto error) {
    return _remoteMonitor.report(get(error));
  }
}

class Versions {
  final String? app;
  final String? backend;
  final String? sqlite;

  Versions({this.app, this.backend, this.sqlite});
}

class UnhandledError {
  final ErrorDto errorDto;
  final DevicePlatform platform;
  final RiskLevel riskLevel;
  final BaseDeviceInformation deviceInfo;
  final Versions? versions;

  UnhandledError(
      {required this.platform,
      required this.riskLevel,
      required this.versions,
      required this.deviceInfo,
      required this.errorDto});

  Map<String, dynamic> toJson() => {
        'stackTrace': errorDto.stackTrace,
        'deviceInfo': deviceInfo.data,
        'failure': errorDto.errorObject,
        'riskLevel': riskLevel.name,
        'platform': platform,
      };
}
