import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';

import 'dialog_helper.dart';

class SentryHelper {
  static Future<void> logExceptionInSentry(
      Object exception, StackTrace stackTrace, methodName, message,
      {bool showAlert = false}) async {
    try {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        hint: Hint(),
      );
      await Sentry.captureMessage("$message $methodName");
      if (showAlert) {
        DialogHelper.showLoading(message);
      }
    } catch (e) {
      //
    }
  }

  static FutureOr<SentryEvent?> beforeSend(SentryEvent event,
      {Hint? hint}) async {
    event = event.copyWith(serverName: null); //
    return event;
  }

  static const String _fallbackSentryDsn =
      'https://60c5ee04b8234df2b09f211dd949491b@o1352314.ingest.sentry.io/6702676';
  static Future<void> sentryFlutterInit(runnApp) async {
    await SentryFlutter.init(
      (options) {
        options.dsn = _fallbackSentryDsn;
        options.beforeSend = SentryHelper.beforeSend;
      },
      appRunner: () => runnApp(),
    );
  }
}
