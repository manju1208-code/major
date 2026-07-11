class Character {
  final String id;
  final String nameEn;
  final String nameTe;
  final String descriptionEn;
  final String descriptionTe;
  final String imageUrl;
  final String role; // e.g. Hero, Villain, Sage

  Character({
    required this.id,
    required this.nameEn,
    required this.nameTe,
    required this.descriptionEn,
    required this.descriptionTe,
    this.imageUrl = '',
    this.role = '',
  });

  factory Character.fromMap(String id, Map<String, dynamic> map) {
    return Character(
      id: id,
      nameEn: map['nameEn'] ?? '',
      nameTe: map['nameTe'] ?? '',
      descriptionEn: map['descriptionEn'] ?? '',
      descriptionTe: map['descriptionTe'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      role: map['role'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameEn': nameEn,
      'nameTe': nameTe,
      'descriptionEn': descriptionEn,
      'descriptionTe': descriptionTe,
      'imageUrl': imageUrl,
      'role': role,
    };
  }
}
