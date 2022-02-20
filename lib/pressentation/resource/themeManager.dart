import 'package:flutter/material.dart';

import 'colorManager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
  );
}
