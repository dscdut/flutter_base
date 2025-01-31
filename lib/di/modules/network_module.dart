import 'package:flutter_unihack_template/common/helpers/dio_helper.dart';
import 'package:flutter_unihack_template/di/providers/dio_provider.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  DioHelper provideDioHelper(DioProvider dioProvider) {
    return DioHelper(dio: dioProvider.getDio());
  }
}
