import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:candidate_dashboard/app.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    required this.searchController,
    required this.onSearch,
    required this.onClear,
    required this.onFilterSelected,
    super.key,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final VoidCallback onClear;
  final ValueChanged<String?> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        boxShadow: context.appColors.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<CandidatesListCubit, CandidatesListState>(
            buildWhen: (a, b) => a.isOffline != b.isOffline,
            builder: (_, state) => state.isOffline
                ? const OfflineBanner()
                : const SizedBox.shrink(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.x5,
              AppSpacing.x2,
              AppSpacing.x5,
              0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Кандидаты', style: context.textTheme.headlineLarge),
                      const SizedBox(height: AppSpacing.x1),
                      Text(
                        'Flutter — Middle · вакансия #FL-204',
                        style: context.appTextStyles.muted.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.x3),
                const _UserAvatar(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.x5,
              AppSpacing.x3,
              AppSpacing.x5,
              AppSpacing.x1,
            ),
            child: CandidatesSearchField(
              controller: searchController,
              onChanged: onSearch,
              onClear: onClear,
            ),
          ),
          BlocBuilder<CandidatesListCubit, CandidatesListState>(
            buildWhen: (a, b) => a.totalItems != b.totalItems,
            builder: (context, listState) {
              return BlocBuilder<CandidateFiltersCubit, CandidateFiltersState>(
                buildWhen: (a, b) => a.verdictFilter != b.verdictFilter,
                builder: (context, filtersState) {
                  return FilterChipsRow(
                    selected: filtersState.verdictFilter,
                    total: listState.totalItems,
                    onSelected: onFilterSelected,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar();

  void _showThemeSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => const _ThemeBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showThemeSheet(context),
      child: CircleAvatar(
        radius: 19,
        backgroundColor: context.colors.primary,
        child: Text(
          'АК',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.onPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ThemeBottomSheet extends StatelessWidget {
  const _ThemeBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.x5,
        0,
        AppSpacing.x5,
        AppSpacing.bottom(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Оформление',
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.x4),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: appThemeNotifier,
            builder: (_, themeMode, _) {
              final isDark = themeMode == ThemeMode.dark;
              return Row(
                children: [
                  Icon(
                    isDark
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    color: context.colors.onSurface,
                  ),
                  const SizedBox(width: AppSpacing.x3),
                  Expanded(
                    child: Text(
                      'Тёмная тема',
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  Switch(
                    value: isDark,
                    onChanged: (value) {
                      appThemeNotifier.value = value
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: AppSpacing.x2),
        ],
      ),
    );
  }
}
