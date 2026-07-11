import 'package:flutter/material.dart';
import '../models/parva.dart';

class ParvaDetailScreen extends StatelessWidget {
  final Parva parva;
  const ParvaDetailScreen({super.key, required this.parva});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parva.nameEn)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(parva.nameTe, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('English', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(parva.descriptionEn),
            if (parva.keyEventsEn.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Key Events', style: Theme.of(context).textTheme.titleSmall),
              Text(parva.keyEventsEn),
            ],
            const SizedBox(height: 16),
            Text('తెలుగు', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(parva.descriptionTe),
            if (parva.keyEventsTe.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('ముఖ్య సంఘటనలు', style: Theme.of(context).textTheme.titleSmall),
              Text(parva.keyEventsTe),
            ],
          ],
        ),
      ),
    );
  }
}
