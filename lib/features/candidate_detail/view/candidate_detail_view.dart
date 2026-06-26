import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

const _kMaxContentWidth = 700.0;

class CandidateDetailView extends StatefulWidget {
  const CandidateDetailView({super.key, required this.id});
  final String id;

  @override
  State<CandidateDetailView> createState() => _CandidateDetailViewState();
}

class _CandidateDetailViewState extends State<CandidateDetailView> {
  late final CandidateDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = CandidateDetailCubit(getIt<CandidateRepository>());
    _cubit.load(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CandidateDetailCubit, CandidateDetailState>(
      bloc: _cubit,
      listenWhen: (a, b) =>
          a.status == CandidateDetailStatus.updatingStatus &&
          (b.status == CandidateDetailStatus.loaded ||
              b.status == CandidateDetailStatus.error),
      listener: (context, state) {
        if (state.status == CandidateDetailStatus.error) {
          _onError(context, state.errorMessage);
        } else {
          _onSuccess(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            'Кандидат',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
        body: BlocBuilder<CandidateDetailCubit, CandidateDetailState>(
          bloc: _cubit,
          buildWhen: (a, b) {
            return a.status != b.status || a.candidate != b.candidate;
          },
          builder: (_, state) {
            return switch (state.status) {
              CandidateDetailStatus.initial || CandidateDetailStatus.loading =>
                const Center(child: CircularProgressIndicator()),
              CandidateDetailStatus.notFound => const _NotFoundBody(),
              _ when state.candidate != null => _DetailBody(state.candidate!),
              _ => const SizedBox.shrink(),
            };
          },
        ),
        bottomNavigationBar:
            BlocBuilder<CandidateDetailCubit, CandidateDetailState>(
              bloc: _cubit,
              buildWhen: (a, b) {
                return a.candidate?.status != b.candidate?.status ||
                    a.status != b.status;
              },
              builder: (context, state) {
                if (state.candidate == null) return const SizedBox.shrink();
                return StatusSelector(
                  currentStatus: state.candidate!.status,
                  isUpdating:
                      state.status == CandidateDetailStatus.updatingStatus,
                  onChanged: context.read<CandidateDetailCubit>().updateStatus,
                );
              },
            ),
      ),
    );
  }

  void _onError(BuildContext context, String? errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage ?? 'Ошибка обновления статуса'),
        backgroundColor: context.colors.error,
      ),
    );
  }

  void _onSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Статус обновлён')),
    );
  }
}

class _NotFoundBody extends StatelessWidget {
  const _NotFoundBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 64,
            color: context.colors.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.x4),
          Text('Кандидат не найден', style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody(this.candidate);

  final CandidateModel candidate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CandidateHero(candidate),
              const SizedBox(height: AppSpacing.x4),
              ContactButtons(candidate),
              const SizedBox(height: AppSpacing.x4),
              ExperienceSection(candidate.exp),
              const SizedBox(height: AppSpacing.x4),
              if (candidate.edu.isNotEmpty) ...[
                EducationSection(
                  institution: candidate.eduInstitution,
                  details: candidate.eduDetails,
                ),
                const SizedBox(height: AppSpacing.x4),
              ],
              StackSection(candidate.stackTags),
              const SizedBox(height: AppSpacing.x4),
              CriteriaSection(candidate.criteria),
              const SizedBox(height: AppSpacing.x4),
              QuestionsSection(candidate.questions),
              const SizedBox(height: AppSpacing.x4),
              SummarySection(candidate.summary),
            ],
          ),
        ),
      ),
    );
  }
}
