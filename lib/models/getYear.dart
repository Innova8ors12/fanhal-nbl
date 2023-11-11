class YearModel {
  int? id;
  String? year;
  String? createdAt;
  String? updatedAt;

  YearModel({this.id, this.year, this.createdAt, this.updatedAt});

  YearModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

