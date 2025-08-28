import 'dart:async';
import 'dart:js_interop';

@JS()
@staticInterop
class JSPromise {}

extension JSPromiseExtension on JSPromise {
  external JSPromise then(
    JSFunction onFulfilled,
    JSFunction onRejected,
  );
}

/// Converts a JS Promise to a Dart Future<T>
extension ThenableHandler on JSPromise {
  Future<T> handleThenable<T>() {
    final completer = Completer<T>();

    final onFulfilled = (JSAny? result) {
      completer.complete(result as T);
    }.toJS;

    final onRejected = (JSAny? error) {
      completer.completeError(error ?? 'Unknown error');
    }.toJS;

    then(onFulfilled, onRejected);

    return completer.future;
  }
}
