import 'package:flutter/material.dart';

/*
{
  "first_name": "Eldiiar",
  "last_name": "Almazbek",
  "username": "eldiiar",
  "avatar": "https://lh3.",
  "email": "eldiiaralmazbekov@gmail.com",
  "country": null,
  "phone_number": null,
  "gender": "male",
  "language": "ky",
  "can_create_hatim": true, // Done
  "allow_notifications": true, // Done
  "timezone": "Asia/Bishkek"
}
*/
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile'),
      ),
    );
  }
}
