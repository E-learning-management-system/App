

class SignUpModel{
  String type, university, email, password, passwordConfirmation;
  SignUpModel(
      {  required this.type , required this.university ,
         required this.email, required this.password,
         required this.passwordConfirmation});

  factory SignUpModel.fromJson(Map<String,dynamic> json){
   return SignUpModel(type: json["type"]  , university: json["university"],
       email: json["email"], password: json["password"],
       passwordConfirmation:json["passwordConfirmation"] );
  }

}