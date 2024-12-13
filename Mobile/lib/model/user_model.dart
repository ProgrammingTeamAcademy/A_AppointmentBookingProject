class UserModel {
  int? id;
  String? name;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? provinceName;
  int? provinceID;

  UserModel({this.id, this.name, this.phone, this.createdAt, this.updatedAt, this.provinceName,this.provinceID});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provinceName = json['province'];
    provinceID = json['province_id'];
  }

  Map<String, dynamic> toJson() {
    return{
      'id' : this.id,
      'name' : this.name,
      'phone' : this.phone,
      'created_at' : this.createdAt,
      'updated_at' : this.updatedAt,
      'province' : this.provinceName,
    };
  }
}