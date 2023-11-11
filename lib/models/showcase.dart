// class ShowCase {
//    int? currentPage;
//   List<Data1>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Links>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;

//   ShowCase(
//       {this.currentPage,
//       this.data,
//       this.firstPageUrl,
//       this.from,
//       this.lastPage,
//       this.lastPageUrl,
//       this.links,
//       this.nextPageUrl,
//       this.path,
//       this.perPage,
//       this.prevPageUrl,
//       this.to,
//       this.total});

//   ShowCase.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data1>[];
//       json['data'].forEach((v) {
//         data!.add(new Data1.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(new Links.fromJson(v));
//       });
//     }
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     if (this.links != null) {
//       data['links'] = this.links!.map((v) => v.toJson()).toList();
//     }
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }

// class Data1 {
//   int? id;
//   String? serialNo;
//   int? userId;
//   int? certificateId;
//   String? img;
//   String? pdf;
//   String? type;
//   String? status;
//   String? chargeId;
//   String? name;
//   String? address;
//   String? phone;
//   String? qty;
//   String? nflCertificateId;
//   String? qrCode;
//   String? createdAt;
//   String? updatedAt;
//   User? user;
//   Certificate? certificate;

//   Data1(
//       {this.id,
//       this.serialNo,
//       this.userId,
//       this.certificateId,
//       this.img,
//       this.pdf,
//       this.type,
//       this.status,
//       this.chargeId,
//       this.name,
//       this.address,
//       this.phone,
//       this.qty,
//       this.nflCertificateId,
//       this.qrCode,
//       this.createdAt,
//       this.updatedAt,
//       this.user,
//       this.certificate});

//   Data1.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serialNo = json['serial_no'];
//     userId = json['user_id'];
//     certificateId = json['certificate_id'];
//     img = json['img'];
//     pdf = json['pdf'];
//     type = json['type'];
//     status = json['status'];
//     chargeId = json['charge_id'];
//     name = json['name'];
//     address = json['address'];
//     phone = json['phone'];
//     qty = json['qty'];
//     nflCertificateId = json['nfl_certificate_id'];
//     qrCode = json['qr_code'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     certificate = json['certificate'] != null
//         ? new Certificate.fromJson(json['certificate'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['serial_no'] = this.serialNo;
//     data['user_id'] = this.userId;
//     data['certificate_id'] = this.certificateId;
//     data['img'] = this.img;
//     data['pdf'] = this.pdf;
//     data['type'] = this.type;
//     data['status'] = this.status;
//     data['charge_id'] = this.chargeId;
//     data['name'] = this.name;
//     data['address'] = this.address;
//     data['phone'] = this.phone;
//     data['qty'] = this.qty;
//     data['nfl_certificate_id'] = this.nflCertificateId;
//     data['qr_code'] = this.qrCode;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     if (this.certificate != null) {
//       data['certificate'] = this.certificate!.toJson();
//     }
//     return data;
//   }
// }

// class User {
//   int? id;
//   String? username;

//   User({this.id, this.username});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     return data;
//   }
// }

// class Certificate {
//   int? id;
//   String? serialNo;
//   String? nflCertificateId;
//   String? certImg;
//   String? backgroundColor;
//   String? textColor;
//   String? backgroundImg;
//   String? plateImg;
//   String? backgroundImgDigital;
//   String? icon1;
//   String? icon2;
//   String? icon3;
//   int? leagueId;
//   int? teamId;
//   String? seasonId;
//   int? heroId;
//   int? momentsId;
//   String? hallOfFameId;
//   String? type;
//   String? price;
//   String? qrCode;
//   String? nflType;
//   String? createdAt;
//   String? updatedAt;
//   Team? team;

//   Certificate(
//       {this.id,
//       this.serialNo,
//       this.nflCertificateId,
//       this.certImg,
//       this.backgroundColor,
//       this.textColor,
//       this.backgroundImg,
//       this.plateImg,
//       this.backgroundImgDigital,
//       this.icon1,
//       this.icon2,
//       this.icon3,
//       this.leagueId,
//       this.teamId,
//       this.seasonId,
//       this.heroId,
//       this.momentsId,
//       this.hallOfFameId,
//       this.type,
//       this.price,
//       this.qrCode,
//       this.nflType,
//       this.createdAt,
//       this.updatedAt,
//       this.team});

//   Certificate.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     serialNo = json['serial_no'];
//     nflCertificateId = json['nfl_certificate_id'];
//     certImg = json['cert_img'];
//     backgroundColor = json['background_color'];
//     textColor = json['text_color'];
//     backgroundImg = json['background_img'];
//     plateImg = json['plate_img'];
//     backgroundImgDigital = json['background_img_digital'];
//     icon1 = json['icon1'];
//     icon2 = json['icon2'];
//     icon3 = json['icon3'];
//     leagueId = json['league_id'];
//     teamId = json['team_id'];
//     seasonId = json['season_id'];
//     heroId = json['hero_id'];
//     momentsId = json['moments_id'];
//     hallOfFameId = json['hall_of_fame_id'];
//     type = json['type'];
//     price = json['price'];
//     qrCode = json['qr_code'];
//     nflType = json['nfl_type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     team = json['team'] != null ? new Team.fromJson(json['team']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['serial_no'] = this.serialNo;
//     data['nfl_certificate_id'] = this.nflCertificateId;
//     data['cert_img'] = this.certImg;
//     data['background_color'] = this.backgroundColor;
//     data['text_color'] = this.textColor;
//     data['background_img'] = this.backgroundImg;
//     data['plate_img'] = this.plateImg;
//     data['background_img_digital'] = this.backgroundImgDigital;
//     data['icon1'] = this.icon1;
//     data['icon2'] = this.icon2;
//     data['icon3'] = this.icon3;
//     data['league_id'] = this.leagueId;
//     data['team_id'] = this.teamId;
//     data['season_id'] = this.seasonId;
//     data['hero_id'] = this.heroId;
//     data['moments_id'] = this.momentsId;
//     data['hall_of_fame_id'] = this.hallOfFameId;
//     data['type'] = this.type;
//     data['price'] = this.price;
//     data['qr_code'] = this.qrCode;
//     data['nfl_type'] = this.nflType;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.team != null) {
//       data['team'] = this.team!.toJson();
//     }
//     return data;
//   }
// }

// class Team {
//   int? id;
//   String? img;
//   String? name;
//   String? code;
//   String? nickName;
//   int? categoryId;
//   int? leagueId;
//   int? themeId;
//   int? status;
//   String? createdAt;
//   String? updatedAt;

//   Team(
//       {this.id,
//       this.img,
//       this.name,
//       this.code,
//       this.nickName,
//       this.categoryId,
//       this.leagueId,
//       this.themeId,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   Team.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     img = json['img'];
//     name = json['name'];
//     code = json['code'];
//     nickName = json['nick_name'];
//     categoryId = json['category_id'];
//     leagueId = json['league_id'];
//     themeId = json['theme_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['img'] = this.img;
//     data['name'] = this.name;
//     data['code'] = this.code;
//     data['nick_name'] = this.nickName;
//     data['category_id'] = this.categoryId;
//     data['league_id'] = this.leagueId;
//     data['theme_id'] = this.themeId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class Links {
//   String? url;
//   String? label;
//   bool? active;

//   Links({this.url, this.label, this.active});

//   Links.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }
class ShowCase {
  int? id;
  String? serialNo;
  int? userId;
  int? certificateId;
  String? img;
  String? pdf;
  String? type;
  String? status;
  String? chargeId;
  String? name;
  String? address;
  String? phone;
  String? qty;
  String? nflCertificateId;
  String? qrCode;
  String? createdAt;
  String? updatedAt;
  User? user;
  Certificate? certificate;

  ShowCase(
      {this.id,
      this.serialNo,
      this.userId,
      this.certificateId,
      this.img,
      this.pdf,
      this.type,
      this.status,
      this.chargeId,
      this.name,
      this.address,
      this.phone,
      this.qty,
      this.nflCertificateId,
      this.qrCode,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.certificate});

  ShowCase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serial_no'];
    userId = json['user_id'];
    certificateId = json['certificate_id'];
    img = json['img'];
    pdf = json['pdf'];
    type = json['type'];
    status = json['status'];
    chargeId = json['charge_id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    qty = json['qty'];
    nflCertificateId = json['nfl_certificate_id'];
    qrCode = json['qr_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    certificate = json['certificate'] != null
        ? new Certificate.fromJson(json['certificate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_no'] = this.serialNo;
    data['user_id'] = this.userId;
    data['certificate_id'] = this.certificateId;
    data['img'] = this.img;
    data['pdf'] = this.pdf;
    data['type'] = this.type;
    data['status'] = this.status;
    data['charge_id'] = this.chargeId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['qty'] = this.qty;
    data['nfl_certificate_id'] = this.nflCertificateId;
    data['qr_code'] = this.qrCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.certificate != null) {
      data['certificate'] = this.certificate!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;

  User({this.id, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    return data;
  }
}

class Certificate {
  int? id;
  String? serialNo;
  String? nflCertificateId;
  String? certImg;
  String? backgroundColor;
  String? textColor;
  String? backgroundImg;
  String? plateImg;
  String? backgroundImgDigital;
  String? icon1;
  String? icon2;
  String? icon3;
  int? leagueId;
  int? teamId;
  int? seasonId;
  int? heroId;
  int? momentsId;
  int? hallOfFameId;
  String? type;
  String? price;
  String? qrCode;
  String? nflType;
  String? createdAt;
  String? updatedAt;
  Team? team;

  Certificate(
      {this.id,
      this.serialNo,
      this.nflCertificateId,
      this.certImg,
      this.backgroundColor,
      this.textColor,
      this.backgroundImg,
      this.plateImg,
      this.backgroundImgDigital,
      this.icon1,
      this.icon2,
      this.icon3,
      this.leagueId,
      this.teamId,
      this.seasonId,
      this.heroId,
      this.momentsId,
      this.hallOfFameId,
      this.type,
      this.price,
      this.qrCode,
      this.nflType,
      this.createdAt,
      this.updatedAt,
      this.team});

  Certificate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serial_no'];
    nflCertificateId = json['nfl_certificate_id'];
    certImg = json['cert_img'];
    backgroundColor = json['background_color'];
    textColor = json['text_color'];
    backgroundImg = json['background_img'];
    plateImg = json['plate_img'];
    backgroundImgDigital = json['background_img_digital'];
    icon1 = json['icon1'];
    icon2 = json['icon2'];
    icon3 = json['icon3'];
    leagueId = json['league_id'];
    teamId = json['team_id'];
    seasonId = json['season_id'];
    heroId = json['hero_id'];
    momentsId = json['moments_id'];
    hallOfFameId = json['hall_of_fame_id'];
    type = json['type'];
    price = json['price'];
    qrCode = json['qr_code'];
    nflType = json['nfl_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_no'] = this.serialNo;
    data['nfl_certificate_id'] = this.nflCertificateId;
    data['cert_img'] = this.certImg;
    data['background_color'] = this.backgroundColor;
    data['text_color'] = this.textColor;
    data['background_img'] = this.backgroundImg;
    data['plate_img'] = this.plateImg;
    data['background_img_digital'] = this.backgroundImgDigital;
    data['icon1'] = this.icon1;
    data['icon2'] = this.icon2;
    data['icon3'] = this.icon3;
    data['league_id'] = this.leagueId;
    data['team_id'] = this.teamId;
    data['season_id'] = this.seasonId;
    data['hero_id'] = this.heroId;
    data['moments_id'] = this.momentsId;
    data['hall_of_fame_id'] = this.hallOfFameId;
    data['type'] = this.type;
    data['price'] = this.price;
    data['qr_code'] = this.qrCode;
    data['nfl_type'] = this.nflType;
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
  String? code;
  String? nickName;
  int? categoryId;
  int? leagueId;
  int? themeId;
  int? status;
  String? createdAt;
  String? updatedAt;

  Team(
      {this.id,
      this.img,
      this.name,
      this.code,
      this.nickName,
      this.categoryId,
      this.leagueId,
      this.themeId,
      this.status,
      this.createdAt,
      this.updatedAt});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    code = json['code'];
    nickName = json['nick_name'];
    categoryId = json['category_id'];
    leagueId = json['league_id'];
    themeId = json['theme_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['code'] = this.code;
    data['nick_name'] = this.nickName;
    data['category_id'] = this.categoryId;
    data['league_id'] = this.leagueId;
    data['theme_id'] = this.themeId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
