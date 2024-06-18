class Tag {
  final int id;
  final String value;
  final String userId;
  final List<String> tasks;

  Tag({
    required this.id,
    required this.value,
    required this.userId,
    this.tasks = const [],
  });

  @override
  String toString() {
    return 'Tag(id: $id, value: $value, userId: $userId)';
  }
}
