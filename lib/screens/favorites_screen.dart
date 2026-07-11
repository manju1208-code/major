import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../widgets/character_card.dart';
import 'character_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final firestoreService = FirestoreService();
    final userId = authService.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('My Favorites')),
      body: StreamBuilder<List<String>>(
        stream: firestoreService.getFavoriteIds(userId),
        builder: (context, favSnapshot) {
          final favIds = favSnapshot.data ?? [];
          if (favIds.isEmpty) {
            return const Center(child: Text('No favorites yet. Tap the heart icon on a character!'));
          }
          return StreamBuilder<List<Character>>(
            stream: firestoreService.getCharacters(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final favChars = snapshot.data!.where((c) => favIds.contains(c.id)).toList();
              return ListView.builder(
                itemCount: favChars.length,
                itemBuilder: (context, index) {
                  final c = favChars[index];
                  return CharacterCard(
                    character: c,
                    isFavorite: true,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CharacterDetailScreen(character: c))),
                    onFavoriteToggle: () => firestoreService.toggleFavorite(userId, c.id, false),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
