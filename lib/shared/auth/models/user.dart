class User {
  final String id;
  final String name;
  final String email;
  final String? avatarSrc;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarSrc,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatarSrc: map['avatar_src'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'avatar_src': avatarSrc};
  }

  User copyWith({String? name, String? avatarSrc}) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email,
      avatarSrc: avatarSrc ?? this.avatarSrc,
    );
  }
}
