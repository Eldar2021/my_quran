import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mq_app_ui/mq_app_ui.dart';
import 'package:mq_ci_keys/mq_ci_keys.dart';
import 'package:my_quran/config/router/app_router.dart';
import 'package:my_quran/l10n/l10.dart';
import 'package:my_quran/modules/create/create.dart';
import 'package:my_quran/utils/reg_exp/app_reg_exp.dart';

class CreateHatimView extends StatefulWidget {
  const CreateHatimView({super.key});

  @override
  State<CreateHatimView> createState() => _CreateHatimViewState();
}

class _CreateHatimViewState extends State<CreateHatimView> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prTextTheme = Theme.of(context).primaryTextTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: const Key(MqKeys.createHatim),
      appBar: AppBar(
        title: const Text(
          // context.l10n.hatim,
          'Create Hatim',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const TitleWidget(title: 'Title'),
            TextFormField(
              key: const Key(MqKeys.titleTextField),
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Hatim title';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Assets.icons.title.svg(colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn)),
                ),
                // hintText: context.l10n.enterEmail,
                hintText: 'Enter Hatim title here',
              ),
            ),

            const SizedBox(height: 26),
            const TitleWidget(title: 'Description'),
            TextFormField(
              key: const Key(MqKeys.descriptionTextField),
              controller: descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Hatim description';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Assets.icons.fluentDescription.svg(
                    colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
                  ),
                ),
                // Icon(Icons.email, size: 28),
                // hintText: context.l10n.enterEmail,
                hintText: 'Enter Hatim description here',
              ),
            ),
            const SizedBox(height: 26),
            const TitleWidget(title: 'Participants'),
            TextFormField(
              onTap: () {
                context.pushNamed(AppRouter.search);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Add participants to Hatim';
                }
                return null;
              },
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Assets.icons.solidUsers.svg(
                    colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
                  ),
                ),
                hintText: 'Add participants to your Hatim',
                suffixIcon: Icon(Icons.arrow_forward_ios_rounded, color: colorScheme.inverseSurface, size: 20),
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          // key: const Key(MqKeys.participantToHatim),
          onPressed: () {},
          child: const Text('Create Hatim'),
        ),
      ),
    );
  }
}
