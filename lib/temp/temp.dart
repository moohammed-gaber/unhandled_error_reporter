/*
/*
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://c03412bdda574f12a4cd8be817adae37@o4504074340139008.ingest.sentry.io/4504074347806720';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );
*/

  // or define SENTRY_DSN via Dart environment variable (--dart-define)

final transaction = Sentry.startTransaction('processOrderBatch()', 'task');

try {
  await processOrderBatch(transaction);
} catch (exception) {
  transaction.throwable = exception;
  transaction.status = SpanStatus.internalError();
} finally {
  await transaction.finish();
}

Future<void> processOrderBatch(ISentrySpan span) async {
  // span operation: task, span description: operation
  final innerSpan = span.startChild('task', description: 'operation');

  try {
    // omitted code
  } catch (exception) {
    innerSpan.throwable = exception;
    innerSpan.status = SpanStatus.notFound();
  } finally {
    await innerSpan.finish();
  }
}
/*
  final factory = MonitorDeviceFactory(DeviceInfoPlugin());
  final deviceInfo = await factory.create('android').getDeviceInfo();

  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails details) {
      final stackTrace = details.stack;
      final exception = details.exception;
      final message = details.toString();
      final data = ErrorDto(
          deviceInfo: deviceInfo, failure: exception, stackTrace: stackTrace);
      final riskLevelDeterminer = RiskLevelDeterminer(data: data);
      final monitor = ReporterFacade(data, riskLevelDeterminer);
      final remoteMonitor = RemoteMonitor(dio: Dio(), monitor: monitor);
      remoteMonitor.send();
      print("Error From INSIDE FRAME_WORK");
      print("----------------------");
      print("Error :  ${details.exception}");
      print("StackTrace :  ${details.stack}");
    };

    runApp(MyApp());
  }, (exception, stackTrace) async {
    print('Error From OUTSIDE FRAME_WORK');
    print(stackTrace);
  });
}
*/

 */
