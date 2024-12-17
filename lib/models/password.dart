class Password {
  final int? id;
  final int userId;
  final String title;
  final String username;
  final String password;

  Password({
    this.id,
    required this.userId,
    required this.title,
    required this.username,
    required this.password,
  });

  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      username: map['username'],
      password: map['password'], // Encrypted password will be decrypted later
    );
  }
}
