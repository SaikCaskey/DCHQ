import 'package:alex_ui/factory/app_theme_factory.dart';
import 'package:alex_ui/theme/style_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized()
      .renderView
      .automaticSystemUiAdjustment = false;

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  const overlayStyle = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(overlayStyle);

  final lightThemeData = await AppThemeFactory.create(
    AppThemeType.normal,
    isDark: false,
  );
  final darkThemeData = await AppThemeFactory.create(
    AppThemeType.normal,
    isDark: true,
  );
  runApp(App(lightThemeData: lightThemeData, darkThemeData: darkThemeData));
}
