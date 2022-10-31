import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:error_monitoring/enums/platform.dart';
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

class BaseDeviceInformation<T extends BaseDeviceInfo> {
  final T deviceInfo;
  final DevicePlatform devicePlatform;

  BaseDeviceInformation(
      {required this.deviceInfo, required this.devicePlatform});
}

abstract class DeviceInfo<T extends BaseDeviceInfo> {
  final DeviceInfoPlugin deviceInfoPlugin;

  DeviceInfo(this.deviceInfoPlugin);

  Future<BaseDeviceInformation<T>> getDeviceInfo();
}

class AndroidDeviceInformation extends DeviceInfo<AndroidDeviceInfo> {
  AndroidDeviceInformation(super.deviceInfoPlugin);

  @override
  Future<BaseDeviceInformation<AndroidDeviceInfo>> getDeviceInfo() async {
    final result = await deviceInfoPlugin.androidInfo;
    return BaseDeviceInformation(
        deviceInfo: result, devicePlatform: DevicePlatform.android);
  }
}

class WebDeviceInformation extends DeviceInfo<WebBrowserInfo> {
  WebDeviceInformation(super.deviceInfoPlugin);

  @override
  Future<BaseDeviceInformation<WebBrowserInfo>> getDeviceInfo() async {
    final result = await deviceInfoPlugin.webBrowserInfo;
    return BaseDeviceInformation(
        deviceInfo: result, devicePlatform: DevicePlatform.web);
  }
}

class IosDeviceInformation extends DeviceInfo<IosDeviceInfo> {
  IosDeviceInformation(super.deviceInfoPlugin);

  @override
  Future<BaseDeviceInformation<IosDeviceInfo>> getDeviceInfo() async {
    final result = await deviceInfoPlugin.iosInfo;
    return BaseDeviceInformation(
        deviceInfo: result, devicePlatform: DevicePlatform.ios);
  }
}
