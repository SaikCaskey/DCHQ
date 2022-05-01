import 'package:dchq/unitedstates/timer_state/timer_state_event.dart';
import 'package:flutter/material.dart';
import 'package:washington/washington.dart';

import '../../unitedstates/counter_state/counter_event.dart';
import '../../unitedstates/counter_state/counter_state.dart';
import '../../unitedstates/counter_state/counter_state_event.dart';
import '../../unitedstates/timer_state/timer_state_provider.dart';
import '../widgets/controls_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: EventListener(
              listener: (context, event) {
                if (event is CounterResetted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Counter has been reset!')));
                } else if (event is LimitReached) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('A limit has been reached!')));
                } else if (event is TimerLimitReached) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Timer limit has been reached!')));
                }
              },
              child: StateListener<CounterState, int>.success(
                successListener: (context, state) {
                  // We can trigger events based on state changes
                  if (state.value >= 7) {
                    Washington.instance.dispatch(CounterResetPressed());
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Current value:',
                      ),
                      StateBuilder<CounterState, int>(
                        builder: (context, state) {
                          final String text;
                          if (state.hasError) {
                            text = state.error.toString();
                          } else if (state.isLoading) {
                            text = 'Loading...';
                          } else {
                            text = state.value.toString();
                          }
                          return Text(
                            text,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: state.hasError ? Colors.red : null),
                          );
                        },
                      ),
                      const Text(
                        'Timer value:',
                      ),
                      StateBuilder<TimerState, int>(
                        builder: (context, state) {
                          final String text;
                          if (state.hasError) {
                            text = state.error.toString();
                          } else if (state.isLoading) {
                            text = state.value.toString();
                          } else {
                            text = state.value.toString();
                          }
                          return Text(
                            text,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: state.hasError ? Colors.red : null),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Expanded(child: Controls()),
        ],
      ),
    );
  }
}
