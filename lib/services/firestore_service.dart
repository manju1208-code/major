import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/character.dart';
import '../models/parva.dart';
import '../models/quiz_question.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ---------- CHARACTERS ----------
  Stream<List<Character>> getCharacters() {
    return _db.collection('characters').orderBy('nameEn').snapshots().map(
        (snap) => snap.docs
            .map((d) => Character.fromMap(d.id, d.data()))
            .toList());
  }

  Future<void> addOrUpdateCharacter(Character c) async {
    await _db.collection('characters').doc(c.id).set(c.toMap());
  }

  Future<void> deleteCharacter(String id) async {
    await _db.collection('characters').doc(id).delete();
  }

  // ---------- PARVAS ----------
  Stream<List<Parva>> getParvas() {
    return _db.collection('parvas').orderBy('number').snapshots().map(
        (snap) =>
            snap.docs.map((d) => Parva.fromMap(d.id, d.data())).toList());
  }

  Future<void> addOrUpdateParva(Parva p) async {
    await _db.collection('parvas').doc(p.id).set(p.toMap());
  }

  Future<void> deleteParva(String id) async {
    await _db.collection('parvas').doc(id).delete();
  }

  // ---------- QUIZ ----------
  Stream<List<QuizQuestion>> getQuizQuestions() {
    return _db.collection('quiz_questions').snapshots().map((snap) => snap
        .docs
        .map((d) => QuizQuestion.fromMap(d.id, d.data()))
        .toList());
  }

  Future<void> addOrUpdateQuizQuestion(QuizQuestion q) async {
    await _db.collection('quiz_questions').doc(q.id).set(q.toMap());
  }

  Future<void> deleteQuizQuestion(String id) async {
    await _db.collection('quiz_questions').doc(id).delete();
  }

  Future<void> saveQuizResult(QuizResult result) async {
    await _db.collection('quiz_results').add(result.toMap());
  }

  Stream<List<QuizResult>> getUserQuizResults(String userId) {
    return _db
        .collection('quiz_results')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => QuizResult.fromMap(d.data())).toList());
  }

  // ---------- FAVORITES ----------
  Future<void> toggleFavorite(String userId, String characterId, bool isFav) async {
    final ref = _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(characterId);
    if (isFav) {
      await ref.set({'characterId': characterId});
    } else {
      await ref.delete();
    }
  }

  Stream<List<String>> getFavoriteIds(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.id).toList());
  }
}
