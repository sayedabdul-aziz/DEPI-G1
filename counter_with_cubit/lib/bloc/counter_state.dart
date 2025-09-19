class CounterBlocState {}

class CounterInitial extends CounterBlocState {}

class CounterLoadingState extends CounterBlocState {}

class CounterUpdatedState extends CounterBlocState {
  final int counter;
  CounterUpdatedState({required this.counter});
}

class CounterResetState extends CounterBlocState {}

// CounterState a = CounterState()
// a = CounterResetState()
// a = LoginSuccessState()
