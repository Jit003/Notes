import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note_rounded,
            size: 80,
            color: AppColors.textSecondary.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          const Text(
            "No thoughts captured yet",
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}