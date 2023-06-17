import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_quran/components/button/custom_button.dart';
import 'package:my_quran/constants/assets/assets.gen.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/theme/custom/typography/typography_theme.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Assets.images.splash.image(),
          ),
          const SizedBox(height: 12),
          Text(context.l10n.welcome, style: context.titleLarge!.copyWith(color: context.colors.primary, fontSize: 50)),
          const SizedBox(height: 30),
          CustomButtonWithIcon(
            icon: const Icon(FontAwesomeIcons.google),
            onPressed: () {},
            text: context.l10n.google,
          ),
          const SizedBox(height: 30),
          Text(
            context.l10n.orsigninwith,
            textAlign: TextAlign.center,
            style: context.bodyLarge!.copyWith(color: context.colors.shadow, fontSize: 17),
          ),
          const SizedBox(height: 33),
          CustomButtonWithIcon(
            icon: const Icon(FontAwesomeIcons.apple),
            onPressed: () {},
            text: context.l10n.apple,
          ),
          const SizedBox(height: 90),
          CustomButton(onPressed: () {}, text: context.l10n.signinwithoutanaccount),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              context.l10n.privacypolicy,
              style: context.bodyLarge!.copyWith(
                color: context.colors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
