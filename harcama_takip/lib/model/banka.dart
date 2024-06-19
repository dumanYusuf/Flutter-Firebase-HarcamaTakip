class Banka {
  dynamic bankaId;
  String bankaName;
  int harmaMiktari;

  Banka({
    this.bankaId,
    required this.bankaName,
    required this.harmaMiktari,
  });

  factory Banka.fromMap(Map<String, dynamic> map, {dynamic key}) {
    return Banka(
      bankaId: key ?? map['bankaId'],
      bankaName: map['bankaName'] ?? '',
      harmaMiktari: map['harmaMiktari'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bankaId': bankaId,
      'bankaName': bankaName,
      'harmaMiktari': harmaMiktari,
    };
  }
}