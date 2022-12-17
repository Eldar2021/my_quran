import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatim/app/app.dart';
import 'package:hatim/components/components.dart';

import 'package:hatim/models/user/user_model.dart';
import 'package:hatim/modules/home/home.dart';
import 'package:hatim/modules/modules.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // final appCubit = context.watch<AppCubit>();
    // final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginBody(PageController()),
          ),
        ),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody(this.controller, {super.key});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final appCubit = context.watch<AppCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: controller,
            children: const [
              SelectLang(),
              SelectGender(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        DotsIndicator(
          controller: controller,
          itemCount: 2,
          maxZoom: 1.3,
          dotSize: 4.1,
          space: 15,
          activeColor: colorScheme.primary,
          disactiveColor: colorScheme.secondary,
        ),
        const SizedBox(height: 20),
        const CustomButton(),
        const SizedBox(height: 20),
        // const SizedBox(height: 50),
        // ElevatedButton(
        //   key: const Key('start-login'),
        //   child: const Text('Start'),
        //   onPressed: () async {
        //     // final user = User(gender: context.read<AuthCubit>().state.gender);
        //     // await context.read<AuthCubit>().login(user).whenComplete(
        //     //       () => Navigator.pushAndRemoveUntil<void>(
        //     //         context,
        //     //         MaterialPageRoute<void>(builder: (context) => const HomeView()),
        //     //         (route) => false,
        //     //       ),
        //     //     );
        //   },
        // ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text = 'Button',
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
        foregroundColor: colorScheme.onPrimary,
        textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}
