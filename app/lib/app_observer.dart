import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver({this.onLog});

  final void Function(String log)? onLog;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    // onLog?.call('onEvent bloc: $bloc - event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    // onLog?.call('onCreate(${bloc.state})');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // onLog?.call('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    // onLog?.call('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    // onLog?.call('onClose(${bloc.runtimeType})');
  }
}
