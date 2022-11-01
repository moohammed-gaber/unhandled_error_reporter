import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:unhandled_error_reporter/src/enums/platform.dart';
import 'package:flutter/foundation.dart';

class MonitorDeviceFactory {
  final DeviceInfoPlugin _deviceInfoPlugin;

  MonitorDeviceFactory(this._deviceInfoPlugin);

  DeviceInfo create() {
    if (kIsWeb) {
      return WebDeviceInformation(_deviceInfoPlugin);
    } else if (Platform.isAndroid) {
      return AndroidDeviceInformation(_deviceInfoPlugin);
    } else if (Platform.isIOS) {
      return IosDeviceInformation(_deviceInfoPlugin);
    } else {
      throw UnimplementedError();
    }
  }
}

enum DeviceType {
  emulator,
  physical,
  jailbroken,
}

class BaseDeviceInformation<T extends BaseDeviceInfo> {
  final T deviceInfo;
  final DevicePlatform platform;
  final bool isUnlocked;

  BaseDeviceInformation(
      {required this.deviceInfo,
      required this.isUnlocked,
      required this.platform});
}

abstract class DeviceInfo<T extends BaseDeviceInfo> {
  final DeviceInfoPlugin deviceInfoPlugin;

  DeviceInfo(this.deviceInfoPlugin);

  Future<BaseDeviceInformation<T>> getDeviceInfo();

  Future<bool> isUnlocked() =>
      FlutterJailbreakDetection.jailbroken; // android only.

}

class AndroidDeviceInformation extends DeviceInfo<AndroidDeviceInfo> {
  AndroidDeviceInformation(super.deviceInfoPlugin);

  @override
  Future<BaseDeviceInformation<AndroidDeviceInfo>> getDeviceInfo() async {
    final result = await deviceInfoPlugin.androidInfo;
    return BaseDeviceInformation(
        isUnlocked: await isUnlocked(),
        deviceInfo: result,
        platform: DevicePlatform.android);
  }
}

class WebDeviceInformation extends DeviceInfo<WebBrowserInfo> {
  WebDeviceInformation(super.deviceInfoPlugin);

  @override
  Future<BaseDeviceInformation<WebBrowserInfo>> getDeviceInfo() async {
    final result = await deviceInfoPlugin.webBrowserInfo;
    return BaseDeviceInformation(
        isUnlocked: await isUnlocked(),
        deviceInfo: result,
        platform: DevicePlatform.web);
  }

  @override
  Future<bool> isUnlocked() => Future.value(false); // android only.

}

class IosDeviceInformation extends DeviceInfo<IosDeviceInfo> {
  IosDeviceInformation(super.deviceInfoPlugin);

  @override
  Future<BaseDeviceInformation<IosDeviceInfo>> getDeviceInfo() async {
    final result = await deviceInfoPlugin.iosInfo;
    return BaseDeviceInformation(
        isUnlocked: await isUnlocked(),
        deviceInfo: result,
        platform: DevicePlatform.ios);
  }
}
