import 'package:flutter/material.dart';

mixin AppLifeCycleStateMixin<T extends StatefulWidget> on State<T>, WidgetsBindingObserver {
  void Function()? onAppLifeCycleResumed;
  void Function()? onAppLifeCyclePaused;
  void Function()? onAppLifeCycleInactive;
  void Function()? onAppLifeCycleDetached;
  void Function()? onAppLifeCycleHidden;

  void initAppLifeCycle() {
    WidgetsBinding.instance.addObserver(this);
  }

  void disposeAppLifeCycle() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    return switch (state) {
      AppLifecycleState.detached => onAppLifeCycleDetached?.call(),
      AppLifecycleState.inactive => onAppLifeCycleInactive?.call(),
      AppLifecycleState.paused => onAppLifeCyclePaused?.call(),
      AppLifecycleState.resumed => onAppLifeCycleResumed?.call(),
      AppLifecycleState.hidden => onAppLifeCycleHidden?.call(),
    };
  }
}
