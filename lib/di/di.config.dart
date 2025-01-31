// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_unihack_template/common/helpers/dio_helper.dart' as _i6;
import 'package:flutter_unihack_template/data/datasources/user/local/user_datasource.dart'
    as _i7;
import 'package:flutter_unihack_template/data/datasources/user/remote/user_datasource.dart'
    as _i8;
import 'package:flutter_unihack_template/data/datasources/user/user_datasource.dart'
    as _i9;
import 'package:flutter_unihack_template/data/repositories/user_repository.dart'
    as _i10;
import 'package:flutter_unihack_template/di/modules/local_module.dart' as _i11;
import 'package:flutter_unihack_template/di/modules/network_module.dart'
    as _i12;
import 'package:flutter_unihack_template/di/providers/dio_provider.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i5;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.singletonAsync<_i3.Box<dynamic>>(
    () => localModule.authBox,
    instanceName: 'auth_box',
    preResolve: true,
  );
  gh.lazySingleton<_i4.DioProvider>(
      () => _i4.DioProvider(gh<_i5.Box<dynamic>>(instanceName: 'auth_box')));
  gh.lazySingleton<_i6.DioHelper>(
      () => networkModule.provideDioHelper(gh<_i4.DioProvider>()));
  gh.lazySingleton<_i7.UserLocalDataSource>(() => _i7.UserLocalDataSource(
      authBox: gh<_i5.Box<dynamic>>(instanceName: 'auth_box')));
  gh.lazySingleton<_i8.UserRemoteDataSource>(
      () => _i8.UserRemoteDataSource(dioHelper: gh<_i6.DioHelper>()));
  gh.lazySingleton<_i9.UserDataSource>(() => _i9.UserDataSource(
        remoteDataSource: gh<_i8.UserRemoteDataSource>(),
        localDataSource: gh<_i7.UserLocalDataSource>(),
      ));
  gh.lazySingleton<_i10.UserRepository>(
      () => _i10.UserRepository(dataSource: gh<_i9.UserDataSource>()));
  return getIt;
}

class _$LocalModule extends _i11.LocalModule {}

class _$NetworkModule extends _i12.NetworkModule {}
