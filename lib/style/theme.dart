import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

/*
*
* Cette classe définit un gradiant pour le fond de l'appli
*
* */

class Gradients {
  static const AlignmentGeometry _topLeftBeginAlignment = Alignment.topLeft;
  static const AlignmentGeometry _bottomRightEndAlignment = Alignment.bottomRight;
  static const AlignmentGeometry _topCenterBeginAlignment = Alignment.topCenter;
  static const AlignmentGeometry _bottomCenterEndAlignment = Alignment.bottomCenter;

  static LinearGradient buildGradient(AlignmentGeometry begin, AlignmentGeometry end, List<Color> colors) =>
      LinearGradient(begin: begin, end: end, colors: colors);

  static LinearGradient hotLinear =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xffF55B9A), Color(0xffF9B16E)]);

  static LinearGradient serve =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xff485563), Color(0xff485563)]);

  static LinearGradient ali =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xffff4b1f), Color(0xff1fddff)]);

  static LinearGradient aliHussien =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xfff7ff00), Color(0xffdb36a4)]);

  static LinearGradient backToFuture =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xffC02425), Color(0xffF0CB35)]);

  static LinearGradient tameer =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xff136a8a), Color(0xff267871)]);

  static LinearGradient rainbowBlue =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xff00F260), Color(0xff0575E6)]);

  static LinearGradient blush =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xffB24592), Color(0xffF15F79)]);

  static LinearGradient byDesign =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xff009FFF), Color(0xffec2F4B)]);

  static LinearGradient haze =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xffE8EDF4), Color(0xffF6F6F8)]);

  static LinearGradient jShine =
  buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [Color(0xff12c2e9), Color(0xffc471ed), Color(0xfff64f59)]);

  static LinearGradient hersheys = buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [
    Color(0xfff1e130c),
    Color(0xff9a8478),
  ]);

  static LinearGradient taitanum = buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [
    Color(0xff283048),
    Color(0xff859398),
  ]);

  static LinearGradient cosmicFusion = buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [
    Color(0xfffff00cc),
    Color(0xff333399),
  ]);

  static LinearGradient coldLinear = buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [
    Color(0xfff20BDFF),
    Color(0xffA5FECB),
  ]);

  static LinearGradient deepSpace = buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [
    Color(0xff000000),
    Color(0xff434343),
  ]);

   static const int metal = 0xffa5a5a5;

  static LinearGradient metallic = buildGradient(_topLeftBeginAlignment, _bottomRightEndAlignment, const [
    Color(0xffffffff),
    Color(0xff7b7b7b),
    /*0xffbdbdbd < 0xffa5a5a5 < 949494 < 7b7b7b*/
  ]);
  static LinearGradient verticalMetallic = buildGradient(_topCenterBeginAlignment, _bottomCenterEndAlignment, const [
    Color(0xffffffff),
    Color(0xffbdbdbd),
  ]);

  static LinearGradient verticalDawn = buildGradient(_topCenterBeginAlignment, _bottomCenterEndAlignment, const [
    Color(0xff14244a),
    Color(0xff82365c)
  ]);
}

class AppTheme {
  LinearGradient _bgGradient;
  LinearGradient _btnGradient;
  LinearGradient get bgGradient => _bgGradient;
  LinearGradient get btnGradient => _btnGradient;
  AppTheme({@required LinearGradient backgroundGradient, @required LinearGradient buttonGradient}){
    _bgGradient = backgroundGradient;
    _btnGradient = buttonGradient;
  }
}

enum enumTheme {
  DAWN,
}

abstract class AThemes {
  static final AppTheme _dawnTheme = AppTheme(backgroundGradient: Gradients.verticalDawn, buttonGradient: Gradients.metallic);
  static final Map<enumTheme, AppTheme> _themesMap = {
    enumTheme.DAWN: _dawnTheme
  };
  static AppTheme selectedTheme = _themesMap[enumTheme.DAWN];
  void changeTheme({@required enumTheme newTheme}){
    selectedTheme = _themesMap[newTheme];
  }
// OLD THEME BELOW
  static const Color loginGradientStart = const Color(0xFF99DAFF);
  static const Color loginGradientEnd = const Color(0xFF008080);
  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}