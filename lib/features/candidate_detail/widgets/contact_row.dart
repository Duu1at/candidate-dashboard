import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatelessWidget {
  const ContactRow({
    required this.icon,
    required this.label,
    required this.url,
    super.key,
  });

  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launch(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
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
