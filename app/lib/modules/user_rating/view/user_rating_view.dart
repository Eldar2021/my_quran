import 'package:flutter/material.dart';

class UserRatingView extends StatefulWidget {
  const UserRatingView({super.key});

  @override
  State<UserRatingView> createState() => _UserRatingViewState();
}

class _UserRatingViewState extends State<UserRatingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Rating'),
      ),
      body: const Center(
        child: Text('User Rating'),
      ),
    );
  }
}
