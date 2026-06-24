import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

class ContactButtons extends StatelessWidget {
  const ContactButtons(this.candidate, {super.key});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (candidate.phone.isNotEmpty) ...[
          Expanded(
            child: _ContactCard(
              icon: Icons.phone_outlined,
              label: 'Позвонить',
              url: 'tel:${candidate.phone}',
            ),
          ),
        ],
        if (candidate.email.isNotEmpty) ...[
          if (candidate.phone.isNotEmpty) const SizedBox(width: AppSpacing.x2),
          Expanded(
            child: _ContactCard(
              icon: Icons.email_outlined,
              label: 'Email',
              url: 'mailto:${candidate.email}',
            ),
          ),
        ],
        if (candidate.tg.isNotEmpty) ...[
          if (candidate.phone.isNotEmpty || candidate.email.isNotEmpty)
            const SizedBox(width: AppSpacing.x2),
          Expanded(
            child: _ContactCard(
              icon: Icons.send_outlined,
              label: 'Telegram',
              url: 'https://t.me/${candidate.tg.replaceFirst("@", "")}',
            ),
          ),
        ],
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launch(context),
      borderRadius: AppRadius.contactCardBorderRadius,
      child: Ink(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: AppRadius.contactCardBorderRadius,
          boxShadow: context.appColors.shadowSm,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.x3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 19,
                backgroundColor: context.appColors.accentBlueSoft,
                child: Icon(icon, size: 18, color: context.colors.primary),
              ),
              const SizedBox(height: AppSpacing.x2),
              Text(
                label,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launch(BuildContext context) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось открыть ссылку')),
        );
      }
    }
  }
}
