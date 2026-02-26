# GEMINI.md

This file serves as a quick reference and set of guidelines for AI interactions with the **My Quran** project. Adhere to these patterns and rules for all code modifications.

## 1. Quick Reference

- **Tech Stack:** Flutter, Dart, Melos (Workspace).
- **Primary Entry Point:** `app/lib/main.dart`
- **Minimum SDK:** Dart ^3.11.0
- **Linter:** `package:very_good_analysis` with custom overrides in root `analysis_options.yaml`.

## 2. Architecture

### Workspace Layout

The project uses a Melos-managed workspace:

- `app/`: The main Flutter application.
- `packages/`: Specialized internal packages prefixed with `mq_`.

### Packages Layout

- `mq_app_ui`: Centralized UI components, theme, colors, and typography.
- `mq_remote_client`: Core networking layer (Dio wrapper).
- `mq_storage`: Caching and local storage (SharedPreferences and SecureStorage).
- `mq_auth_repository`, `mq_home_repository`, `mq_hatim_repository`: Feature-specific repositories.
- `mq_analytics`, `mq_crashlytics`: Firebase monitoring wrappers.
- `mq_prayer_time`, `mq_quran_client`, `mq_remote_config`: Specialized services.
- `functions`: Shared Dart helper functions and utilities (e.g., activity, countries, quran).
- `mq_ci_keys`: CI/CD and API keys configuration.

## 3. Key Patterns

### State Management

- **Library:** `flutter_bloc`
- **Pattern:** Cubit is preferred for most features.
- **Location:** Typically found in `app/lib/app/cubit` or within feature modules in `app/lib/modules/**/cubit`.

### Dependency Injection (DI)

- **Mechanism:** Manual constructor injection via `RepositoryProvider` and `MultiRepositoryProvider`.
- **Entry Point:** Root providers are initialized in `app/lib/main.dart` and `app/lib/app/app.dart`.

### Routing

- **Library:** `go_router`
- **Configuration:** `app/lib/config/router/app_router.dart`.
- **Navigation Helper:** `app/lib/config/router/navigation_helper.dart`.

### Serialization

- **Library:** `json_serializable` / `json_annotation`.
- **Command:** `make build-runner` (via Melos).

### Theme

- **Package:** `mq_app_ui`.
- **Colors:** Defined in `AppColors` (`mq_app_ui/lib/src/colors/app_colors.dart`).
- **Typography:** Defined in `AppTextStyles` (`mq_app_ui/lib/src/typography/app_text_styles.dart`).
- **Mode:** Supports Light and Dark modes via `AppThemeCubit`.

### Localization

- **Tool:** Flutter `gen-l10n`.
- **Config:** `app/l10n.yaml`.
- **ARB Files:** `app/lib/l10n/arb/`.
- **Usage:** `AppLocalizations.of(context)`.

## 4. Networking

- **Client:** `MqRemoteClient` in `packages/mq_remote_client`.
- **Features:** Automated header management (Tokens, Language, CSRF), generic JSON parsing (`getType`, `getListOfType`).
- **Base URL:** Managed via `AppConfig` and `ApiConst`.

## 5. Caching

- **Client:** `MqStorage` in `packages/mq_storage`.
- **Implementations:**
  - `PreferencesStorage`: For non-sensitive data (SharedPreferences).
  - `SecureStorage`: For sensitive data (FlutterSecureStorage).
- **Interface:** Uses `StorageInterfaceSyncRead` for synchronous reads when possible.

## 6. Code Generation

- **Build Runner:** `make build-runner` (runs melos `run-build-runner`).
- **Assets:** `make gen-assets` (generates assets for UI and Quran client).
- **Localization:** Automatically handled by `flutter pub get` or `flutter run` due to `generate: true` in `pubspec.yaml`.

## 7. Rules & Linting

- **Strict Adherence:** Follow `very_good_analysis` rules.
- **UI Components:** Use widgets from `mq_app_ui/lib/src/components` whenever possible.
- **Color Usage:** Always use `AppColors` from `mq_app_ui`.
- **Text Styles:** Always use `AppTextStyles` from `mq_app_ui`.
- **Line Length:** 120 characters (configured in Melos scripts and `analysis_options.yaml`).

## 8. Testing

- **Unit Testing:**
  - Command: `melos unit-test`.
  - Framework: `flutter_test`, `mocktail`.
- **Integration Testing:**
  - Command: `melos integration-test` (runs `flutter drive`).
  - Target: `app/test_driver/app.dart`.
- **Mocks:** Extensive use of mock data sources (e.g., `AuthRepositoryMock`, `AppLocalDataSourceMock`) for testing and dev modes.
