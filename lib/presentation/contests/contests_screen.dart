import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/contest.dart';
import '../../domain/models/status.dart';
import '../components/widgets/empty_state.dart';
import 'bloc/contests_bloc.dart';
import 'widgets/contest_card.dart';
import 'widgets/contest_header.dart';
import 'widgets/loading_state.dart';

class ContestsScreen extends StatelessWidget {
  const ContestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContestsBloc>(
      create: (_) => ContestsBloc()..init(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ContestHeader(),
        ),
        body: BlocBuilder<ContestsBloc, ContestsState>(
          builder: (context, state) {
            if (state.status is Loading || state.status is Error) {
              return const LoadingState();
            }
            if (state.contests.isEmpty) {
              return const EmptyState(
                description: 'No contests found, please adjust your filters!',
              );
            }
            return ListView.builder(
              itemCount: state.contests.length,
              itemBuilder: (context, index) {
                final isReminderSet = context
                    .read<ContestsBloc>()
                    .reminderSet(state.contests[index].name);
                if (state.contests[index] is Ongoing) {
                  return ContestCard(
                    isReminderSet: isReminderSet,
                    ongoing: state.contests[index],
                  );
                }

                return ContestCard(
                  isReminderSet: isReminderSet,
                  upcoming: state.contests[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
