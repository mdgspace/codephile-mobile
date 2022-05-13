import 'package:rxdart/rxdart.dart';

/// Provides a custom debounce BLoC transformer that waits till
/// 200ms of inactivity before processing/calling event handlers.
Stream<T> Function(Stream<T>, Stream<T> Function(T)) getDebounce<T>() {
  return (Stream<T> events, Stream<T> Function(T) mapper) {
    return events
        .debounceTime(const Duration(milliseconds: 200))
        .switchMap(mapper);
  };
}
