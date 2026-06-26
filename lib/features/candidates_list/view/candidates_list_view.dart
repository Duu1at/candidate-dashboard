import 'package:candidate_dashboard/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

const _kHeaderHeight = 138.0;
const _kOfflineBannerHeight = 34.0;
const _kMaxContentWidth = 700.0;

class CandidatesListView extends StatelessWidget {
  const CandidatesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CandidateFiltersCubit>(
          create: (context) => CandidateFiltersCubit(),
        ),
        BlocProvider<CandidatesListCubit>(
          create: (context) => CandidatesListCubit(
            getIt<CandidateRepository>(),
            context.read<CandidateFiltersCubit>(),
          ),
        ),
      ],
      child: const CandidatesListViewBody(),
    );
  }
}

class CandidatesListViewBody extends StatefulWidget {
  const CandidatesListViewBody({super.key});

  @override
  State<CandidatesListViewBody> createState() => _CandidatesListViewBodyState();
}

class _CandidatesListViewBodyState extends State<CandidatesListViewBody> {
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
    _debouncer.run(() => context.read<CandidateFiltersCubit>().search(q));
  }

  void _onClear() {
    _searchController.clear();
    context.read<CandidateFiltersCubit>().search('');
  }

  void _resetFilters() {
    _searchController.clear();
    context.read<CandidateFiltersCubit>().reset();
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

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
          child: RefreshIndicator(
            onRefresh: () =>
                context.read<CandidatesListCubit>().load(forceRefresh: true),
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
                            onFilterSelected: context
                                .read<CandidateFiltersCubit>()
                                .filterByVerdict,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<CandidateFiltersCubit, CandidateFiltersState>(
                  buildWhen: (a, b) => a.sortBy != b.sortBy,
                  builder: (context, filtersState) {
                    return BlocBuilder<
                      CandidatesListCubit,
                      CandidatesListState
                    >(
                      buildWhen: (a, b) =>
                          a.status != b.status ||
                          a.items.length != b.items.length ||
                          a.totalItems != b.totalItems,
                      builder: (_, listState) {
                        return SliverToBoxAdapter(
                          child:
                              listState.status == CandidatesListStatus.loaded ||
                                  listState.status ==
                                      CandidatesListStatus.loadingMore
                              ? ListSubHeader(
                                  shown: listState.items.length,
                                  total: listState.totalItems,
                                  sortOption: filtersState.sortBy,
                                )
                              : const SizedBox.shrink(),
                        );
                      },
                    );
                  },
                ),
                CandidateListBodySliver(
                  onReset: _resetFilters,
                  onCardTap: (id) => context.push(
                    '${AppRoutes.candidatesList}/${AppRoutes.candidateDetail.replaceFirst(':id', id)}',
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: padding.bottom)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
