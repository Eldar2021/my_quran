import 'package:flutter/material.dart';
import 'package:mq_app_ui/mq_app_ui.dart';

class ContactWhatsappButton extends StatelessWidget {
  const ContactWhatsappButton({this.labelText = 'Connect on WhatsApp', this.onPressed, super.key});

  final String labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.whatsapp),
      icon: Assets.icons.whatsapp.svg(),
      onPressed: onPressed,
      label: Text(labelText),
    );
  }
}

class ContactTelegramButton extends StatelessWidget {
  const ContactTelegramButton({this.labelText = 'Connect on Telegram', this.onPressed, super.key});

  final String labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.telegram),
      icon: Assets.icons.telegram.svg(),
      onPressed: onPressed,
      label: Text(labelText),
    );
  }
}

class ContactEmailButton extends StatelessWidget {
  const ContactEmailButton({this.labelText = 'Connect on Email', this.onPressed, super.key});

  final String labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
      icon: const Icon(Icons.email),
      onPressed: onPressed,
      label: Text(labelText),
    );
  }
}

class ContactGithubButton extends StatelessWidget {
  const ContactGithubButton({this.labelText = 'Connect on GitHub', this.onPressed, super.key});

  final String labelText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
      icon: Assets.icons.github.svg(colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
      onPressed: onPressed,
      label: Text(labelText),
    );
  }
}
