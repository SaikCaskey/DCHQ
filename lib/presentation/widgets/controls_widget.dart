import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washington/washington.dart';

import '../../unitedstates/counter_state/counter_event.dart';
import '../../unitedstates/counter_state/counter_state.dart';
import '../../unitedstates/timer_state/timer_event.dart';
import '../../unitedstates/timer_state/timer_state_provider.dart';

class Controls extends StatelessWidget {
  const Controls({Key? key}) : super(key: key);

  void _onTimerStartPressed(int value) {
    Washington.instance.dispatch(TimerStartPressed(value));
  }

  void _onTimerStopPressed(int value) {
    Washington.instance.dispatch(TimerStopPressed(value));
  }

  void _onCounterIncPressed() {
    Washington.instance.dispatch(CounterIncrementPressed());
  }

  void _onCounterDecPressed() {
    Washington.instance.dispatch(CounterDecrementPressed());
  }

  void _onCounterReset() {
    Washington.instance.dispatch(CounterResetPressed());
  }

  void _onCounterDivide(value) {
    Washington.instance.dispatch(CounterDividePressed(value));
  }

  @override
  Widget build(BuildContext context) {
    final counterState = context.watch<CounterState>();
    final timerState = context.watch<TimerState>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerControlsBar(
              timerState.isLoading,
              timerState.value,
              counterState.value,
              _onTimerStartPressed,
              _onTimerStopPressed,
            ),
            _buildCounterMainControlsBar(
              counterState.canIncrement,
              counterState.canDecrement,
              counterState.canRandom,
              _onCounterIncPressed,
              _onCounterDecPressed,
              _onCounterReset,
            ),
            _buildCounterSecondaryControlsBar(
              counterState.canRandom,
              _onCounterDivide,
            ),
          ],
        ),
      ),
    );
  }
}

_buildTimerControlsBar(
  bool isTimerTicking,
  int timerValue,
  int counterValue,
  Function(int)? onTimerStart,
  Function(int)? onTimerStop,
) =>
    Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.start),
            onPressed: !isTimerTicking && counterValue > 0
                ? () => onTimerStart?.call(counterValue)
                : null,
            label: const Text('Start'),
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.stop),
            onPressed:
                isTimerTicking ? () => onTimerStop?.call(timerValue) : null,
            label: const Text('Stop'),
          ),
        ),
      ],
    );

_buildCounterMainControlsBar(
  bool canIncrement,
  bool canDecrement,
  bool canReset,
  Function? onCounterIncrement,
  Function? onCounterDecrement,
  Function? onCounterReset,
) =>
    Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: canIncrement ? () => onCounterIncrement?.call() : null,
            icon: const Icon(Icons.add),
            label: const Text(''),
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: canDecrement ? () => onCounterDecrement?.call() : null,
            icon: const Icon(Icons.remove),
            label: const Text(''),
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: canReset ? () => onCounterReset?.call() : null,
            icon: const Icon(Icons.restore),
            label: const Text(''),
          ),
        ),
      ],
    );

_buildCounterSecondaryControlsBar(
  bool canRandom,
  Function(int)? onCounterDivide,
) =>
    Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: canRandom
                ? () => Washington.instance.dispatch(CounterRandomPressed())
                : null,
            icon: const Icon(Icons.refresh),
            label: const Text('Random'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: canRandom
                ? () =>
                    Washington.instance.dispatch(const CounterDividePressed(2))
                : null,
            child: const Text('/= 2'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: canRandom ? () => onCounterDivide?.call(0) : null,
            child: const Text('/= 0 (error)'),
          ),
        ),
      ],
    );
