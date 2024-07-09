class UserModel {
  int? id;
  String? name;
  String? phone;

  UserModel({this.id, this.name, this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return{
      'id' : this.id,
      'name' : this.name,
      'phone' : this.phone,
    };
  }
}