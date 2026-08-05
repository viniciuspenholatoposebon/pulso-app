import 'package:flutter/material.dart';

class LoadingExercises extends StatelessWidget {
  const LoadingExercises({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}