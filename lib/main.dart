import 'package:flutter/material.dart';
import 'package:washington/washington.dart';

import 'counter_state.dart';
import 'home_page.dart';

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
            create: (_) => CounterState(lowerLimit: 0, upperLimit: 10))
      ],
      child: MaterialApp(
        title: 'Washington Demo',
        theme: ThemeData(primarySwatch: Colors.purple),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
