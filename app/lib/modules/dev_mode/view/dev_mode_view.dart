import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_analytics/mq_analytics.dart';
import 'package:mq_crashlytics/mq_crashlytics.dart';
import 'package:my_quran/config/app_config.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/utils/show/alerts.dart';

class DevModeView extends StatefulWidget {
  const DevModeView({super.key});

  @override
  State<DevModeView> createState() => _DevModeViewState();
}

class _DevModeViewState extends State<DevModeView> {
  final _controller = TextEditingController();
  bool isDevMode = false;

  @override
  void initState() {
    _controller.text = context.read<AppConfig>().devDomain;
    isDevMode = context.read<AppConfig>().isDevMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DevMode')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 30),
          TextFormField(controller: _controller),
          const SizedBox(height: 20),
          Card(
            child: SwitchListTile.adaptive(
              title: const Text('Enable/Disable dev-mode'),
              value: isDevMode,
              onChanged: (v) {
                setState(() {
                  isDevMode = v;
                });
              },
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              MqAnalytic.track(
                AnalyticKey.selectDevMode,
                params: {'devDomain': _controller.text, 'isDevMode': isDevMode},
              );
              final appConfig = context.read<AppConfig>();
              await appConfig.setDevMode(devDomain: _controller.text, isDevmode: isDevMode);
              if (context.mounted) {
                AppAlert.showRestartDialog(context);
              }
            },
            child: Text(context.l10n.save),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              MqCrashlytics.report(Exception('Test report Error'), StackTrace.current);
              MqCrashlytics.recordFlutterError(
                FlutterErrorDetails(exception: Exception('Test recordFlutterError Error')),
              );
              await MqCrashlytics.setUserIdentifier('Test Eldiiar');
              MqAnalytic.track(AnalyticKey.test, params: {'Tested By': 'Eldiiar'});
            },
            child: Text(context.l10n.testCrashlyticsAnalytics),
          ),
        ],
      ),
    );
  }
}
