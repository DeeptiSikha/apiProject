class TodoModel{

  late final String id;
  late final String title;
  late final String subtitle;
  TodoModel({
    required this.id,
    required this.title,
    required this.subtitle
  });
  factory TodoModel.fromJson(Map<String,dynamic>data){
    return TodoModel(
        id: data['id'],
        title: data['title'],
        subtitle: data['subtitle']
    );
  }
}