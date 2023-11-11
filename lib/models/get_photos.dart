class GetPhotos {
  int? id;
  int? userId;
  String? name;
  String? caption;
  String? createdAt;
  String? updatedAt;

  GetPhotos(
      {this.id,
      this.userId,
      this.name,
      this.caption,
      this.createdAt,
      this.updatedAt});

  GetPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    caption = json['caption'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['caption'] = this.caption;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}