import 'package:flutter_unihack_template/app.dart';
import 'package:flutter_unihack_template/bootstrap.dart';

Future<void> main() async {
  await bootstrap(
    () {
      return const App();
    },
  );
}
