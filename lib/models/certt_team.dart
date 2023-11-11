class CertTeams {
  int? id;
  String? img;
  String? name;
  String? nickName;
  int? categoryId;
  int? leagueId;
  int? themeId;
  int? status;
  String? createdAt;
  String? updatedAt;

  CertTeams(
      {this.id,
      this.img,
      this.name,
      this.nickName,
      this.categoryId,
      this.leagueId,
      this.themeId,
      this.status,
      this.createdAt,
      this.updatedAt});

  CertTeams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    nickName = json['nick_name'];
    categoryId = json['category_id'];
    leagueId = json['league_id'];
    themeId = json['theme_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['nick_name'] = this.nickName;
    data['category_id'] = this.categoryId;
    data['league_id'] = this.leagueId;
    data['theme_id'] = this.themeId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}