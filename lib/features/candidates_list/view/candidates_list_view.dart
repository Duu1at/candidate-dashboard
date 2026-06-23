import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/debouncer.dart';
import '../cubit/candidates_list_cubit.dart';
import '../cubit/candidates_list_state.dart';
import '../widgets/candidate_list_body.dart';
import '../widgets/list_header.dart';
import '../widgets/list_sub_header.dart';
import '../widgets/offline_banner.dart';

class CandidatesListView extends StatefulWidget {
  const CandidatesListView({super.key});

  @override
  State<CandidatesListView> createState() => _CandidatesListViewState();
}

class _CandidatesListViewState extends State<CandidatesListView> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _debouncer = Debouncer();
    context.read<CandidatesListCubit>().load();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CandidatesListCubit>().loadNextPage();
    }
  }

  void _onSearch(String q) {
    _debouncer.run(() {
      context.read<CandidatesListCubit>().search(q);
    });
  }

  void _onClear() {
    _searchController.clear();
    context.read<CandidatesListCubit>().search('');
  }

  void _resetFilters() {
    _searchController.clear();
    context.read<CandidatesListCubit>()
      ..search('')
      ..filterByVerdict(null);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<CandidatesListCubit, CandidatesListState>(
              buildWhen: (a, b) => a.isOffline != b.isOffline,
              builder: (_, state) {
                return state.isOffline
                    ? const OfflineBanner()
                    : const SizedBox.shrink();
              },
            ),
            ListHeader(
              searchController: _searchController,
              onSearch: _onSearch,
              onClear: _onClear,
              onFilterSelected: context
                  .read<CandidatesListCubit>()
                  .filterByVerdict,
            ),
            BlocBuilder<CandidatesListCubit, CandidatesListState>(
              buildWhen: (a, b) {
                return a.status != b.status ||
                    a.displayedCandidates.length !=
                        b.displayedCandidates.length ||
                    a.filteredCandidates.length !=
                        b.filteredCandidates.length ||
                    a.sortBy != b.sortBy;
              },
              builder: (context, state) {
                if (state.status != CandidatesListStatus.loaded) {
                  return const SizedBox.shrink();
                }
                return ListSubHeader(
                  shown: state.displayedCandidates.length,
                  total: state.filteredCandidates.length,
                  sortOption: state.sortBy,
                );
              },
            ),
            Expanded(
              child: CandidateListBody(
                scrollController: _scrollController,
                onReset: _resetFilters,
                onCardTap: (id) => context.push('/candidates/candidate/$id'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
