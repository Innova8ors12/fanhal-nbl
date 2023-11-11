class GetAllUser {
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
  String? createdAt;
  String? updatedAt;
  Team? team;

  GetAllUser(
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
      this.createdAt,
      this.updatedAt,
      this.team});

  GetAllUser.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
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
  int? categoryId;
  int? leagueId;
  int? themeId;
  int? status;
  String? createdAt;
  String? updatedAt;
  Theme1? theme;
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
      this.theme,
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
    theme = json['theme'] != null ? new Theme1.fromJson(json['theme']) : null;
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
    if (this.theme != null) {
      data['theme'] = this.theme!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Theme1 {
  int? id;
  String? themeName;
  int? leagueId;
  String? primaryColor;
  String? primaryTextColor;
  String? secondaryColor;
  String? secondaryTextColor;
  String? secondaryTextSelect;
  String? fanCardBtnBg;
  String? fanCardTextColor;
  String? navMenuBgColor;
  String? navMenuTextColor;
  String? navMenuTextSelect;
  String? shareBtnBg;
  String? shareBtnColor;
  String? backgroundColor;
  String? indicatorColor;
  String? hintColor;
  String? focusColor;
  String? buttonColor;
  String? textColor;
  int? status;
  String? createdAt;
  String? updatedAt;

  Theme1(
      {this.id,
      this.themeName,
      this.leagueId,
      this.primaryColor,
      this.primaryTextColor,
      this.secondaryColor,
      this.secondaryTextColor,
      this.secondaryTextSelect,
      this.fanCardBtnBg,
      this.fanCardTextColor,
      this.navMenuBgColor,
      this.navMenuTextColor,
      this.navMenuTextSelect,
      this.shareBtnBg,
      this.shareBtnColor,
      this.backgroundColor,
      this.indicatorColor,
      this.hintColor,
      this.focusColor,
      this.buttonColor,
      this.textColor,
      this.status,
      this.createdAt,
      this.updatedAt});

  Theme1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    themeName = json['theme_name'];
    leagueId = json['league_id'];
    primaryColor = json['primary_color'];
    primaryTextColor = json['primary_text_color'];
    secondaryColor = json['secondary_color'];
    secondaryTextColor = json['secondary_text_color'];
    secondaryTextSelect = json['secondary_text_select'];
    fanCardBtnBg = json['fan_card_btn_bg'];
    fanCardTextColor = json['fan_card_text_color'];
    navMenuBgColor = json['nav_menu_bg_color'];
    navMenuTextColor = json['nav_menu_text_color'];
    navMenuTextSelect = json['nav_menu_text_select'];
    shareBtnBg = json['share_btn_bg'];
    shareBtnColor = json['share_btn_color'];
    backgroundColor = json['background_color'];
    indicatorColor = json['indicator_color'];
    hintColor = json['hint_color'];
    focusColor = json['focus_color'];
    buttonColor = json['button_color'];
    textColor = json['text_color'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['theme_name'] = this.themeName;
    data['league_id'] = this.leagueId;
    data['primary_color'] = this.primaryColor;
    data['primary_text_color'] = this.primaryTextColor;
    data['secondary_color'] = this.secondaryColor;
    data['secondary_text_color'] = this.secondaryTextColor;
    data['secondary_text_select'] = this.secondaryTextSelect;
    data['fan_card_btn_bg'] = this.fanCardBtnBg;
    data['fan_card_text_color'] = this.fanCardTextColor;
    data['nav_menu_bg_color'] = this.navMenuBgColor;
    data['nav_menu_text_color'] = this.navMenuTextColor;
    data['nav_menu_text_select'] = this.navMenuTextSelect;
    data['share_btn_bg'] = this.shareBtnBg;
    data['share_btn_color'] = this.shareBtnColor;
    data['background_color'] = this.backgroundColor;
    data['indicator_color'] = this.indicatorColor;
    data['hint_color'] = this.hintColor;
    data['focus_color'] = this.focusColor;
    data['button_color'] = this.buttonColor;
    data['text_color'] = this.textColor;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  Null? active;
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