class ScoreModel {
  int? id;
  String? year;
  String? week;
  String? matchTime;
  int? addScore;
  String? team1;
  String? team1Score;
  String? teamLogo1;
  String? team2;
  String? team2Score;
  String? teamLogo2;
  String? createdAt;
  String? updatedAt;

  ScoreModel(
      {this.id,
      this.year,
      this.week,
      this.matchTime,
      this.addScore,
      this.team1,
      this.team1Score,
      this.teamLogo1,
      this.team2,
      this.team2Score,
      this.teamLogo2,
      this.createdAt,
      this.updatedAt});

  ScoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    week = json['week'];
    matchTime = json['match_time'];
    addScore = json['add_score'];
    team1 = json['team1'];
    team1Score = json['team1_score'];
    teamLogo1 = json['team_logo1'];
    team2 = json['team2'];
    team2Score = json['team2_score'];
    teamLogo2 = json['team_logo2'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['week'] = this.week;
    data['match_time'] = this.matchTime;
    data['add_score'] = this.addScore;
    data['team1'] = this.team1;
    data['team1_score'] = this.team1Score;
    data['team_logo1'] = this.teamLogo1;
    data['team2'] = this.team2;
    data['team2_score'] = this.team2Score;
    data['team_logo2'] = this.teamLogo2;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}