class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory QuizQuestion.fromMap(String id, Map<String, dynamic> map) {
    return QuizQuestion(
      id: id,
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctIndex: map['correctIndex'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
    };
  }
}

class QuizResult {
  final String userId;
  final int score;
  final int total;
  final DateTime date;

  QuizResult({
    required this.userId,
    required this.score,
    required this.total,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'score': score,
      'total': total,
      'date': date.toIso8601String(),
    };
  }

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      userId: map['userId'] ?? '',
      score: map['score'] ?? 0,
      total: map['total'] ?? 0,
      date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
    );
  }
}
