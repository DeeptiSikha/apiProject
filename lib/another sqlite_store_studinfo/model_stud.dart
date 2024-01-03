import 'dart:convert';

class StudInfo{

  final String id;
  final String name;
  final String age;
  final String img;

  StudInfo({
    required this.id,
    required this.name,
    required this.age,
    required this.img
  });

  factory StudInfo.frmJson(Map<String,dynamic> data){
    return StudInfo(
        id: data['id'],
        name: data['name'],
        age: data['age'],
        img: data['img']
    );
  }
}