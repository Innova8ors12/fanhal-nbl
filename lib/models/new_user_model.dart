import 'package:flutter/material.dart';

class NewUserModel with ChangeNotifier {
  int? id;
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
  String? type;
  String? token;
  String? createdAt;
  String? updatedAt;

  NewUserModel(
      {this.id,
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
      this.createdAt,
      this.updatedAt});

  NewUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
















// class UserModel with ChangeNotifier {
//   bool status;
//   Data data;

//   UserModel({required this.status, required this.data});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   int ?id;
//   String ?img;
//   String ?cardImg;
//   String ?username;
//   String ?name;
//   String ?email;
//   Null ?emailVerifiedAt;
//   String ?dob;
//   String ?gender;
//   String ?nationality;
//   String ?city;
//   String ?leagueName;
//   String ?teamId;
//   String ?type;
//   String ?token;
//   String ?createdAt;
//   String ?updatedAt;

//   Data(
//       {this.id,
//       this.img,
//       this.cardImg,
//       this.username,
//       this.name,
//       this.email,
//       this.emailVerifiedAt,
//       required this.dob,
//       this.gender,
//       this.nationality,
//       this.city,
//       this.leagueName,
//       this.teamId,
//       this.type,
//       this.token,
//       this.createdAt,
//       this.updatedAt});
      

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     img = json['img'];
//     cardImg = json['card_img'];
//     username = json['username'];
//     name = json['name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     dob = json['dob'];
//     gender = json['gender'];
//     nationality = json['nationality'];
//     city = json['city'];
//     leagueName = json['league_name'];
//     teamId = json['team_id'];
//     type = json['type'];
//     token = json['token'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['img'] = this.img;
//     data['card_img'] = this.cardImg;
//     data['username'] = this.username;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['dob'] = this.dob;
//     data['gender'] = this.gender;
//     data['nationality'] = this.nationality;
//     data['city'] = this.city;
//     data['league_name'] = this.leagueName;
//     data['team_id'] = this.teamId;
//     data['type'] = this.type;
//     data['token'] = this.token;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
   
//   }
  // Map<String, dynamic> toJsonSignUp() {
  //   Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['firstname'] = firstname;
  //   data['lastname'] = lastname;
  //   data['username'] = username;
  //   data['date_of_birth'] = dateOfBirth;
  //   data['country'] = country;
  //   data['phone'] = phone;
  //   data['email'] = email;
  //   data['password'] = password;
  //   data['fcm_token'] = fcmToken;
  //   return data;
  // }
  //   Map<String, dynamic> toJsonlogin() {
  //   Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['email'] = email;
  //   data['password'] = password;
  //   return data;
  // }

//   int? id;
//   String? img;
//   String? cardImg;
//   String? username;
//   String? name;
//   String? email;
//   Null emailVerifiedAt;
//   String? dob;
//   String? gender;
//   String? nationality;
//   String? city;
//   String? leagueName;
//   String? teamId;
//   String? type;
//   String? token;
//   String? createdAt;
//   String? updatedAt;
//   UserModel(
//       {this.id,
//       this.img,
//       this.cardImg,
//       this.username,
//       this.name,
//       this.email,
//       this.emailVerifiedAt,
//       this.dob,
//       this.gender,
//       this.nationality,
//       this.city,
//       this.leagueName,
//       this.teamId,
//       this.type,
//       this.token,
//       this.createdAt,
//       this.updatedAt});

//   userSignin(Map<String, dynamic> json) {
//     try {
//       id = json['id'];
//       img = json['img'];
//       cardImg = json['card_img'];
//       username = json['username'];
//       name = json['name'];
//       email = json['email'];
//       emailVerifiedAt = json['email_verified_at'];
//       dob = json['dob'];
//       gender = json['gender'];
//       nationality = json['nationality'];
//       city = json['city'];
//       leagueName = json['league_name'];
//       teamId = json['team_id'];
//       type = json['type'];
//       token = json['token'];
//       createdAt = json['created_at'];
//       updatedAt = json['updated_at'];

//       var isBlock = json['is_block'];
//     } on Exception catch (e) {
//       print(e);
//     }
//     notifyListeners();
//   }

//   UserModel.fromJson(Map<String, dynamic> json) {
//     try {
//       id = json['id'];
//       img = json['img'];
//       cardImg = json['card_img'];
//       username = json['username'];
//       name = json['name'];
//       email = json['email'];
//       emailVerifiedAt = json['email_verified_at'];
//       dob = json['dob'];
//       gender = json['gender'];
//       nationality = json['nationality'];
//       city = json['city'];
//       leagueName = json['league_name'];
//       teamId = json['team_id'];
//       type = json['type'];
//       token = json['token'];
//       createdAt = json['created_at'];
//       updatedAt = json['updated_at'];

//       var isBlock = json['is_block'];
//     } on Exception catch (e) {
//       print(e);
//     }
//   }
// //   // Map<String, dynamic> toJsonSignUp() {
// //   //   Map<String, dynamic> data = new Map<String, dynamic>();
// //   //   data['firstname'] = firstname;
// //   //   data['lastname'] = lastname;
// //   //   data['username'] = username;
// //   //   data['date_of_birth'] = dateOfBirth;
// //   //   data['country'] = country;
// //   //   data['phone'] = phone;
// //   //   data['email'] = email;
// //   //   data['password'] = password;
// //   //   data['fcm_token'] = fcmToken;
// //   //   return data;
// //   // }
// //   Map<String, dynamic> toJsonlogin() {
// //     Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['email'] = email;
// //     data['password'] = password;
// //     return data;
// //   }


