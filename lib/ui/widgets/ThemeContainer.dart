import 'package:flutter/material.dart';
import 'package:partnership/style/theme.dart';

// ignore: non_constant_identifier_names
Container ThemeContainer(BuildContext context, Widget child) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        gradient: AThemes.selectedTheme.bgGradient
    ),
    child: child
  );
}

