class PostModel {
  final String text;
  final String postedById;
  final String id;
  final List<String> likedBy;
  final double likes;
  final String postedByName;
  final DateTime createdAt;
  final String category;
  final String subject;

  PostModel({
    required this.text,
    required this.postedById,
    required this.id,
    required this.likedBy,
    required this.postedByName,
    required this.createdAt,
    required this.likes,
    required this.category,
    required this.subject,
  });

  PostModel copyWith({
    String? id,
    String? text,
    String? postedById,
    String? postedByName,
    List<String>? likedBy,
    double? likes,
    DateTime? createdAt,
    String? category,
    String? subject,
  }) {
    return PostModel(
      id: id ?? this.id,
      text: text ?? this.text,
      postedById: postedById ?? this.postedById,
      postedByName: postedByName ?? this.postedByName,
      likedBy: likedBy ?? this.likedBy,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      subject: subject ?? this.subject,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'postedById': postedById,
      'postedByName': postedByName,
      'likedBy': likedBy,
      'likes': likes,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'category': category,
      'subject': subject,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      postedById: map['postedById'] ?? '',
      postedByName: map['postedByName'] ?? '',
      likedBy: List<String>.from(map['likedBy'] ?? []),
      likes: map['likes'] ?? 0,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      category: map['category'] ?? '',
      subject: map['subject'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Post(id: $id, createdAt: $createdAt, text: $text, postedById: $postedById, postedByName: $postedByName, likedBy: $likedBy, likes: $likes, category: $category, subject: $subject)';
  }
}
