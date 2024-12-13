class ClinicModel {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? about;
  int? provinceId;
  String? province;
  String? createdAt;
  String? updatedAt;

  ClinicModel(
      {this.id,
        this.name,
        this.phone,
        this.address,
        this.about,
        this.provinceId,
        this.province,
        this.createdAt,
        this.updatedAt});

  ClinicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    about = json['about'];
    provinceId = json['province_id'];
    province = json['province'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['about'] = this.about;
    data['province_id'] = this.provinceId;
    data['province'] = this.province;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}