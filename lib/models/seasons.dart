class Seasons {
  int? id;
  int? teamId;
  String? year;
  String? createdAt;
  String? updatedAt;
  Team? team;

  Seasons(
      {this.id,
      this.teamId,
      this.year,
      this.createdAt,
      this.updatedAt,
      this.team});

  Seasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_id'] = this.teamId;
    data['year'] = this.year;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    return data;
  }
}

class Team {
  int? id;
  String? img;
  String? name;
  String? nickName;
  String? categoryId;
  String? leagueId;
  String? themeId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Team(
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

  Team.fromJson(Map<String, dynamic> json) {
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