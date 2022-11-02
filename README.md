# Unhandled Error Reporter

[![Pub](https://img.shields.io/pub/v/before_publish_cli.svg)](https://pub.dev/packages/unhandled_error_reporter)

### Report Any unhandled exception/error/failure to backend service as [ stacktrace, Device information, Risk level of this error ]

## Let's Discover It

**First create class that's send error to server**

```dart
class RemoteReporter extends IRemoteReporter {
  @override
  // any uncaught error will be on this object
  Future<void> report(UnhandledError error) async {
    // call super if you want print [error] on the console
    super.report(error);
    // Api call that's send error to backend should write there.
  }
}
```

**Second is creating class that's determine risk level of error**

```dart
class RiskLevelDeterminer implements IRiskLevelDeterminer {
  @override
  RiskLevel determine(ErrorDto error) {
    if (error.errorObject is UnExpectedFailure) {
      return RiskLevel.high;
    }

    return RiskLevel.low;
  }
}
```

**Finally main function should be like this :-**

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // objects from class we created before
  final remoteReporter = RemoteReporter();
  final riskLevelDeterminer = RiskLevelDeterminer();
  final errorCapture = ErrorCapture(remoteReporter, riskLevelDeterminer);
  // should call init
  await errorCapture.init();
  // our flutter handler 
  FlutterError.onError = errorCapture.handleFlutterError;
  // our dart error handler 
  PlatformDispatcher.instance.onError = (error, stack) {
    errorCapture.handleAsyncDartError(error, stack);
    return true;
  };
  runApp(MyApp());

}
```

## Buy me a coffee

<a href="https://www.buymeacoffee.com/mogaber" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>
