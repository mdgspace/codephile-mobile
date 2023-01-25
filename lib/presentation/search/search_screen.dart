import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constants/colors.dart';
import '../components/inputs/text_input.dart';
import 'bloc/search_bloc.dart';
import 'widgets/filter_search.dart';
import 'widgets/recent_searches.dart';
import 'widgets/searched_result.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 13.r,
                vertical: 30.r,
              ),
              child: TextInput(
                hint: 'Search people by name or handles',
                onChanged: (val) {
                  if (val.isEmpty) {
                    context.read<SearchBloc>().add(const Reset());
                  } else {
                    context.read<SearchBloc>().add(UpdateQuery(query: val));
                  }
                },
                controller: context.read<SearchBloc>().controller,
                onSubmitted: (val) {
                  final res = val.trim();
                  if (res.isEmpty) return;
                  context.read<SearchBloc>().add(SearchPeople(
                      query: res, selectedField: state.selectedField));
                },
                action: TextInputAction.search,
                isFilled: true,
                border: InputBorder.none,
                fillColor: AppColors.grey7,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.fromLTRB(4, 1, 1, 4),
                      icon: const Icon(
                        Icons.filter_alt,
                        color: AppColors.grey6,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return FilterSearch(
                              bloc: context.read<SearchBloc>(),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      padding: const EdgeInsets.fromLTRB(4, 1, 1, 4),
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.grey6,
                      ),
                      onPressed: () {
                        context.read<SearchBloc>().controller.clear();
                        if (state.showSearches) {
                          context.read<SearchBloc>().add(const Reset());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: state.showSearches
                  ? const SearchedResult()
                  : const RecentSearches(),
            ),
          ],
        );
      },
    );
  }
}
