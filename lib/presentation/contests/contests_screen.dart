import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contests_bloc.dart';
import 'widgets/empty_state.dart';
import 'widgets/loading_state.dart';

class ContestsScreen extends StatelessWidget {
  const ContestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContestsBloc()..init(),
      child: BlocBuilder<ContestsBloc, ContestsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const LoadingState();
          }
          if (state.contest == null) {
            return const EmptyState();
          }
          return Container();
        },
      ),
    );
  }
}
