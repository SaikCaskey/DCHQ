import 'package:dchq/unitedstates/counter_state/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:washington/washington.dart';

import 'presentation/pages/home_page.dart';
import 'unitedstates/timer_state/timer_state_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiStateProvider(
      stateProviders: [
        StateProvider<CounterState>(
            create: (_) => CounterState(lowerLimit: 0, upperLimit: 10)),
        StateProvider<TimerState>(create: (_) => TimerState())
      ],
      child: MaterialApp(
        title: 'DCHQ',
        theme: ThemeData(primarySwatch: Colors.purple),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
