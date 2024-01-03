class User {
  String name, age, profession;

  User({required this.name, required this.age, required this.profession});

  factory User.fromMap(Map<String,dynamic> data)=> User(
      name: data['name'],
      age: data['age'],
      profession: data['profession']
  );
  Map<String,dynamic> toMap() {
    return {
      'name':name,
      'age':age,
      'profession':profession
    };
  }
}