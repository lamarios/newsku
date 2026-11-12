import 'package:app/utils/states/simple_cubit.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCubitView<T> extends StatelessWidget {
  final T initialValue;
  final Function(BuildContext context, T value) builder;

  const SimpleCubitView({super.key, required this.initialValue, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SimpleCubit<T>(initialValue),
      child: BlocBuilder<SimpleCubit<T>, T>(builder: (context, state) => builder(context, state)),
    );
  }
}
