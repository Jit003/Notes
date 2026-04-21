import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import
import '../../../../core/theme/app_colors.dart';

class NoteCard extends StatelessWidget {
  final String noteText;
  final DateTime timestamp; // Change type from String to DateTime

  const NoteCard({
    super.key,
    required this.noteText,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    // Format inside the build method
    final String formattedTime = DateFormat('MMM d, h:mm a').format(timestamp);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noteText,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                formattedTime, // Use formatted string here
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}