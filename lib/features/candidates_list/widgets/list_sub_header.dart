import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

class ListSubHeader extends StatelessWidget {
  const ListSubHeader({
    required this.shown,
    required this.total,
    required this.sortOption,
    super.key,
  });

  final int shown;
  final int total;
  final SortOption sortOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.x5,
        AppSpacing.x3,
        AppSpacing.x5,
        AppSpacing.x2,
      ),
      child: Row(
        children: [
          Text(
            'Показано $shown из $total',
            style: context.appTextStyles.muted.labelMedium,
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              builder: (_) => SortBottomSheet(
                current: sortOption,
                onSelect: context.read<CandidatesListCubit>().sortBy,
              ),
            ),
            icon: const Icon(Icons.sort_rounded, size: 16),
            label: Text(
              sortOption.label,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: context.colors.primary,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
