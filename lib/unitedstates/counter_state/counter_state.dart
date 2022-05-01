// Extend UnitedState to create a CounterState
import 'dart:math';

import 'package:washington/washington.dart';

import 'counter_event.dart';
import 'counter_state_event.dart';

/// Basically a Shared Bloc
class CounterState extends UnitedState<int> {
  // You can use fields but they should always be final.
  // If it's part of the (changing) state, it should be part of the `value`.
  final int lowerLimit;
  final int upperLimit;

  bool get canIncrement => !isLoading && value < upperLimit;

  bool get canDecrement => !isLoading && value > lowerLimit;

  bool get canReset => !isLoading && value != 0;

  bool get canRandom => !isLoading;

  CounterState({
    required this.upperLimit,
    required this.lowerLimit,
  }) : super(0) {
    // Add handlers to handle incoming events.
    // Pro tip: use tear-offs to get a nice clean list of handlers.
    addHandler<CounterIncrementPressed>(_increment);
    addHandler<CounterDecrementPressed>(_decrement);
    addHandler<CounterResetPressed>(_reset);
    addHandler<CounterRandomPressed>(_random);
    addHandler<CounterDividePressed>(_divide);
  }

  void _increment(CounterIncrementPressed event) {
    // Here we do some logic checks and set the new State when needed.
    if (value < upperLimit) {
      setState(value + 1);
    }
    // When the value reached the upperLimit, we dispatch the LimitReached event.
    if (value == upperLimit) {
      dispatch(LimitReached());
    }
  }

  void _decrement(CounterDecrementPressed event) {
    if (value > lowerLimit) {
      setState(value - 1);
    }
    if (value == lowerLimit) {
      dispatch(LimitReached());
    }
  }

  void _reset(CounterResetPressed event) {
    setState(0);
    dispatch(CounterResetted());
  }

  void _random(CounterRandomPressed event) {
    setState(value, isLoading: true);
    Future.delayed(const Duration(seconds: 1), () {
      final newValue = Random().nextInt(upperLimit);
      setState(newValue);
    });
  }

  void _divide(CounterDividePressed event) {
    if (event.divideBy == 0) {
      setState(value, error: 'Cannot divide by 0');
    } else {
      setState((value / event.divideBy).round());
    }
  }
}
