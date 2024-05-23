import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_unihack_template/common/helpers/firebase_messaging_service.dart';
import 'package:flutter_unihack_template/common/helpers/local_notification_service.dart';
import 'package:flutter_unihack_template/di/di.dart';
import 'package:flutter_unihack_template/generated/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function();

Future<void> bootstrap(BootstrapBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();

  runApp(
    await builder(),
  );
}

Future<void> initializeApp() async {
  await Hive.initFlutter();

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    configureDependencies(),
    //  AdsConfig.instance.init(); // Uncomment this line to enable ads
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ]);
  EasyLocalization.logger.enableBuildModes = [];

  await LocalNotificationService.init();
  await FirebaseMessagingService.init();
}
