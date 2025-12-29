import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mq_auth_repository/mq_auth_repository.dart';
import 'package:my_quran/app/app.dart';
import 'package:my_quran/modules/modules.dart';
import 'package:my_quran/utils/urils.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

class ProfileEditTimezoneView extends StatefulWidget {
  const ProfileEditTimezoneView(this.timezone, {super.key});

  final String timezone;

  @override
  State<ProfileEditTimezoneView> createState() => _ProfileEditTimezoneViewState();
}

class _ProfileEditTimezoneViewState extends State<ProfileEditTimezoneView> {
  late String _selectedTimezone;
  List<String> _ianaTimezones = [];
  List<String> _filteredTimezones = [];
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedTimezone = widget.timezone;
    initializeTimeZones();
    _ianaTimezones = tz.timeZoneDatabase.locations.keys.toList()..sort();
    _filteredTimezones = _ianaTimezones;
    _searchController.addListener(_filterList);
  }

  void _filterList() {
    setState(
      () => _filteredTimezones = _ianaTimezones
          .where(
            (t) => t.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        title: const Text('Saat Dilimi Seçin'),
        backgroundColor: colorScheme.surfaceContainerLow,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Şehir veya kıta ara (örn: Istanbul)',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          context.manageLoader(state.isLoading);
          if (state is ProfileError) {
            _onError(state.error, context);
          } else if (state is ProfileSuccess) {
            _onSuccess(state.user, context);
          }
        },
        child: ListView.builder(
          itemCount: _filteredTimezones.length,
          itemBuilder: (context, index) {
            final zone = _filteredTimezones[index];
            final isSelected = _selectedTimezone == zone;
            return ListTile(
              title: Text(zone.replaceAll('_', ' ')),
              trailing: isSelected ? Icon(Icons.check, color: colorScheme.primary) : null,
              selected: isSelected,
              onTap: () => _updateTimezone(zone, context),
            );
          },
        ),
      ),
    );
  }

  void _onSuccess(AuthModel auth, BuildContext context) {
    context.read<AuthCubit>().updateAuth(auth);
    Navigator.pop(context);
  }

  void _onError(Object error, BuildContext context) {
    setState(() => _selectedTimezone = widget.timezone);
    AppSnackbar.showError(context: context, title: error.toString());
  }

  void _updateTimezone(String? timezone, BuildContext context) {
    if (timezone == null) return;
    setState(() => _selectedTimezone = timezone);
    final authKey = context.read<AuthCubit>().auth?.key ?? '';
    context.read<ProfileCubit>().updateUserData(
      UpdateTimezoneParam(
        userId: authKey,
        timezone: timezone,
      ),
    );
  }
}
