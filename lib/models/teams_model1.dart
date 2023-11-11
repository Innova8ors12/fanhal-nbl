class TeamsModel {
  int? id;
  int? leagueId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Teams>? teams;

  TeamsModel({
    this.id,
    this.leagueId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.teams,
  });

  TeamsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leagueId = json['league_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams!.add(new Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['league_id'] = this.leagueId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.teams != null) {
      data['teams'] = this.teams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  int? id;
  String? img;
  String? name;
  int? categoryId;
  int? leagueId;
  String? nickName;
  int? themeId;
  int? status;
  String? createdAt;
  String? updatedAt;
  bool? isSelected = false;

  Teams(
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
      this.isSelected});

  Teams.fromJson(Map<String, dynamic> json) {
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
    // theme = json['theme'] != null ? new Theme.fromJson(json['theme']) : null;
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
    // if (this.theme != null) {
    //   data['theme'] = this.theme!.toJson();
    // }
    data['isSelected'] = this.isSelected;

    return data;
  }
}

// class Theme {
//   int? id;
//   String? themeName;
//   String? leagueId;
//   String? primaryColor;
//   String? backgroundColor;
//   String? indicatorColor;
//   String? hintColor;
//   String? focusColor;
//   String? buttonColor;
//   String? status;
//   String? createdAt;
//   String? updatedAt;

//   Theme(
//       {this.id,
//       this.themeName,
//       this.leagueId,
//       this.primaryColor,
//       this.backgroundColor,
//       this.indicatorColor,
//       this.hintColor,
//       this.focusColor,
//       this.buttonColor,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Theme.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     themeName = json['theme_name'];
//     leagueId = json['league_id'];
//     primaryColor = json['primary_color'];
//     backgroundColor = json['background_color'];
//     indicatorColor = json['indicator_color'];
//     hintColor = json['hint_color'];
//     focusColor = json['focus_color'];
//     buttonColor = json['button_color'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['theme_name'] = this.themeName;
//     data['league_id'] = this.leagueId;
//     data['primary_color'] = this.primaryColor;
//     data['background_color'] = this.backgroundColor;
//     data['indicator_color'] = this.indicatorColor;
//     data['hint_color'] = this.hintColor;
//     data['focus_color'] = this.focusColor;
//     data['button_color'] = this.buttonColor;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }