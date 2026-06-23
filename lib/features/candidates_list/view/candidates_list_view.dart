import 'package:candidate_dashboard/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

// ListHeader content height: title(55) + topPad(8) + searchPad(12) + search(48) + chips(16)
const _kHeaderHeight = 138.0;
// OfflineBanner: vertical padding(8×2) + labelMedium lineHeight(18)
const _kOfflineBannerHeight = 34.0;

class CandidatesListView extends StatefulWidget {
  const CandidatesListView({super.key});

  @override
  State<CandidatesListView> createState() => _CandidatesListViewState();
}

class _CandidatesListViewState extends State<CandidatesListView> {
  late final CandidatesListCubit _cubit;
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _cubit = CandidatesListCubit(getIt<CandidateRepository>());
    _searchController = TextEditingController();
    _scrollController = ScrollController();
    _debouncer = Debouncer();
    _cubit.load();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _cubit.loadNextPage();
    }
  }

  void _onSearch(String q) => _debouncer.run(() => _cubit.search(q));

  void _onClear() {
    _searchController.clear();
    _cubit.search('');
  }

  void _resetFilters() {
    _searchController.clear();
    _cubit
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
    final padding = MediaQuery.paddingOf(context);

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => _cubit.load(forceRefresh: true),
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              BlocBuilder<CandidatesListCubit, CandidatesListState>(
                buildWhen: (a, b) => a.isOffline != b.isOffline,
                builder: (_, state) {
                  final expandedHeight =
                      _kHeaderHeight +
                      padding.top +
                      (state.isOffline ? _kOfflineBannerHeight : 0);
                  return SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 0,
                    expandedHeight: expandedHeight,
                    backgroundColor: context.colors.surface,
                    scrolledUnderElevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.none,
                      background: Padding(
                        padding: EdgeInsets.only(top: padding.top),
                        child: ListHeader(
                          searchController: _searchController,
                          onSearch: _onSearch,
                          onClear: _onClear,
                          onFilterSelected: _cubit.filterByVerdict,
                        ),
                      ),
                    ),
                  );
                },
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
                builder: (_, state) {
                  return SliverToBoxAdapter(
                    child: state.status == CandidatesListStatus.loaded
                        ? ListSubHeader(
                            shown: state.displayedCandidates.length,
                            total: state.filteredCandidates.length,
                            sortOption: state.sortBy,
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),
              CandidateListBodySliver(
                onReset: _resetFilters,
                onCardTap: (id) => context.push('/candidates/candidate/$id'),
              ),
              SliverToBoxAdapter(child: SizedBox(height: padding.bottom)),
            ],
          ),
        ),
      ),
    );
  }
}
