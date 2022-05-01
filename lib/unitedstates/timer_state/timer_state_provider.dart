// Extend UnitedState to create a CounterState

import 'dart:async';

import 'package:dchq/unitedstates/timer_state/timer_ticker.dart';
import 'package:washington/washington.dart';

import 'timer_event.dart';
import 'timer_state_event.dart';

/// Basically a Shared Bloc
class TimerState extends UnitedState<int> {
  StreamSubscription? _timerSubscription;

  final Ticker _timer = Ticker();

  TimerState() : super(0) {
    // Add handlers to handle incoming events.
    // Pro tip: use tear-offs to get a nice clean list of handlers.
    addHandler<TimerStartPressed>(_onStartTimer);
    addHandler<TimerStopPressed>(_onStopTimer);
    addHandler<TimerResetPressed>(_onReset);
    addHandler<TimerLimitReached>(_onLimitReached);
  }

  void _onStartTimer(TimerStartPressed event) {
    if (_timerSubscription?.isPaused == true) {
      _timerSubscription?.resume();
    } else {
      _timerSubscription?.cancel();
      setState(event.duration, isLoading: true);
      _timerSubscription = _timer.tick(ticks: event.duration).listen(
        (duration) {
          final hasFinished = duration <= 0;
          if (hasFinished) {
            dispatch(TimerLimitReached());
          } else {
            dispatch(TimerTicked(duration: event.duration));
          }
          setState(duration, isLoading: !hasFinished);
        },
      );
    }
  }

  void _onStopTimer(TimerStopPressed event) {
    _timerSubscription?.pause();
    setState(event.duration, isLoading: false);
  }

  void _onReset(TimerResetPressed event) {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    setState(0, isLoading: false);
    dispatch(TimerReset());
  }

  void _onLimitReached(TimerLimitReached event) {
    _timerSubscription?.cancel();
    _timerSubscription = null;
    setState(0, isLoading: false);
  }
}
