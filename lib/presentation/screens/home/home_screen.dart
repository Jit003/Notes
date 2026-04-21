import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/presentation/screens/home/widgets/add_note_sheet.dart';
import 'package:notes_app/presentation/screens/home/widgets/deletable_note_item.dart';
import 'package:notes_app/presentation/screens/home/widgets/home_empty_state.dart';
import 'package:notes_app/presentation/screens/home/widgets/home_header.dart';
import 'package:notes_app/presentation/screens/home/widgets/note_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/note/note_provider.dart';
import 'widgets/note_list_shimmer_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) => const AddNoteSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(noteProvider.notifier);
    final notes = ref.watch(noteProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Using the new high-end Header
            const HomeHeader(),

            Expanded(
              child: notifier.isLoading
                  ? const NoteShimmer()
                  : notes.isEmpty
                  ? const HomeEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 400),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, (1 - value) * 20),
                              child: Opacity(opacity: value, child: child),
                            );
                          },
                          child: DeletableNoteItem(note: notes[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBottomSheet(context),
        backgroundColor: AppColors.primary,
        elevation: 4,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          "New Note",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
