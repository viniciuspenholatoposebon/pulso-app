import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/exercise.dart';

class ExerciseLocalDatasource {
  static const String _assetPath =
      'assets/exercises/exercises.json';

  Future<List<Exercise>> getAllExercises() async {
    final jsonString = await rootBundle.loadString(
      _assetPath,
    );

    final List<dynamic> json = jsonDecode(jsonString);

    return json
        .map(
          (e) => Exercise.fromMap(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();
  }

  Future<List<Exercise>> searchExercises(
    String query,
  ) async {
    final exercises = await getAllExercises();

    if (query.trim().isEmpty) {
      return exercises;
    }

    final search = query.toLowerCase();

    return exercises.where((exercise) {
      return exercise.name
              .toLowerCase()
              .contains(search) ||
          exercise.muscleGroupId
              .toLowerCase()
              .contains(search) ||
          exercise.equipmentId
              .toLowerCase()
              .contains(search);
    }).toList();
  }

  Future<List<Exercise>> getExercisesByMuscle(
    String muscleGroupId,
  ) async {
    final exercises = await getAllExercises();

    return exercises.where((exercise) {
      return exercise.muscleGroupId ==
          muscleGroupId;
    }).toList();
  }

  Future<List<Exercise>> getFavoriteExercises() async {
    final exercises = await getAllExercises();

    return exercises
        .where((exercise) => exercise.isFavorite)
        .toList();
  }
}