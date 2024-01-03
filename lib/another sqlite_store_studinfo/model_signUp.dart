class SignUpDataModel{

  final String id;
  final String email;
  final String pass;

  SignUpDataModel({
    required this.email,
    required this.pass,
    required this.id
  });

  factory SignUpDataModel.fromJson(Map<String,dynamic> data){
    return SignUpDataModel(
        email: data['id'],
        pass: data['email'],
        id: data['pass']
    );
  }
  Map<String,dynamic> toMap()=>
      {
        'email': email,
        'pass': pass,
        'id': id
      };
}