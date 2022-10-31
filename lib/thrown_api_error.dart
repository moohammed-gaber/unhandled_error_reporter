import 'package:device_info_plus/device_info_plus.dart';
import 'package:error_monitoring/device_info.dart';
import 'package:error_monitoring/enums/platform.dart';
import 'package:error_monitoring/enums/risk_level_enum.dart';
import 'package:error_monitoring/error_dto.dart';
import 'package:error_monitoring/remote_monitor.dart';
import 'package:error_monitoring/risk_level_determiner.dart';

class UnhandledErrorFacade {
  UnhandledErrorFacade(
    this._riskLevelDeterminer,
    this._remoteMonitor,
  );

  final IRemoteReporter _remoteMonitor;

  final IRiskLevelDeterminer _riskLevelDeterminer;

  late final DeviceInfo _deviceInformation;
  late final BaseDeviceInformation _deviceInfo;

  Future<void> init() async {
    _deviceInformation = MonitorDeviceFactory(DeviceInfoPlugin()).create();
    _deviceInfo = await _deviceInformation.getDeviceInfo();
  }

  UnhandledError get(
    ErrorDto error,
  ) {
    final riskLevel = _riskLevelDeterminer.determine(error);
    return UnhandledError(
        deviceInfo: _deviceInfo.deviceInfo,
        platform: _deviceInfo.devicePlatform,
        riskLevel: riskLevel,
        errorDto: error);
  }

  monitor(ErrorDto error) {
    return _remoteMonitor.report(get(error));
  }
}

class UnhandledError {
  final ErrorDto errorDto;
  final DevicePlatform platform;
  final RiskLevel riskLevel;
  final BaseDeviceInfo deviceInfo;

  UnhandledError(
      {required this.platform,
      required this.riskLevel,
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
