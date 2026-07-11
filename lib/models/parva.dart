class Parva {
  final String id;
  final int number;
  final String nameEn;
  final String nameTe;
  final String descriptionEn;
  final String descriptionTe;
  final String keyEventsEn;
  final String keyEventsTe;

  Parva({
    required this.id,
    required this.number,
    required this.nameEn,
    required this.nameTe,
    required this.descriptionEn,
    required this.descriptionTe,
    this.keyEventsEn = '',
    this.keyEventsTe = '',
  });

  factory Parva.fromMap(String id, Map<String, dynamic> map) {
    return Parva(
      id: id,
      number: map['number'] ?? 0,
      nameEn: map['nameEn'] ?? '',
      nameTe: map['nameTe'] ?? '',
      descriptionEn: map['descriptionEn'] ?? '',
      descriptionTe: map['descriptionTe'] ?? '',
      keyEventsEn: map['keyEventsEn'] ?? '',
      keyEventsTe: map['keyEventsTe'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'nameEn': nameEn,
      'nameTe': nameTe,
      'descriptionEn': descriptionEn,
      'descriptionTe': descriptionTe,
      'keyEventsEn': keyEventsEn,
      'keyEventsTe': keyEventsTe,
    };
  }
}
