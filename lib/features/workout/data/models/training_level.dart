enum TrainingLevel {
  beginner(
    id: 'beginner',
    title: 'Iniciante',
  ),

  intermediate(
    id: 'intermediate',
    title: 'Intermediário',
  ),

  advanced(
    id: 'advanced',
    title: 'Avançado',
  );

  final String id;
  final String title;

  const TrainingLevel({
    required this.id,
    required this.title,
  });
}