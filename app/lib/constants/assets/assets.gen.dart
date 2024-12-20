/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/al_quran.svg
  SvgGenImage get alQuran => const SvgGenImage('assets/icons/al_quran.svg');

  /// File path: assets/icons/asr_time.svg
  SvgGenImage get asrTime => const SvgGenImage('assets/icons/asr_time.svg');

  /// File path: assets/icons/beshim.svg
  SvgGenImage get beshim => const SvgGenImage('assets/icons/beshim.svg');

  /// File path: assets/icons/contact_us.svg
  SvgGenImage get contactUs => const SvgGenImage('assets/icons/contact_us.svg');

  /// File path: assets/icons/dua_female.svg
  SvgGenImage get duaFemale => const SvgGenImage('assets/icons/dua_female.svg');

  /// File path: assets/icons/dua_male.svg
  SvgGenImage get duaMale => const SvgGenImage('assets/icons/dua_male.svg');

  /// File path: assets/icons/female.svg
  SvgGenImage get female => const SvgGenImage('assets/icons/female.svg');

  /// File path: assets/icons/github.svg
  SvgGenImage get github => const SvgGenImage('assets/icons/github.svg');

  /// File path: assets/icons/go_right.svg
  SvgGenImage get goRight => const SvgGenImage('assets/icons/go_right.svg');

  /// File path: assets/icons/google-icon.svg
  SvgGenImage get googleIcon => const SvgGenImage('assets/icons/google-icon.svg');

  /// File path: assets/icons/headphones.svg
  SvgGenImage get headphones => const SvgGenImage('assets/icons/headphones.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/male.svg
  SvgGenImage get male => const SvgGenImage('assets/icons/male.svg');

  /// File path: assets/icons/moon.svg
  SvgGenImage get moon => const SvgGenImage('assets/icons/moon.svg');

  /// File path: assets/icons/notebook.svg
  SvgGenImage get notebook => const SvgGenImage('assets/icons/notebook.svg');

  /// File path: assets/icons/open_book.svg
  SvgGenImage get openBook => const SvgGenImage('assets/icons/open_book.svg');

  /// File path: assets/icons/qibla.svg
  SvgGenImage get qibla => const SvgGenImage('assets/icons/qibla.svg');

  /// File path: assets/icons/quran_book.svg
  SvgGenImage get quranBook => const SvgGenImage('assets/icons/quran_book.svg');

  /// File path: assets/icons/settings_burger.svg
  SvgGenImage get settingsBurger => const SvgGenImage('assets/icons/settings_burger.svg');

  /// File path: assets/icons/sham.svg
  SvgGenImage get sham => const SvgGenImage('assets/icons/sham.svg');

  /// File path: assets/icons/time.svg
  SvgGenImage get time => const SvgGenImage('assets/icons/time.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        alQuran,
        asrTime,
        beshim,
        contactUs,
        duaFemale,
        duaMale,
        female,
        github,
        goRight,
        googleIcon,
        headphones,
        home,
        male,
        moon,
        notebook,
        openBook,
        qibla,
        quranBook,
        settingsBurger,
        sham,
        time
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/images/app_icon.png');

  /// File path: assets/images/dua_female.jpg
  AssetGenImage get duaFemale => const AssetGenImage('assets/images/dua_female.jpg');

  /// File path: assets/images/emoji.png
  AssetGenImage get emoji => const AssetGenImage('assets/images/emoji.png');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon, duaFemale, emoji, splash];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
