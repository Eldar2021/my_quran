import 'package:flutter/material.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(MqKeys.search),
      appBar: AppBar(
        title: const Text(
          // context.l10n.hatim,
          'Add participants',
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Search Page')),
    );
  }
}
