import 'package:alex_ui/theme/app_theme.dart';
import 'package:alex_ui/theme/app_theme_data.dart';
import 'package:dchq/unitedstates/counter_state/counter_state.dart';
import 'package:dchq/unitedstates/timer_state/timer_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:washington/washington.dart';

import 'presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.themeMode,
    required this.lightThemeData,
    required this.darkThemeData,
  }) : super(key: key);

  final AppThemeData lightThemeData;
  final AppThemeData darkThemeData;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return MultiStateProvider(
        stateProviders: [
          StateProvider<CounterState>(
              create: (_) => CounterState(lowerLimit: 0, upperLimit: 10)),
          StateProvider<TimerState>(create: (_) => TimerState())
        ],
        child: MaterialApp(
          theme: lightThemeData.materialThemeData,
          darkTheme: darkThemeData.materialThemeData,
          themeMode: themeMode,
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
          builder: (context, child) => AppOverlay(
            lightStyleData: lightThemeData,
            darkStyleData: darkThemeData,
            themeMode: themeMode,
            child: child ?? const Offstage(),
          ),
        ));
  }
}

class AppOverlay extends StatelessWidget {
  const AppOverlay({
    Key? key,
    required this.lightStyleData,
    required this.darkStyleData,
    required this.themeMode,
    required this.child,
  }) : super(key: key);

  final AppThemeData lightStyleData;
  final AppThemeData darkStyleData;
  final ThemeMode themeMode;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      themeData: _useDarkStyle(context) ? darkStyleData : lightStyleData,
      child: child,
    );
  }

  bool _useDarkStyle(BuildContext context) {
    return themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);
  }
}
