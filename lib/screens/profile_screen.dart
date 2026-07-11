import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final firestoreService = FirestoreService();
    final userId = authService.currentUser?.uid ?? '';
    final email = authService.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
                const SizedBox(height: 8),
                Text(email, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Quiz History', style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<QuizResult>>(
              stream: firestoreService.getUserQuizResults(userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final results = snapshot.data!;
                if (results.isEmpty) {
                  return const Center(child: Text('No quiz attempts yet.'));
                }
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final r = results[index];
                    return ListTile(
                      leading: const Icon(Icons.quiz),
                      title: Text('Score: ${r.score} / ${r.total}'),
                      subtitle: Text(r.date.toString().substring(0, 16)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
