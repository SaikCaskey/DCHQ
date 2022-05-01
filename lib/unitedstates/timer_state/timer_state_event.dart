// CounterState Event
// These will be dispatched by our state object to notify other States or
// EventListeners.
class TimerReset {}

class TimerLimitReached {}

class TimerTicked {
  const TimerTicked({required this.duration});

  final int duration;
}
