import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;
  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.nameEn)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(character.nameTe,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Chip(label: Text(character.role)),
            const SizedBox(height: 16),
            Text('English', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(character.descriptionEn),
            const SizedBox(height: 16),
            Text('తెలుగు', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(character.descriptionTe),
          ],
        ),
      ),
    );
  }
}
