import 'package:counter_with_cubit/bloc/counter_bloc.dart';
import 'package:counter_with_cubit/bloc/counter_event.dart';
import 'package:counter_with_cubit/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Counter App', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: BlocConsumer<CounterBloc, CounterBlocState>(
          listener: (context, state) {
            if (state is CounterUpdatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('COUNTER is ${state.counter}')),
              );
            }
          },
          builder: (context, state) {
            var bloc = context.read<CounterBloc>();
            if (state is CounterLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bloc.counter.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        bloc.add(DecrementEvent());
                      },
                      icon: Icon(Icons.remove),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        bloc.add(IncrementEvent());
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
