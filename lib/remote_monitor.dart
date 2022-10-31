import 'dart:developer';

import 'package:error_monitoring/thrown_api_error.dart';


// final Dio dio;
class IRemoteReporter {
  IRemoteReporter();

  Future<void> report(UnhandledError reportedData) async {
    log('Hi iam Function that monitor error to backend');
    log('Here is Failure ${reportedData.errorDto.errorObject}');
    log('Here is riskLevel ${reportedData.riskLevel}');
    log('Here is platform ${reportedData.platform}');
    log('Here is DeviceInfo ${reportedData.deviceInfo.data}');
    log('Here is StackTrace ${reportedData.errorDto.stackTrace}');

    return Future.value();
  }
}
