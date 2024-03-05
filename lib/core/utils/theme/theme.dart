
import 'package:flutter/material.dart';
import 'package:followupapprefactored/core/utils/theme/widget_themes/appbar_theme.dart';
import 'package:followupapprefactored/core/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:followupapprefactored/core/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:followupapprefactored/core/utils/theme/widget_themes/chip_theme.dart';
import 'package:followupapprefactored/core/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:followupapprefactored/core/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:followupapprefactored/core/utils/theme/widget_themes/text_field_theme.dart';
import '../constants/colors.dart';
import 'widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: CColors.grey,
    brightness: Brightness.light,
    primaryColor: CColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: CColors.white,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: CColors.grey,
    brightness: Brightness.dark,
    primaryColor: CColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: CColors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
