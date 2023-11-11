class ChatModel {
  int? id;
  String? senderId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User2? user;
  Chatdetail? chatdetail;

  ChatModel(
      {this.id,
      this.senderId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.chatdetail});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User2.fromJson(json['user']) : null;
    chatdetail = json['chatdetail'] != null
        ? new Chatdetail.fromJson(json['chatdetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.chatdetail != null) {
      data['chatdetail'] = this.chatdetail!.toJson();
    }
    return data;
  }
}

class User2 {
  int? id;
  String? userId;
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

  User2(
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

  User2.fromJson(Map<String, dynamic> json) {
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

class Chatdetail {
  int? id;
  int? chatHistoryId;
  String? content;
  String? isSeen;
  String? createdAt;
  String? updatedAt;

  Chatdetail(
      {this.id,
      this.chatHistoryId,
      this.content,
      this.isSeen,
      this.createdAt,
      this.updatedAt});

  Chatdetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chatHistoryId = json['chat_history_id'];
    content = json['content'];
    isSeen = json['is_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_history_id'] = this.chatHistoryId;
    data['content'] = this.content;
    data['is_seen'] = this.isSeen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}