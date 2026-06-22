import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/candidate_filter.dart';
import '../../../core/utils/debouncer.dart';
import '../cubit/candidates_list_cubit.dart';
import '../cubit/candidates_list_state.dart';
import '../widgets/candidate_card.dart';
import '../widgets/filter_chips_row.dart';
import '../widgets/offline_banner.dart';
import '../widgets/skeleton_card.dart';
import '../widgets/sort_bottom_sheet.dart';

class CandidatesListScreen extends StatefulWidget {
  const CandidatesListScreen({super.key});

  @override
  State<CandidatesListScreen> createState() => _CandidatesListScreenState();
}

class _CandidatesListScreenState extends State<CandidatesListScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    context.read<CandidatesListCubit>().load();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CandidatesListCubit>().loadNextPage();
    }
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
      appBar: AppBar(
        title: const Text('Кандидаты'),
        actions: [
          BlocBuilder<CandidatesListCubit, CandidatesListState>(
            buildWhen: (a, b) => a.sortBy != b.sortBy || a.status != b.status,
            builder:
                (context, state) => IconButton(
                  icon: const Icon(Icons.sort_rounded),
                  tooltip: 'Сортировка',
                  onPressed:
                      state.status == CandidatesListStatus.loaded
                          ? () => _showSortSheet(context, state.sortBy)
                          : null,
                ),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<CandidatesListCubit, CandidatesListState>(
            buildWhen: (a, b) => a.isOffline != b.isOffline,
            builder:
                (_, state) =>
                    state.isOffline
                        ? const OfflineBanner()
                        : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск по имени...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder:
                      (_, value, _) =>
                          value.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<CandidatesListCubit>().search(
                                    '',
                                  );
                                },
                              )
                              : const SizedBox.shrink(),
                ),
              ),
              onChanged:
                  (q) => _debouncer.run(
                    () => context.read<CandidatesListCubit>().search(q),
                  ),
            ),
          ),
          BlocBuilder<CandidatesListCubit, CandidatesListState>(
            buildWhen: (a, b) => a.verdictFilter != b.verdictFilter,
            builder:
                (context, state) => FilterChipsRow(
                  selected: state.verdictFilter,
                  onSelected:
                      context.read<CandidatesListCubit>().filterByVerdict,
                ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CandidatesListCubit, CandidatesListState>(
      buildWhen:
          (a, b) =>
              a.status != b.status ||
              a.displayedCandidates != b.displayedCandidates ||
              a.hasMore != b.hasMore,
      builder:
          (context, state) => switch (state.status) {
            CandidatesListStatus.initial ||
            CandidatesListStatus.loading => ListView.builder(
              itemCount: 6,
              itemBuilder: (_, _) => const SkeletonCard(),
            ),
            CandidatesListStatus.error => _ErrorView(
              message: state.errorMessage ?? 'Неизвестная ошибка',
              onRetry:
                  () => context.read<CandidatesListCubit>().load(
                    forceRefresh: true,
                  ),
            ),
            CandidatesListStatus.loaded when state.filteredCandidates.isEmpty =>
              const _EmptyView(),
            CandidatesListStatus.loaded => RefreshIndicator(
              onRefresh:
                  () => context.read<CandidatesListCubit>().load(
                    forceRefresh: true,
                  ),
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount:
                    state.displayedCandidates.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.displayedCandidates.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final candidate = state.displayedCandidates[index];
                  return CandidateCard(
                    key: ValueKey(candidate.id),
                    candidate: candidate,
                    onTap: () => context.push('/candidate/${candidate.id}'),
                  );
                },
              ),
            ),
          },
    );
  }

  void _showSortSheet(BuildContext context, SortOption current) {
    showModalBottomSheet<void>(
      context: context,
      builder:
          (_) => SortBottomSheet(
            current: current,
            onSelect: context.read<CandidatesListCubit>().sortBy,
          ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Кандидаты не найдены',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Попробуйте изменить фильтры или запрос',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
