import 'dart:async';

class BlocCancelToken {
  BlocCancelToken();

  bool _isCancelled = false;
  final _completer = Completer<void>();

  bool get isCancelled => _isCancelled;

  Future<void> get whenCancelled => _completer.future;

  void cancel() {
    if (_isCancelled) return;
    _isCancelled = true;
    _completer.complete();
  }
}
