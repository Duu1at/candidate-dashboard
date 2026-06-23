import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.appColors.offlineBannerBg,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.x2,
          horizontal: AppSpacing.x5,
        ),
        child: Row(
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 17,
              color: context.appColors.offlineBannerText,
            ),
            const SizedBox(width: AppSpacing.x2),
            Text(
              'Нет сети — показаны сохранённые данные',
              style: context.textTheme.labelMedium?.copyWith(
                color: context.appColors.offlineBannerText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
