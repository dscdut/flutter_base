import 'package:flutter/material.dart';
import 'package:flutter_unihack_template/presentation/login/login_page.dart';
import 'package:flutter_unihack_template/presentation/root/root_page.dart';
import 'package:flutter_unihack_template/presentation/splash/splash_page.dart';

abstract final class AppRouter {
  static const String splash = '/';

  // Auth
  static const String login = '/login';
  static const String register = '/register';

  // Root
  static const String root = '/root';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) {
            return const SplashPage();
          },
        );
      case login:
        return MaterialPageRoute(
          builder: (_) {
            return const LoginPage();
          },
        );
      case root:
        return MaterialPageRoute(
          builder: (_) {
            return const RootPage();
          },
        );
      default:
        return null;
    }
  }
}
