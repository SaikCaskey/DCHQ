// User Events
// These are the actions we expect to recieve from the UI.
class TimerStartPressed {
  const TimerStartPressed(this.duration);

  final int duration;
}

class TimerStopPressed {
  TimerStopPressed(this.duration);

  final int duration;
}

class TimerResetPressed {}
