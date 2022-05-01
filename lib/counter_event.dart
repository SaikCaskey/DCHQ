// User Events
// These are the actions we expect to recieve from the UI.
class CounterIncrementPressed {}

class CounterDecrementPressed {}

class CounterResetPressed {}

class CounterRandomPressed {}

class CounterDividePressed {
  final int divideBy;
  const CounterDividePressed(this.divideBy);
}
