import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_quran/src/src.dart';


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
    _controller.text = apiConst.devDomain ?? '';
    isDevMode = apiConst.isDevmode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enable/Disable dev-mode'),
      ),
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
              final appConfig = context.read<AppConfig>();
              await appConfig.setDevMode(
                devDomain: _controller.text,
                isDevmode: isDevMode,
              );
              if (context.mounted) {
                AppAlert.showRestartDialog(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
