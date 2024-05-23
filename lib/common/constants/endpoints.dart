import 'package:flutter_unihack_template/common/constants/env_keys.dart';

abstract class Endpoints {
  static String apiUrl = '${Env.baseURL}/api';

  static String login = '$apiUrl/auth/login';
  static String userInfo = '$apiUrl/auth/me';
}
