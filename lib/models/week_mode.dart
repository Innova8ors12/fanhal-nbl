class WeekModel {
  int? id;
  String? week;
  String? createdAt;
  String? updatedAt;

  WeekModel({this.id, this.week, this.createdAt, this.updatedAt});

  WeekModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    week = json['week'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['week'] = this.week;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}