class GetAwesome {
  int? id;
  String? name;
  String? year;
  String? createdAt;
  String? updatedAt;

  GetAwesome({this.id, this.name, this.year, this.createdAt, this.updatedAt});

  GetAwesome.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}