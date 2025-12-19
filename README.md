# My Quran Hatim Aplication.

<p align="center">
  <a href="https://apps.apple.com/kg/app/my-quran/id1671645027">
    <img src="doc/images/app_store.png" alt="Get it on App Store" width="30%">
  </a>
  &emsp; &emsp;&emsp;&emsp;&emsp;
  <a href="https://play.google.com/store/apps/details?id=com.alee.my_quran">
    <img src="doc/images/google_play.png" alt="Get it on Play Store" width="30%">
  </a>
</p>

Regardless of your nationality, place of residence, gender, or social status, you're invited to join a global community with MyQuran App. This app offers a personalized and comprehensive way to engage with the Quran, making it easy for users to track their recitations, follow prayer times. [App link.](https://onelink.to/q58a9t)

<p align="center">
  <img src="doc/iPhone 16 Pro Max/005-login-google-page.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/021-home-init.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/041-hatim-juzs.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/042-hatim-pages.png" width="22%" />
</p>

<p align="center">
  <img src="doc/iPhone 16 Pro Max/062-read-quran-surahs.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/063-read-quran-baqarah.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/064-read-quran-settings.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/082-quran-audio-play-fatiha.png" width="22%" />
</p>

<p align="center">
  <img src="doc/iPhone 16 Pro Max/101-settings-init.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/102-settings-gender-male.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/111-settings-theme-page-light-blue.png" width="22%" />
  <img src="doc/iPhone 16 Pro Max/113-logout.png" width="22%" />
</p>

## Requirements

- Dart sdk: ^3.9.2
- Flutter: "3.35.6"
- Android: minSdkVersion 23
- iOS: --ios-language swift, Xcode version >= 16.3

## Melos

[Melos](https://melos.invertase.dev/) splitting up large code bases into separate independently versioned packages is extremely useful for code sharing. However, making changes across many repositories is messy and difficult to track, and testing across repositories gets complicated really fast.
To solve these (and many other) problems, some projects will organize their code bases into multi-package repositories (sometimes called [monorepos](https://en.wikipedia.org/wiki/Monorepo)).

- Install melos

```shell
dart pub global activate melos
```

Setup

```shell
melos bootstrap
```

## Run App

- If you have an AVD or real device attached, you can do

```shell
cd app && flutter run
```

## Run tests

- run all tests from the command line:

```shell
melos test
```

## Integration tests

- run integration tests in `test_driver` directory:

```shell
melos integration-test
```

## Fmt

`dartfmt` lacks config file support, which implies that customizations need to be done by users individually. The default
limit of 80 characters line length conflicts with the deeply nested structure of flutter's declarative code for designing
widgets. This causes many unwanted linebreaks that reduce the readability of flutter code. Hence, we increase the line
length of the code to 120.

- Settings > Dart > Line length 120.
- Autoformat on save: Settings > Languages and Frameworks > then tick: `Format code on save`, `Organize imports on save`.
- Format the whole codebase with:

```shell
melos format-all
```

## Generate

- Re generate .g files run:

```shell
melos run-build-runner-all
```

### Installing iOS Dependencies

```sh
./scripts/pod_install.sh
```
