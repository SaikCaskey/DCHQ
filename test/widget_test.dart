// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:alex_ui/alex_ui.dart';
import 'package:alex_ui/theme/style_type.dart';
import 'package:dchq/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final lightTheme = await AppThemeFactory.create(
    AppThemeType.normal,
    isDark: false,
  );
  final darkTheme = await AppThemeFactory.create(
    AppThemeType.normal,
    isDark: true,
  );

  testWidgets('Can build test app with alex_ui theme',
      (WidgetTester tester) async {
    await tester.pumpWidget(App(
      lightThemeData: lightTheme,
      darkThemeData: darkTheme,
      themeMode: ThemeMode.dark,
    ));
    await tester.pumpAndSettle();
  });
}
