import 'package:flutter/material.dart';
import 'package:flutter_unihack_template/common/theme/palette.dart';
import 'package:flutter_unihack_template/common/theme/text_styles.dart';
import 'package:flutter_unihack_template/generated/fonts.gen.dart';

final Map<ThemeMode, ThemeSheet> themes = {
  ThemeMode.light: ThemeSheet(palette: Palette.light(), textStyles: AppTextStyles.fromPalette(Palette.light())),
  ThemeMode.dark: ThemeSheet(palette: Palette.dark(), textStyles: AppTextStyles.fromPalette(Palette.dark())),
};

class ThemeSheet {
  final ThemeData themeData;
  final Palette palette;
  final AppTextStyles textStyles;

  ThemeSheet({required this.palette, required this.textStyles})
      : themeData = ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),
          brightness: palette.brightness,
          fontFamily: FontFamily.mulish,
          scaffoldBackgroundColor: palette.scaffoldBackground,
          extensions: [palette, textStyles],
        );
}
