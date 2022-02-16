import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contests_bloc.dart';
import 'widgets/contest_card.dart';
import 'widgets/contest_header.dart';
import 'widgets/empty_state.dart';
import 'widgets/loading_state.dart';

class ContestsScreen extends StatelessWidget {
  const ContestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContestsBloc>(
      create: (_) => ContestsBloc()..init(),
      child: BlocBuilder<ContestsBloc, ContestsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: ContestHeader(),
            ),
            body: Builder(
              builder: (_) {
                if (state.isLoading) {
                  return const LoadingState();
                }
                if (state.contest == null) {
                  return const EmptyState();
                }
                return ListView.builder(
                  itemCount: (state.contest!.upcoming?.length ?? 0) + 0,
                  // (state.contest!.ongoing?.length ?? 0),
                  itemBuilder: (context, index) {
                    final contest = state.contest!.upcoming![index];
                    // if (index >= (state.contest!.upcoming?.length ?? 0)) {
                    //   index -= state.contest!.upcoming?.length ?? 0;
                    //   contest = state.contest!.ongoing?[index];
                    // }

                    return ContestCard(contest: contest);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
