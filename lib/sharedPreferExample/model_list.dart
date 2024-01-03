
class PersonModel{


  String? name,age,phone;

  PersonModel({ this.name, this.age, this.phone});

  PersonModel.fromMap(Map map)
      : this.name = map["name"],
        this.age = map["age"],
        this.phone = map["phone"];

  Map toMap(){
    return {
      "name":name,
      "age":age,
      "phone":phone
    };
  }
}