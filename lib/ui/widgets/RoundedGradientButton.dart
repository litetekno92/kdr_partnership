import 'package:flutter/material.dart';
import 'package:partnership/style/theme.dart';

Widget gradientContainer(BuildContext context, double incHeightBy, double incWidthBy, Widget child) {
  final ButtonThemeData buttonTheme = ButtonTheme.of(context).copyWith(padding: const EdgeInsets.all(0.0));
  return Container(
    height: buttonTheme.height + incHeightBy,
    width: buttonTheme.minWidth + incWidthBy,
    decoration: BoxDecoration(gradient: AThemes.selectedTheme.btnGradient),
    child: Center(child: child),
  );
}

class RoundedGradientButton extends StatefulWidget {
  RoundedGradientButton(
      {
        @required this.child,
        @required this.callback,
        this.shape,
        this.shapeRadius,
        this.textStyle,
        this.elevation = 5.0,
        this.isEnabled = true,
        this.disabledGradient,
        this.increaseHeightBy = 0.0,
        this.increaseWidthBy = 0.0}){
    this.gradient = AThemes.selectedTheme.btnGradient;
  }

  final Widget child;
  Gradient gradient;
  final Gradient disabledGradient;
  final VoidCallback callback;
  final ShapeBorder shape;
  final BorderRadius shapeRadius;
  final TextStyle textStyle;
  final bool isEnabled;
  final double elevation;
  final double increaseHeightBy;
  final double increaseWidthBy;

  @override
  RoundedGradientButtonState createState() {
    return RoundedGradientButtonState();
  }
}

class RoundedGradientButtonState extends State<RoundedGradientButton> with SingleTickerProviderStateMixin {
  Animation<double> _opacity;
  AnimationController animationController;
  bool isTappedUp = false;
  double elevation;

  Gradient gradient;
  VoidCallback callback;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _opacity = Tween<double>(begin: 1.0, end: 0.8)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    elevation = widget.elevation;
    animationController.addStatusListener((status) {
      if (animationController.isCompleted && isTappedUp) {
        animationController.reverse();
      }
    });

    super.initState();
  }

  void tapDown() {
    elevation = 0.0;
    animationController.forward();
    isTappedUp = false;
    setState(() {});
  }

  void tapUp() {
    elevation = widget.elevation * 2;
    if (!animationController.isAnimating) {
      animationController.reverse();
    }
    isTappedUp = true;
    setState(() {});
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    BorderRadius borderRadiusCopy = widget.shapeRadius ?? BorderRadius.circular(20.0);
    ShapeBorder shapeCopy = widget.shape ?? RoundedRectangleBorder(borderRadius: borderRadiusCopy);
    TextStyle textStyleCopy = widget.textStyle ?? theme.textTheme.button.copyWith(color: Colors.white);

    if (widget.isEnabled) {
      gradient = widget.gradient;
      callback = widget.callback;
    } else {
      callback = null;
      gradient = widget.disabledGradient ??
          LinearGradient(
            stops: widget.gradient.stops,
            colors: const <Color>[
              Color(0xffDADADA), // <color name="mystic">#DADADA</color>
              Color(0xffBABEC3), // <color name="french_gray">#BABEC3</color>
            ],
          );
    }

    return GestureDetector(
      onTapDown: (details) => tapDown(),
      onTapUp: (details) => tapUp(),
      onTapCancel: () => tapUp(),
      child: Center(
        child: RawMaterialButton(
          fillColor: Colors.transparent,
          padding: const EdgeInsets.all(0.0),
          shape: shapeCopy,
          elevation: elevation,
          textStyle: textStyleCopy,
          onPressed: () {
            tapDown();
            tapUp();
            callback();
          },
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: FadeTransition(
            opacity: _opacity,
            child: gradientContainer(context, widget.increaseHeightBy, widget.increaseWidthBy, widget.child),
          ),
        ),
      ),
    );
  }
}