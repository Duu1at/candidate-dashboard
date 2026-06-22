import 'package:flutter/material.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.error,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.onError,
          ),
          const SizedBox(width: 8),
          Text(
            'Нет соединения — данные из кэша',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onError,
                ),
          ),
        ],
      ),
    );
  }
}
