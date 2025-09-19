import 'package:counter_with_cubit/bloc/counter_event.dart';
import 'package:counter_with_cubit/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterBlocState> {
  CounterBloc() : super(CounterInitial()) {
    on((event, emit) async {
      if (event is IncrementEvent) {
        await increment(emit);
      } else if (event is DecrementEvent) {
        await decrement(emit);
      }
    });
  }

  int counter = 0;

  increment(Emitter<CounterBlocState> emit) async {
    emit(CounterLoadingState());
    await Future.delayed(Duration(seconds: 1), () {
      counter++;
      emit(CounterUpdatedState(counter: counter));
    });
  }

  decrement(Emitter<CounterBlocState> emit) {
    counter--;
    emit(CounterUpdatedState(counter: counter));
  }
}
