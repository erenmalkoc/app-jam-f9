class UserModel {
  final String name;
  final String uid;
  final String email;

  UserModel({required this.name, required this.uid, required this.email});

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
    );
  }
  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, email: $email )';
  }
}
