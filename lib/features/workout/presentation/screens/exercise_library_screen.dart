import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/exercise_controller.dart';
import '../widgets/empty_exercises.dart';
import '../widgets/exercise_card.dart';
import '../widgets/exercise_search_bar.dart';
import '../widgets/loading_exercises.dart';
import 'exercise_details_screen.dart';

class ExerciseLibraryScreen extends ConsumerStatefulWidget {
  const ExerciseLibraryScreen({
    super.key,
  });

  @override
  ConsumerState<ExerciseLibraryScreen> createState() =>
      _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState
    extends ConsumerState<ExerciseLibraryScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercises =
        ref.watch(exerciseControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Biblioteca de Exercícios',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ExerciseSearchBar(
            controller: _searchController,
            onChanged: (value) {
              ref
                  .read(
                    exerciseControllerProvider
                        .notifier,
                  )
                  .search(value);
            },
          ),
          Expanded(
            child: exercises.when(
              loading: () =>
                  const LoadingExercises(),

              error: (error, stackTrace) {
                return Center(
                  child: Text(
                    error.toString(),
                  ),
                );
              },

              data: (items) {
                if (items.isEmpty) {
                  return const EmptyExercises();
                }

                return RefreshIndicator(
                  onRefresh: () {
                    return ref
                        .read(
                          exerciseControllerProvider
                              .notifier,
                        )
                        .refresh();
                  },
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.only(
                      top: 8,
                      bottom: 24,
                    ),
                    itemCount: items.length,
                    itemBuilder:
                        (context, index) {
                      final exercise =
                          items[index];

                      return ExerciseCard(
                        exercise: exercise,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ExerciseDetailsScreen(
                                exercise:
                                    exercise,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}