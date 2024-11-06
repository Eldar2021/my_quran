# My Quran Hatim Aplication.

Regardless of your nationality, place of residence, gender, or social status, you're invited to join a global community with MyQuran App. This app offers a personalized and comprehensive way to engage with the Quran, making it easy for users to track their recitations, follow prayer times.


<p align="center">
  <img src="doc/iPhone 14 Pro Max/001-login-language-page-en.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/021-home-init.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/041-hatim-juzs.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/042-hatim-pages.png" width="22%" />
</p>

<p align="center">
  <img src="doc/iPhone 14 Pro Max/062-read-quran-surahs.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/063-read-quran-baqarah.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/064-read-quran-settings.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/082-quran-audio-play-fatiha.png" width="22%" />
</p>

<p align="center">
  <img src="doc/iPhone 14 Pro Max/101-settings-init.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/102-settings-gender-male.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/104-settings-language-page-en.png" width="22%" />
  <img src="doc/iPhone 14 Pro Max/109-settings-theme-page-light-red.png" width="22%" />
</p>

### Getting Started

## Requirements

- Dart sdk: ">=3.4.0 <4.0.0"
- Flutter: "3.22.2"
- Android: minSdkVersion 19
- iOS: --ios-language swift, Xcode version >= 15.0.0

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
melos run-app
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
