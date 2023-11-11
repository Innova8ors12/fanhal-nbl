// class TeamModel {
//   bool? status;
//   List<DataT>? DataT;

//   TeamModel({this.status, this.DataT});

//   TeamModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['DataT'] != null) {
//       DataT = <DataT>[];
//       json['DataT'].forEach((v) {
//         DataT!.add(new DataT.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> DataT = new Map<String, dynamic>();
//     DataT['status'] = this.status;
//     if (this.DataT != null) {
//       DataT['DataT'] = this.DataT!.map((v) => v.toJson()).toList();
//     }
//     return DataT;
//   }
// }

// class DataT {
//   int? id;
//   String? leagueId;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   List<Teams>? teams;

//   DataT(
//       {this.id,
//       this.leagueId,
//       this.name,
//       this.createdAt,
//       this.updatedAt,
//       this.teams});

//   DataT.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     leagueId = json['league_id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['teams'] != null) {
//       teams = <Teams>[];
//       json['teams'].forEach((v) {
//         teams!.add(new Teams.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> DataT = new Map<String, dynamic>();
//     DataT['id'] = this.id;
//     DataT['league_id'] = this.leagueId;
//     DataT['name'] = this.name;
//     DataT['created_at'] = this.createdAt;
//     DataT['updated_at'] = this.updatedAt;
//     if (this.teams != null) {
//       DataT['teams'] = this.teams!.map((v) => v.toJson()).toList();
//     }
//     return DataT;
//   }
// }

// class Teams {
//   int? id;
//   String? img;
//   String? name;
//   String? categoryId;
//   String? leagueId;
//   String? themeId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;

//   Teams(
//       {this.id,
//       this.img,
//       this.name,
//       this.categoryId,
//       this.leagueId,
//       this.themeId,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Teams.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     img = json['img'];
//     name = json['name'];
//     categoryId = json['category_id'];
//     leagueId = json['league_id'];
//     themeId = json['theme_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> DataT = new Map<String, dynamic>();
//     DataT['id'] = this.id;
//     DataT['img'] = this.img;
//     DataT['name'] = this.name;
//     DataT['category_id'] = this.categoryId;
//     DataT['league_id'] = this.leagueId;
//     DataT['theme_id'] = this.themeId;
//     DataT['status'] = this.status;
//     DataT['created_at'] = this.createdAt;
//     DataT['updated_at'] = this.updatedAt;
//     return DataT;
//   }
// }
