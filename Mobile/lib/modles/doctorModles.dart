class DoctorModel {
  String? email;
  String? password;
  String? user_name;
  String? phone;

  String? name;

  DoctorModel(
    this.email,
    this.name,
    this.password,
    this.user_name,
    this.phone
  );
  DoctorModel.FromJson(Map<String, dynamic> json) {
    email = json['email'];
    user_name = json['user_name'];
    password = json['password'];
    phone = json['phone'];

    name = json['name'];
  }
  Map<String, dynamic> ToMap() {
    return {
      'email': email,
      'name': name,
      'password': password,
     "phone":phone,
      'user_name': user_name,
    };
  }
}
