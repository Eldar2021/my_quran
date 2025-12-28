import 'package:flutter/material.dart';

class ProfileEditPhoneNumberView extends StatefulWidget {
  const ProfileEditPhoneNumberView(this.initialValue, {super.key});

  final String initialValue;

  @override
  State<ProfileEditPhoneNumberView> createState() => _ProfileEditPhoneNumberViewState();
}

class _ProfileEditPhoneNumberViewState extends State<ProfileEditPhoneNumberView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
