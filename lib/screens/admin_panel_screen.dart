import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/parva.dart';
import '../models/quiz_question.dart';
import '../services/firestore_service.dart';
import '../data/sample_data.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen>
    with SingleTickerProviderStateMixin {
  final _firestoreService = FirestoreService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _seedSampleData() async {
    for (final c in sampleCharacters) {
      await _firestoreService.addOrUpdateCharacter(c);
    }
    for (final p in sampleParvas) {
      await _firestoreService.addOrUpdateParva(p);
    }
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Sample data added!')));
    }
  }

  void _showCharacterForm({Character? existing}) {
    final idController = TextEditingController(text: existing?.id ?? '');
    final nameEnController = TextEditingController(text: existing?.nameEn ?? '');
    final nameTeController = TextEditingController(text: existing?.nameTe ?? '');
    final descEnController = TextEditingController(text: existing?.descriptionEn ?? '');
    final descTeController = TextEditingController(text: existing?.descriptionTe ?? '');
    final roleController = TextEditingController(text: existing?.role ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16, right: 16, top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(existing == null ? 'Add Character' : 'Edit Character',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(controller: idController, enabled: existing == null,
                  decoration: const InputDecoration(labelText: 'ID (unique, no spaces)')),
              TextField(controller: nameEnController, decoration: const InputDecoration(labelText: 'Name (English)')),
              TextField(controller: nameTeController, decoration: const InputDecoration(labelText: 'Name (Telugu)')),
              TextField(controller: roleController, decoration: const InputDecoration(labelText: 'Role')),
              TextField(controller: descEnController, maxLines: 3, decoration: const InputDecoration(labelText: 'Description (English)')),
              TextField(controller: descTeController, maxLines: 3, decoration: const InputDecoration(labelText: 'Description (Telugu)')),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (idController.text.trim().isEmpty) return;
                  await _firestoreService.addOrUpdateCharacter(Character(
                    id: idController.text.trim(),
                    nameEn: nameEnController.text.trim(),
                    nameTe: nameTeController.text.trim(),
                    descriptionEn: descEnController.text.trim(),
                    descriptionTe: descTeController.text.trim(),
                    role: roleController.text.trim(),
                  ));
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showParvaForm({Parva? existing}) {
    final idController = TextEditingController(text: existing?.id ?? '');
    final numberController = TextEditingController(text: existing?.number.toString() ?? '');
    final nameEnController = TextEditingController(text: existing?.nameEn ?? '');
    final nameTeController = TextEditingController(text: existing?.nameTe ?? '');
    final descEnController = TextEditingController(text: existing?.descriptionEn ?? '');
    final descTeController = TextEditingController(text: existing?.descriptionTe ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16, right: 16, top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(existing == null ? 'Add Parva' : 'Edit Parva',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(controller: idController, enabled: existing == null,
                  decoration: const InputDecoration(labelText: 'ID (unique, no spaces)')),
              TextField(controller: numberController, keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Parva Number')),
              TextField(controller: nameEnController, decoration: const InputDecoration(labelText: 'Name (English)')),
              TextField(controller: nameTeController, decoration: const InputDecoration(labelText: 'Name (Telugu)')),
              TextField(controller: descEnController, maxLines: 3, decoration: const InputDecoration(labelText: 'Description (English)')),
              TextField(controller: descTeController, maxLines: 3, decoration: const InputDecoration(labelText: 'Description (Telugu)')),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (idController.text.trim().isEmpty) return;
                  await _firestoreService.addOrUpdateParva(Parva(
                    id: idController.text.trim(),
                    number: int.tryParse(numberController.text.trim()) ?? 0,
                    nameEn: nameEnController.text.trim(),
                    nameTe: nameTeController.text.trim(),
                    descriptionEn: descEnController.text.trim(),
                    descriptionTe: descTeController.text.trim(),
                  ));
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(text: 'Characters'),
          Tab(text: 'Parvas'),
          Tab(text: 'Quiz'),
        ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            tooltip: 'Seed sample data',
            onPressed: _seedSampleData,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCharactersTab(),
          _buildParvasTab(),
          _buildQuizTab(),
        ],
      ),
    );
  }

  Widget _buildCharactersTab() {
    return Stack(
      children: [
        StreamBuilder<List<Character>>(
          stream: _firestoreService.getCharacters(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            final characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final c = characters[index];
                return ListTile(
                  title: Text(c.nameEn),
                  subtitle: Text(c.nameTe),
                  onTap: () => _showCharacterForm(existing: c),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _firestoreService.deleteCharacter(c.id),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 16, right: 16,
          child: FloatingActionButton(
            onPressed: () => _showCharacterForm(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildParvasTab() {
    return Stack(
      children: [
        StreamBuilder<List<Parva>>(
          stream: _firestoreService.getParvas(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            final parvas = snapshot.data!;
            return ListView.builder(
              itemCount: parvas.length,
              itemBuilder: (context, index) {
                final p = parvas[index];
                return ListTile(
                  title: Text('${p.number}. ${p.nameEn}'),
                  subtitle: Text(p.nameTe),
                  onTap: () => _showParvaForm(existing: p),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _firestoreService.deleteParva(p.id),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          bottom: 16, right: 16,
          child: FloatingActionButton(
            onPressed: () => _showParvaForm(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizTab() {
    return StreamBuilder<List<QuizQuestion>>(
      stream: _firestoreService.getQuizQuestions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final questions = snapshot.data!;
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return ListTile(
                    title: Text(q.question),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _firestoreService.deleteQuizQuestion(q.id),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Load Sample Quiz Questions'),
                onPressed: () async {
                  for (final q in sampleQuizQuestions) {
                    await _firestoreService.addOrUpdateQuizQuestion(q);
                  }
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sample quiz questions added!')));
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
