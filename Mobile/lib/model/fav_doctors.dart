class FavDoctorsModel {
  int? id;
  int? userId;
  int? doctorId;
  String? createdAt;
  String? updatedAt;

  FavDoctorsModel(
      {this.id, this.userId, this.doctorId, this.createdAt, this.updatedAt});

  FavDoctorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['doctor_id'] = this.doctorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}