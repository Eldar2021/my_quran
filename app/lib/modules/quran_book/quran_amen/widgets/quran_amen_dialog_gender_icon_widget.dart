import 'package:flutter/cupertino.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/modules/modules.dart';

class QuranAmenDialogGenderIconWidget extends StatelessWidget {
  const QuranAmenDialogGenderIconWidget(this.args, {super.key});

  final QuranAmenDialogContentArgs args;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: switch (args.gender) {
          Gender.male => Assets.icons.userMale.svg(
            height: 100,
            colorFilter: ColorFilter.mode(
              args.readThemeState.frColor,
              BlendMode.srcIn,
            ),
          ),
          Gender.female => Assets.icons.userFemale.svg(
            height: 100,
            colorFilter: ColorFilter.mode(
              args.readThemeState.frColor,
              BlendMode.srcIn,
            ),
          ),
        },
      ),
    );
  }
}
