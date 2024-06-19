class Users {
  dynamic userId;
  String mail;
  String fullName;

  Users({
    this.userId,
    required this.mail,
    required this.fullName,
  });

  factory Users.fromMap(Map<String, dynamic> map, {dynamic key}) {
    return Users(
      userId: key ?? map['userId'],
      mail: map['mail'] ?? '',
      fullName: map['fullName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId ?? userId,
      'mail': mail,
      'fullName': fullName,
    };
  }
}