import 'dart:developer';

import 'package:unhandled_error_reporter/src/facades/unhandled_error_facade.dart';


// final Dio dio;
class IRemoteReporter {
  IRemoteReporter();

  Future<void> report(UnhandledError reportedData) async {
    log('Hi iam Function that monitor error to backend');
    log('Here is Failure ${reportedData.errorDto.errorObject}');
    log('Here is riskLevel ${reportedData.riskLevel}');
    log('Here is platform ${reportedData.deviceInfo.platform.name}');
    log('Here is DeviceInfo data ${reportedData.deviceInfo.deviceInfo.data}');
    log('Here is StackTrace ${reportedData.errorDto.stackTrace}');

    return Future.value();
  }
}
