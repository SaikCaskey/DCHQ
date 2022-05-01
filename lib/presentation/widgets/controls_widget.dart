import 'package:dchq/unitedstates/timer_state/timer_event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washington/washington.dart';

import '../../unitedstates/counter_state/counter_event.dart';
import '../../unitedstates/counter_state/counter_state.dart';
import '../../unitedstates/timer_state/timer_state_provider.dart';

class Controls extends StatelessWidget {
  const Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counterState = context.watch<CounterState>();
    final timerState = context.watch<TimerState>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: counterState.canIncrement
                  ? () =>
                      Washington.instance.dispatch(CounterIncrementPressed())
                  : null,
              icon: const Icon(Icons.add),
              label: const Text('Increment'),
            ),
            ElevatedButton.icon(
              onPressed: counterState.canDecrement
                  ? () =>
                      Washington.instance.dispatch(CounterDecrementPressed())
                  : null,
              icon: const Icon(Icons.remove),
              label: const Text('Decrement'),
            ),
            ElevatedButton.icon(
              onPressed: counterState.canReset
                  ? () => Washington.instance.dispatch(CounterResetPressed())
                  : null,
              icon: const Icon(Icons.restore),
              label: const Text('Reset'),
            ),
            ElevatedButton.icon(
              onPressed: counterState.canRandom
                  ? () => Washington.instance.dispatch(CounterRandomPressed())
                  : null,
              icon: const Icon(Icons.refresh),
              label: const Text('Random (fake network call)'),
            ),
            ElevatedButton(
              onPressed: counterState.canRandom
                  ? () => Washington.instance
                      .dispatch(const CounterDividePressed(2))
                  : null,
              child: const Text('Divide by 2'),
            ),
            ElevatedButton(
              onPressed: counterState.canRandom
                  ? () => Washington.instance
                      .dispatch(const CounterDividePressed(0))
                  : null,
              child: const Text('Divide by 0 (error)'),
            ),
            ElevatedButton(
              onPressed: timerState.isLoading
                  ? () => Washington.instance
                      .dispatch(TimerStopPressed(timerState.value))
                  : () => Washington.instance
                      .dispatch(TimerStartPressed(counterState.value)),
              child: Text(timerState.isLoading ? 'Stop' : 'StartTimer'),
            ),
          ],
        ),
      ),
    );
  }
}
