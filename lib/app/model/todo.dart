class Todo {
  int? id;
  String? title;
  bool? status;
  String? description;

  Todo({this.id, this.title, this.status, this.description});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['description'] = description;
    return data;
  }
}
