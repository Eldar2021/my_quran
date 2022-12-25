import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatim/app/app.dart';
import 'package:hatim/components/components.dart';
import 'package:hatim/models/models.dart';
import 'package:hatim/modules/modules.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
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
    final loginCubit = context.watch<LoginCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: controller,
            onPageChanged: context.read<LoginCubit>().change,
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
        CustomButton(
          text: loginCubit.state == 0 ? 'Next' : 'Start',
          onPressed: () async {
            if (loginCubit.state == 0) {
              context.read<LoginCubit>().change(1);
              await controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            } else {
              final user = User(gender: context.read<AppCubit>().state.gender);
              await context.read<AuthCubit>().login(user).whenComplete(
                    () => Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(builder: (context) => const MainView()),
                      (route) => false,
                    ),
                  );
            }
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
