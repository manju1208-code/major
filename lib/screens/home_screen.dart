import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../models/parva.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../theme/app_theme.dart';
import '../widgets/character_card.dart';
import 'character_detail_screen.dart';
import 'parva_detail_screen.dart';
import 'quiz_screen.dart';
import 'profile_screen.dart';
import 'admin_panel_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final userId = _authService.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahabharatam'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Characters'),
            Tab(text: 'Parvas'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(context.watch<ThemeProvider>().isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const QuizScreen())),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()));
              } else if (value == 'admin') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AdminPanelScreen()));
              } else if (value == 'logout') {
                _authService.signOut();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'profile', child: Text('Profile')),
              if (_authService.isAdmin)
                const PopupMenuItem(value: 'admin', child: Text('Admin Panel')),
              const PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCharactersList(userId),
                _buildParvasList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharactersList(String userId) {
    return StreamBuilder<List<Character>>(
      stream: _firestoreService.getCharacters(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        var characters = snapshot.data!;
        if (_searchQuery.isNotEmpty) {
          characters = characters
              .where((c) =>
                  c.nameEn.toLowerCase().contains(_searchQuery) ||
                  c.nameTe.contains(_searchQuery))
              .toList();
        }
        if (characters.isEmpty) {
          return const Center(child: Text('No characters found. Add some via Admin Panel.'));
        }
        return StreamBuilder<List<String>>(
          stream: _firestoreService.getFavoriteIds(userId),
          builder: (context, favSnapshot) {
            final favIds = favSnapshot.data ?? [];
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final c = characters[index];
                final isFav = favIds.contains(c.id);
                return CharacterCard(
                  character: c,
                  isFavorite: isFav,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CharacterDetailScreen(character: c))),
                  onFavoriteToggle: () =>
                      _firestoreService.toggleFavorite(userId, c.id, !isFav),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildParvasList() {
    return StreamBuilder<List<Parva>>(
      stream: _firestoreService.getParvas(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        var parvas = snapshot.data!;
        if (_searchQuery.isNotEmpty) {
          parvas = parvas
              .where((p) =>
                  p.nameEn.toLowerCase().contains(_searchQuery) ||
                  p.nameTe.contains(_searchQuery))
              .toList();
        }
        if (parvas.isEmpty) {
          return const Center(child: Text('No Parvas found. Add some via Admin Panel.'));
        }
        return ListView.builder(
          itemCount: parvas.length,
          itemBuilder: (context, index) {
            final p = parvas[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(child: Text('${p.number}')),
                title: Text('${p.nameEn} / ${p.nameTe}'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ParvaDetailScreen(parva: p))),
              ),
            );
          },
        );
      },
    );
  }
}
