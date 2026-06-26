import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

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
  dispose() {
    _cubit.close();
    super.dispose();
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
              CandidateDetailStatus.notFound => const NotFoundBody(),
              _ when state.candidate != null => DetailBody(state.candidate!),
              _ => ErrorBody(
                message: state.errorMessage,
                onRetry: () => _cubit.load(widget.id),
              ),
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
                  onChanged: _cubit.updateStatus,
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
