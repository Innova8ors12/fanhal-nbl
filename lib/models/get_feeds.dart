class GetFeeds {
  int? id;
  int? userId;
  String? name;
  String? caption;
  String? createdAt;
  String? updatedAt;
  int? likecount;
  User? user;
  List<Comment>? comment;

  GetFeeds(
      {this.id,
      this.userId,
      this.name,
      this.caption,
      this.createdAt,
      this.updatedAt,
      this.likecount,
      this.user,
      this.comment});

  GetFeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    caption = json['caption'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likecount = json['likecount'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['caption'] = this.caption;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likecount'] = this.likecount;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? userId;
  String? img;
  String? cardImg;
  String? username;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? dob;
  String? gender;
  String? nationality;
  String? city;
  String? leagueName;
  int? teamId;
  Null? type;
  String? token;
  String? otp;
  String? userType;
  String? createdAt;
  String? updatedAt;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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

class Comment {
  int? id;
  int? userId;
  int? userPhotoId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  User? user;

  Comment(
      {this.id,
      this.userId,
      this.userPhotoId,
      this.comment,
      this.createdAt,
      this.updatedAt,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userPhotoId = json['user_photo_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_photo_id'] = this.userPhotoId;
    data['comment'] = this.comment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User1 {
  int? id;
  String? userId;
  String? img;
  String? cardImg;
  String? username;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? dob;
  String? gender;
  String? nationality;
  String? city;
  String? leagueName;
  int? teamId;
  Null? type;
  String? token;
  Null? otp;
  String? userType;
  String? createdAt;
  String? updatedAt;

  User1(
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

  User1.fromJson(Map<String, dynamic> json) {
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