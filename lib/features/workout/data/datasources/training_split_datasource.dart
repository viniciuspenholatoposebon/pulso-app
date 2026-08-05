import '../models/training_split.dart';

class TrainingSplitDatasource {
  const TrainingSplitDatasource();

  List<TrainingSplit> getSplits() {
    return const [
      TrainingSplit(
        id: 'ab',
        name: 'AB',
        trainingDays: 2,
        weekDays: [
          'Segunda',
          'Quinta',
        ],
        muscleGroups: [
          'Peito + Ombros + Tríceps',
          'Costas + Bíceps + Pernas',
        ],
      ),
      TrainingSplit(
        id: 'abc',
        name: 'ABC',
        trainingDays: 3,
        weekDays: [
          'Segunda',
          'Quarta',
          'Sexta',
        ],
        muscleGroups: [
          'Peito + Tríceps',
          'Costas + Bíceps',
          'Pernas + Ombros',
        ],
      ),
      TrainingSplit(
        id: 'abcd',
        name: 'ABCD',
        trainingDays: 4,
        weekDays: [
          'Segunda',
          'Terça',
          'Quinta',
          'Sexta',
        ],
        muscleGroups: [
          'Peito',
          'Costas',
          'Pernas',
          'Ombros + Braços',
        ],
      ),
      TrainingSplit(
        id: 'abcde',
        name: 'ABCDE',
        trainingDays: 5,
        weekDays: [
          'Segunda',
          'Terça',
          'Quarta',
          'Quinta',
          'Sexta',
        ],
        muscleGroups: [
          'Peito',
          'Costas',
          'Pernas',
          'Ombros',
          'Braços',
        ],
      ),
      TrainingSplit(
        id: 'abcdef',
        name: 'ABCDEF',
        trainingDays: 6,
        weekDays: [
          'Segunda',
          'Terça',
          'Quarta',
          'Quinta',
          'Sexta',
          'Sábado',
        ],
        muscleGroups: [
          'Peito',
          'Costas',
          'Pernas',
          'Ombros',
          'Braços',
          'Posterior + Abdômen',
        ],
      ),
    ];
  }
}