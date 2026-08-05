enum TrainingGoal {
  hypertrophy(
    id: 'hypertrophy',
    title: 'Hipertrofia',
    description: 'Ganho de massa muscular.',
  ),

  weightLoss(
    id: 'weight_loss',
    title: 'Emagrecimento',
    description: 'Perda de gordura corporal.',
  ),

  strength(
    id: 'strength',
    title: 'Força',
    description: 'Aumento de força máxima.',
  ),

  endurance(
    id: 'endurance',
    title: 'Resistência',
    description: 'Melhorar condicionamento muscular.',
  ),

  conditioning(
    id: 'conditioning',
    title: 'Condicionamento',
    description: 'Melhorar condicionamento físico geral.',
  );

  final String id;
  final String title;
  final String description;

  const TrainingGoal({
    required this.id,
    required this.title,
    required this.description,
  });
}