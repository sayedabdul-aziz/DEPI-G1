import 'package:counter_with_cubit/cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  int counter = 0;

  increment() async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1), () {
      counter++;
      emit(CounterUpdatedState());
    });
  }

  decrement() {
    counter--;
    emit(CounterUpdatedState());
  }

  login() {
    // loading
    // api call
    // success
    // error
  }
}
