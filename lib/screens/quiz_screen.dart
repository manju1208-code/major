import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final _firestoreService = FirestoreService();
  final _authService = AuthService();
  int _currentIndex = 0;
  int _score = 0;
  bool _finished = false;
  int? _selectedOption;

  void _selectOption(List<QuizQuestion> questions, int index) {
    if (_selectedOption != null) return;
    setState(() {
      _selectedOption = index;
      if (index == questions[_currentIndex].correctIndex) {
        _score++;
      }
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        if (_currentIndex < questions.length - 1) {
          _currentIndex++;
          _selectedOption = null;
        } else {
          _finished = true;
          _saveResult(questions.length);
        }
      });
    });
  }

  void _saveResult(int total) {
    final userId = _authService.currentUser?.uid ?? '';
    _firestoreService.saveQuizResult(
      QuizResult(userId: userId, score: _score, total: total, date: DateTime.now()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mahabharatam Quiz')),
      body: StreamBuilder<List<QuizQuestion>>(
        stream: _firestoreService.getQuizQuestions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final questions = snapshot.data!;
          if (questions.isEmpty) {
            return const Center(child: Text('No quiz questions yet. Add via Admin Panel.'));
          }
          if (_finished || _currentIndex >= questions.length) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.emoji_events, size: 64, color: Colors.amber),
                  const SizedBox(height: 12),
                  Text('Score: $_score / ${questions.length}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      _currentIndex = 0;
                      _score = 0;
                      _finished = false;
                      _selectedOption = null;
                    }),
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            );
          }
          final q = questions[_currentIndex];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Question ${_currentIndex + 1} / ${questions.length}',
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                Text(q.question, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 24),
                ...List.generate(q.options.length, (i) {
                  Color? color;
                  if (_selectedOption != null) {
                    if (i == q.correctIndex) color = Colors.green.shade300;
                    else if (i == _selectedOption) color = Colors.red.shade300;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: color),
                        onPressed: () => _selectOption(questions, i),
                        child: Text(q.options[i]),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
