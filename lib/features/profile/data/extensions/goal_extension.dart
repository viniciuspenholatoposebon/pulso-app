import '../enums/goal.dart';

extension GoalExtension on Goal {
  String get title {
    switch (this) {
      case Goal.loseWeight:
        return 'Emagrecer';

      case Goal.bodyRecomposition:
        return 'Recomposição corporal';

      case Goal.gainMuscle:
        return 'Ganhar massa muscular';

      case Goal.improveHealth:
        return 'Melhorar a saúde';

      case Goal.improvePerformance:
        return 'Melhorar o desempenho';
    }
  }

  String get description {
    switch (this) {
      case Goal.loseWeight:
        return 'Reduza seu percentual de gordura com uma rotina personalizada.';

      case Goal.bodyRecomposition:
        return 'Ganhe massa muscular enquanto reduz gordura corporal.';

      case Goal.gainMuscle:
        return 'Aumente sua massa muscular, força e definição.';

      case Goal.improveHealth:
        return 'Desenvolva hábitos saudáveis e melhore sua qualidade de vida.';

      case Goal.improvePerformance:
        return 'Evolua seu condicionamento físico e desempenho esportivo.';
    }
  }

  String get emoji {
    switch (this) {
      case Goal.loseWeight:
        return '🔥';

      case Goal.bodyRecomposition:
        return '⚖️';

      case Goal.gainMuscle:
        return '💪';

      case Goal.improveHealth:
        return '❤️';

      case Goal.improvePerformance:
        return '🏃';
    }
  }
}
