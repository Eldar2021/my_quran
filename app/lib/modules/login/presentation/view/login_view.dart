import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/components/components.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';


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
              SelectLang(key: Key(MqKeys.loginSelectLeng)),
              SelectGender(key: Key(MqKeys.loginSelectGender)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onLongPress: () => context.pushNamed(AppRouter.devModeView),
          child: DotsIndicator(
            controller: controller,
            itemCount: 2,
            maxZoom: 1.3,
            dotSize: 4.1,
            space: 15,
            activeColor: colorScheme.primary,
            disactiveColor: colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          key: const Key(MqKeys.loginNext),
          text: loginCubit.state == 0 ? context.l10n.next : context.l10n.start,
          onPressed: () async {
            if (loginCubit.state == 0) {
              context.read<LoginCubit>().change(1);
              await controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            } else {
              unawaited(AppAlert.showLoading<void>(context));
              await context
                  .read<AuthCubit>()
                  .login(
                    context.read<AppCubit>().state.currentLocale.languageCode,
                    context.read<AppCubit>().state.gender,
                  )
                  .then((value) async {
                context.pop();
                if (value.user != null) {
                  context.goNamed(AppRouter.home);
                } else {
                  AppSnackbar.showSnackbar(context, 'Bir kata boldu');
                }
              });
            }
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
