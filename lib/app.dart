import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_unihack_template/common/constants/locales.dart';
import 'package:flutter_unihack_template/common/theme/app_theme.dart';
import 'package:flutter_unihack_template/generated/codegen_loader.g.dart';
import 'package:flutter_unihack_template/router/app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        AppLocales.en,
        AppLocales.vi,
      ],
      path: AppLocales.path,
      fallbackLocale: AppLocales.vi,
      startLocale: AppLocales.vi,
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: ScreenUtilInit(
          designSize: const Size(414, 896),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          child: MaterialApp(
            theme: themes[ThemeMode.light]!.themeData,
            darkTheme: themes[ThemeMode.dark]!.themeData,
            // themeMode: context.read<AppBloc>().state.themeMode,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: AppRouter.splash,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            builder: (_, child) {
              return child!;
            },
          ),
        ),
      ),
    );
  }
}
