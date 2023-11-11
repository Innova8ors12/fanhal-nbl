class TribeModel {
  int? id;
  int? userId;
  String? img;
  String? cardImg;
  String? username;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? dob;
  String? gender;
  String? nationality;
  String? city;
  String? leagueName;
  int? teamId;
  String? type;
  String? token;
  String? otp;
  String? userType;
  String? createdAt;
  String? updatedAt;

  TribeModel(
      {this.id,
      this.userId,
      this.img,
      this.cardImg,
      this.username,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.dob,
      this.gender,
      this.nationality,
      this.city,
      this.leagueName,
      this.teamId,
      this.type,
      this.token,
      this.otp,
      this.userType,
      this.createdAt,
      this.updatedAt});

  TribeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    img = json['img'];
    cardImg = json['card_img'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    dob = json['dob'];
    gender = json['gender'];
    nationality = json['nationality'];
    city = json['city'];
    leagueName = json['league_name'];
    teamId = json['team_id'];
    type = json['type'];
    token = json['token'];
    otp = json['otp'];
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['img'] = this.img;
    data['card_img'] = this.cardImg;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['city'] = this.city;
    data['league_name'] = this.leagueName;
    data['team_id'] = this.teamId;
    data['type'] = this.type;
    data['token'] = this.token;
    data['otp'] = this.otp;
    data['user_type'] = this.userType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}