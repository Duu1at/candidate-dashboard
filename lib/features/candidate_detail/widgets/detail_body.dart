import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';
import 'package:flutter/material.dart';

const _kMaxContentWidth = 700.0;

class DetailBody extends StatelessWidget {
  const DetailBody(this.candidate, {super.key});
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
