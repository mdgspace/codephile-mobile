import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    log(
      '[BLOC] [CREATE] ${bloc.runtimeType}',
    );
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      '[BLOC] [EVENT] ${bloc.runtimeType} $event',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log(
      '[BLOC] [CHANGE] ${bloc.runtimeType} '
      '{ currentState: ${change.currentState}, '
      'nextState: ${change.nextState} }',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      log(
        '[BLOC] [ERROR] ${bloc.runtimeType}\n'
        'Error: $error\n'
        'Stacktrace: $stackTrace',
      );
    } else {
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
        hint: bloc.runtimeType.toString(),
      );
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    log(
      '[BLOC] [CLOSE] ${bloc.runtimeType}',
    );
    super.onClose(bloc);
  }
}
