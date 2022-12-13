class Todo {
  final int id;
  final String title;
  late bool status;
  final String? description;

  Todo({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
  });
}
