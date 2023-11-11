import 'dart:io';

import 'package:fan_hall/models/user_image_videos_model.dart';
import 'package:flutter/material.dart';

// class UserModel with ChangeNotifier {
//   int? id;
//   String? userId;
//   String? img;
//   String? cardImg;
//   String? username;
//   String? name;
//   String? email;
//   Null? emailVerifiedAt;
//   String? dob;
//   String? gender;
//   String? nationality;
//   String? city;
//   Null? phone;
//   String? leagueName;
//   String? teamId;
//   String? userType;
//   String? token;
//   Null? otp;
//   String? createdAt;
//   String? updatedAt;

//   UserModel(
//       {this.id,
//       this.userId,
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
//       this.phone,
//       this.leagueName,
//       this.teamId,
//       this.userType,
//       this.token,
//       this.otp,
//       this.createdAt,
//       this.updatedAt});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
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
//     phone = json['phone'];
//     leagueName = json['league_name'];
//     teamId = json['team_id'];
//     userType = json['user_type'];
//     token = json['token'];
//     otp = json['otp'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
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
//     data['phone'] = this.phone;
//     data['league_name'] = this.leagueName;
//     data['team_id'] = this.teamId;
//     data['user_type'] = this.userType;
//     data['token'] = this.token;
//     data['otp'] = this.otp;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
// class UserModel extends ChangeNotifier{
//   int id;
//   String? name;
//   String ?username;
//   String ?email;
//   String ?password;
//   String ?contactNumber;
//   String ?profilePicture;
//   String ?shortBio;
//   String ?dob;
//   String ?gender;
//   List<UserImage> userImages = [];
//   List<UserVideo> userVideos = [];
 
 
//   String? provider;
//   String? providerID;
//   String? providerToken;
//   String? accessToken;
//   String? lat;
//   String? long;
//   String? fcmToken;
//   bool showOrientation;
//   String createdAt;
 
//   bool onHoliday;
//   LikeCount likeLimit;
//   UserPlan userPlanDetails;
//   UserBooster userBooster;
//   bool isActive;

//   int likesCount;

//   UserModel(this.id, this.name, this.username, this.profilePicture, this.email,
//     this.contactNumber, this.lat, this.long, this.dob, this.gender, this.password,
//   this.provider, this.userImages, this.userVideos, this.providerID, this.providerToken,
//     this.accessToken, this.showOrientation, this.fcmToken, this.createdAt,
//     this.shortBio,  this.onHoliday, this.likeLimit, this.userPlanDetails,
//     this.userBooster, this.isActive);

//   userSignIn(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       username = json['username'];
//       email = json['email'];
//       contactNumber = json['phone'];
//       profilePicture = json['profile_img'];
//       shortBio = json['short_bio'];
//       dob = json['date_of_birth'];
//       gender = json['gender'];
     
//       provider = json['provider'];
//       providerID = json['provider_id'];
//       providerToken = json['provider_token'];
//       accessToken = json['access_token'];
//       createdAt = json['created_at'];
//       lat = json['latitude'];
//       long = json['longitude'];
//       fcmToken = json['fcm_token'];
//       showOrientation = int.parse(json['show_orientation'].toString()) == 0 ? false : true;
  
//       onHoliday = json['is_holiday'].toString() == "0" ? false : true;
//       isActive = json['is_active'].toString() == "0" ? false : true;
      
//       likeLimit = LikeCount.fromJson(json['likecount']);
//       userPlanDetails = UserPlan.fromJson(json['userplan']);
//       if(json['userbooster'] != null){
//         print(json['userbooster'].toString());
//         userBooster = UserBooster.fromJson(json['userbooster']);
//       }else{
//         userBooster = UserBooster.initialize();
//       }
    
//       userImages = [];
//       userVideos = [];
//       for(var item in json['userimages']){
//         userImages.add(UserImage.fromJson(item));
//       }
//       for(var item in json['uservideos']){
//         userVideos.add(UserVideo.fromJson(item));
//       }
    
//       likesCount = 0;
//       notifyListeners();
//     }catch(e, stack){
//       print("userSignIn: "+ stack.toString());
//     }
//   }

//   UserModel.fromJson(Map<String, dynamic> json){
//     try{
//     id = json['id'];
//     name = json['name'];
//     username = json['username'];
//     email = json['email'];
//     contactNumber = json['phone'];
//     profilePicture = json['profile_img'];
//     shortBio = json['short_bio'];
//     dob = json['date_of_birth'];
//     gender = json['gender'];
   
//     provider = json['provider'];
//     providerID = json['provider_id'];
//     providerToken = json['provider_token'];
//     accessToken = json['access_token'];
//     createdAt = json['created_at'];
//     lat = json['latitude'];
//     long = json['longitude'];
//     fcmToken = json['fcm_token'];
//     showOrientation = int.parse(json['show_orientation'].toString()) == 0 ? false : true;
   
//     onHoliday = json['is_holiday'].toString() == "0" ? false : true;
//     isActive = json['is_active'].toString() == "0" ? false : true;
   
//     //likeLimit = LikeCount.fromJson(json['likecount']);
//     //userPlanDetails = UserPlan.fromJson(json['userplan']);
   
//     userImages = [];
//     userVideos = [];
//     for(var item in json['userimages']){
//       userImages.add(UserImage.fromJson(item));
//     }
//     for(var item in json['uservideos']){
//       userVideos.add(UserVideo.fromJson(item));
//     }
   
//     }catch(e, stack){
//       print("UserModel.fromJson: "+ stack.toString());
//     }
//   }
//   UserModel.fromModel(UserModel userDetails){
//     id = userDetails.id;
//     name = userDetails.name;
//     username = userDetails.username;
//     email = userDetails.email;
//     password = userDetails.password;
//     contactNumber = userDetails.contactNumber;
//     profilePicture = userDetails.profilePicture;
//     dob = userDetails.dob;
//     gender = userDetails.gender;
   
//     userImages = userDetails.userImages;
//     userVideos = userDetails.userVideos;
   
//     provider = userDetails.provider;
//     providerID = userDetails.providerID;
//     providerToken = userDetails.providerToken;
//     lat = userDetails.lat;
//     long = userDetails.long;
//     fcmToken = userDetails.fcmToken;
//     showOrientation = userDetails.showOrientation;
   
//     onHoliday = userDetails.onHoliday;
//     isActive = userDetails.isActive;
//     likeLimit = userDetails.likeLimit;
//     userPlanDetails = userDetails.userPlanDetails;
//     userBooster = userDetails.userBooster;
//   }
//   UserModel.fromMatchedJson(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       profilePicture = json['profile_img'];
//     }catch(e, stack){
//       print("fromMatchedJson: "+ stack.toString());
//     }
//   }
//   UserModel.fromPartnerJson(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       username = json['username'];
//       email = json['email'];
//       contactNumber = json['phone'];
//       profilePicture = json['profile_img'];
//       shortBio = json['short_bio'];
//       dob = json['date_of_birth'];
//       gender = json['gender'];
//       provider = json['provider'];
//       providerID = json['provider_id'];
//       providerToken = json['provider_token'];
//       accessToken = json['access_token'];
//       createdAt = json['created_at'];
//       lat = json['latitude'];
//       long = json['longitude'];
//       fcmToken = json['fcm_token'];
//       showOrientation = int.parse(json['show_orientation'].toString()) == 0 ? false : true;
     
//       onHoliday = json['is_holiday'].toString() == "0" ? false : true;
//       isActive = json['is_active'].toString() == "0" ? false : true;
     
//       userImages = [];
//       userVideos = [];
//     }catch(e, stack){
//       print("UserModel.fromPartnerJson: "+ stack.toString());
//     }
//   }
//   UserModel.fromQuizJson(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       username = json['username'];
//       email = json['email'];
//       contactNumber = json['phone'];
//       profilePicture = json['profile_img'];
//       shortBio = json['short_bio'];
//       dob = json['date_of_birth'];
//       gender = json['gender'];
//       provider = json['provider'];
//       providerID = json['provider_id'];
//       providerToken = json['provider_token'];
//       accessToken = json['access_token'];
//       createdAt = json['created_at'];
//       lat = json['latitude'];
//       long = json['longitude'];
//       fcmToken = json['fcm_token'];
    
//       userImages = [];
//       userVideos = [];
//     }catch(e, stack){
//       print("UserModel.fromQuizJson: "+ stack.toString());
//     }
//   }
//   UserModel.fromChatJson(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       username = json['username'];
//       profilePicture = json['profile_img'];
//       fcmToken = json['fcm_token'];
//       onHoliday = json['is_holiday'].toString() == "0" ? false : true;
//     }catch(e, stack){
//       print("fromChatJson: "+ stack.toString());
//     }
//   }
//   UserModel.fromStoryJson(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       username = json['username'];
//       email = json['email'];
//       contactNumber = json['phone'];
//       profilePicture = json['profile_img'];
//       shortBio = json['short_bio'];
//       dob = json['date_of_birth'];
//       gender = json['gender'];
//       provider = json['provider'];
//       providerID = json['provider_id'];
//       providerToken = json['provider_token'];
//       accessToken = json['access_token'];
//       createdAt = json['created_at'];
//       lat = json['latitude'];
//       long = json['longitude'];
//       fcmToken = json['fcm_token'];
//       showOrientation = int.parse(json['show_orientation'].toString()) == 0 ? false : true;
   
//       userImages = [];
//       userVideos = [];
//     }catch(e, stack){
//       print("UserModel.fromStoryJson: "+ stack.toString());
//     }
//   }
//   UserModel.fromLikes(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       username = json['username'];
//       email = json['email'];
//       contactNumber = json['phone'];
//       profilePicture = json['profile_img'];
//       shortBio = json['short_bio'];
//       dob = json['date_of_birth'];
//       gender = json['gender'];
//       provider = json['provider'];
//       providerID = json['provider_id'];
//       providerToken = json['provider_token'];
//       accessToken = json['access_token'];
//       createdAt = json['created_at'];
//       lat = json['latitude'];
//       long = json['longitude'];
//       fcmToken = json['fcm_token'];
//       showOrientation = int.parse(json['show_orientation'].toString()) == 0 ? false : true;
//       onHoliday = json['is_holiday'].toString() == "0" ? false : true;
//       isActive = json['is_active'].toString() == "0" ? false : true;
    
//       userImages = [];
//       userVideos = [];
//       for(var item in json['userimages']){
//         userImages.add(UserImage.fromJson(item));
//       }
//       for(var item in json['uservideos']){
//         userVideos.add(UserVideo.fromJson(item));
//       }
//     }catch(e, stack){
//       print("UserModel.fromLikes: "+ stack.toString());
//     }
//   }
//   UserModel.fromRadar(Map<String, dynamic> json){
//     try{
//       id = json['id'];
//       name = json['name'];
//       username = json['username'];
//       email = json['email'];
//       contactNumber = json['phone'];
//       profilePicture = json['profile_img'];
//       shortBio = json['short_bio'];
//       dob = json['date_of_birth'];
//       gender = json['gender'];
    
//       provider = json['provider'];
//       providerID = json['provider_id'];
//       providerToken = json['provider_token'];
//       accessToken = json['access_token'];
//       createdAt = json['created_at'];
//       lat = json['latitude'];
//       long = json['longitude'];
//       fcmToken = json['fcm_token'];
//       showOrientation = int.parse(json['show_orientation'].toString()) == 0 ? false : true;
   
//       onHoliday = json['is_holiday'].toString() == "0" ? false : true;
//       isActive = json['is_active'].toString() == "0" ? false : true;
//          userImages = [];
//       userVideos = [];
//       for(var item in json['userimages']){
//         userImages.add(UserImage.fromJson(item));
//       }
//       for(var item in json['uservideos']){
//         userVideos.add(UserVideo.fromJson(item));
//       }
      
//     }catch(e, stack){
//       print("UserModel.fromRadar: "+ stack.toString());
//     }
//   }

//     userLogout(){
//     // try{
   
//     name = null;
//     username = null;
//     email = null;
//     contactNumber = null;
//     profilePicture = null;
//     shortBio = null;
//     dob = null;
//     gender = null;
   
//     userImages = [];
//     userVideos = [];
//     provider = null;
//     providerID = null;
//     providerToken = null;
//     lat = null;
//     long = null;
//     fcmToken = null;
   
   
//     likeLimit = null;
//     userPlanDetails = null;
//     userBooster = null;
//     accessToken = null;
   
   
//       notifyListeners();
//       //}catch(e){
//       //print("userSignIn: "+e.toString());
//     }

//   setNewUser(UserModel userDetails){
//     id = userDetails.id;
//     name = userDetails.name;
//     username = userDetails.username;
//     email = userDetails.email;
//     password = userDetails.password;
//     contactNumber = userDetails.contactNumber;
//     profilePicture = userDetails.profilePicture;
//     dob = userDetails.dob;
//     gender = userDetails.gender;
//     lat = userDetails.lat;
//     long = userDetails.long;
//     fcmToken = userDetails.fcmToken;
//     showOrientation = userDetails.showOrientation;
//     onHoliday = userDetails.onHoliday;
//     isActive = userDetails.isActive;
 
//     userImages = userDetails.userImages;
//     userVideos = userDetails.userVideos;
 
//     provider = userDetails.provider;
//     providerID = userDetails.providerID;
//     providerToken = userDetails.providerToken;
//     likeLimit = userDetails.likeLimit;
//     userPlanDetails = userDetails.userPlanDetails;
//     userBooster = userDetails.userBooster;
//     notifyListeners();
//   }

//   updateUser(UserModel userDetails){
//     name = userDetails.name;
//     shortBio = userDetails.shortBio;
//     email = userDetails.email;
//     notifyListeners();
//   }
//   updateUserProfile(String userImage){
//     profilePicture = userImage;
//     notifyListeners();
//   }
//   updateUserImage(var userImage){
//     userImages.add(UserImage.fromJson(userImage));
//     notifyListeners();
//   }
//   updateUserVideo(var userVideo){
//     userVideos.add(UserVideo.fromJson(userVideo));
//     notifyListeners();
//   }
//   deleteUserImage(int imgID){
//     userImages.removeWhere((element) => element.id == imgID);
//     notifyListeners();
//   }
//   deleteUserVideo(int videoID){
//     userVideos.removeWhere((element) => element.id == videoID);
//     notifyListeners();
//   }

 

//   // updateUserPlan(Plan planDetails, String updateDate){
//   //   userPlanDetails.planID = planDetails.id;
//   //   userPlanDetails.dateTime = updateDate;
//   //   notifyListeners();
//   // }

//   // updateUserBooster(Booster boosterDetails, String updateDate){
//   //   userBooster.boosterID = boosterDetails.id;
//   //   userBooster.dateTime = updateDate;
//   //   userBooster.weight = boosterDetails.weight;
//   //   notifyListeners();
//   // }

//   incrementLikeCount(){
//     likeLimit.totalLikes++;
//     notifyListeners();
//   }

//   resetLikeCount(){
//     likeLimit.totalLikes = 0;
//     notifyListeners();
//   }

//   setLikesCount(int count){
//     likesCount = count;
//     notifyListeners();
//   }

// }

// class LikeCount{
//   int totalLikes;
//   String startDate;
  
//   LikeCount.fromJson(Map<String, dynamic> json){
//     try{
//       totalLikes = int.parse(json['total_likes'].toString());
//       startDate = json['created_at'];
//     }catch(e, stack){
//       print("LikeCount.fromJson: " + stack.toString());
//     }
//   }
// }
// class UserPlan{
//   int planID;
//   String dateTime;

//   UserPlan.fromJson(Map<String, dynamic> json){
//     try{
//       planID = int.tryParse(json['subscription_plan_id'].toString());
//       dateTime = json['updated_at'];
//     }catch(e, stack){
//       print("UserPlan.fromJson: " + stack.toString());
//     }
//   }
// }
// class UserBooster{
//   int boosterID;
//   int weight;
//   String dateTime;

//   UserBooster.fromJson(Map<String, dynamic> json){
//     try{
//       if(json['booster_id'] != null){
//         boosterID = int.tryParse(json['booster_id'].toString());
//         weight = int.tryParse(json['booster']['weight'].toString());
//         dateTime = json['updated_at'];
//       }else{
//         boosterID = null;
//         weight = null;
//         dateTime = null;
//       }
//     }catch(e, stack){
//       print("UserBooster.fromJson: " + stack.toString());
//     }
//   }
//   UserBooster.initialize(){
//     boosterID = null;
//     weight = null;
//     dateTime = null;
//   }
// }



class UserModel with ChangeNotifier{
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
  String? longitude;
  String? latitude;
  String? qrCode;
  String? joiningDate;
  String? createdAt;
  String? updatedAt;
  String? qrcode;
  Team? team;
  List<Photos>? photos;
  List<Vclips>? vclips;

  UserModel(
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
      this.longitude,
      this.latitude,
      this.qrCode,
      this.joiningDate,
      this.createdAt,
      this.updatedAt,
      this.qrcode,
      this.team,
      this.photos,
      this.vclips});

  UserModel.fromJson(Map<String, dynamic> json) {
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
    longitude = json['longitude'];
    latitude = json['latitude'];
    qrCode = json['qr_code'];
    joiningDate = json['joining_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    qrcode = json['qrcode'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    if (json['vclips'] != null) {
      vclips = <Vclips>[];
      json['vclips'].forEach((v) {
        vclips!.add(new Vclips.fromJson(v));
      });
    }
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
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['qr_code'] = this.qrCode;
    data['joining_date'] = this.joiningDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['qrcode'] = this.qrcode;
    if (this.team != null) {
      data['team'] = this.team!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    if (this.vclips != null) {
      data['vclips'] = this.vclips!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
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
  Poster? poster;
  Category? category;

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
      this.updatedAt,
      this.poster,
      this.category});

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
    poster =
        json['poster'] != null ? new Poster.fromJson(json['poster']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
    if (this.poster != null) {
      data['poster'] = this.poster!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Poster {
  int? id;
  int? teamId;
  String? poster;

  Poster({this.id, this.teamId, this.poster});

  Poster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    poster = json['poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_id'] = this.teamId;
    data['poster'] = this.poster;
    return data;
  }
}

class Category {
  int? id;
  int? leagueId;
  String? name;
  String? createdAt;
  String? updatedAt;
  League? league;

  Category(
      {this.id,
      this.leagueId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.league});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leagueId = json['league_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    league =
        json['league'] != null ? new League.fromJson(json['league']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['league_id'] = this.leagueId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.league != null) {
      data['league'] = this.league!.toJson();
    }
    return data;
  }
}

class League {
  int? id;
  String? img;
  String? name;
  String? active;
  String? createdAt;
  String? updatedAt;

  League(
      {this.id,
      this.img,
      this.name,
      this.active,
      this.createdAt,
      this.updatedAt});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Photos {
  int? id;
  int? userId;
  String? name;
  String? caption;
  String? createdAt;
  String? updatedAt;

  Photos(
      {this.id,
      this.userId,
      this.name,
      this.caption,
      this.createdAt,
      this.updatedAt});

  Photos.fromJson(Map<String, dynamic> json) {
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

class Vclips {
  int? id;
  int? userId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Vclips({this.id, this.userId, this.name, this.createdAt, this.updatedAt});

  Vclips.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}