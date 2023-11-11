class HerosName {
  int? id;
  int? teamId;
  String? jerseyNo;
  String? name;
  String? createdAt;
  String? updatedAt;

  HerosName(
      {this.id,
      this.teamId,
      this.jerseyNo,
      this.name,
      this.createdAt,
      this.updatedAt});

  HerosName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    jerseyNo = json['jersey_no'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_id'] = this.teamId;
    data['jersey_no'] = this.jerseyNo;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}