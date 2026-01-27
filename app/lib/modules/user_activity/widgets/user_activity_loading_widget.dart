import 'package:flutter/cupertino.dart';

class UserActivityLoadingWidget extends StatelessWidget {
  const UserActivityLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final locale = context.read<AuthCubit>().state.currentLocale;
    return const CupertinoActivityIndicator();
  }
}
