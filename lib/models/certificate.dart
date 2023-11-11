class Certificate {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Certificate(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Certificate.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
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
  String? type;
  String? price;
  String? qrCode;
  String? nflType;
  String? createdAt;
  String? updatedAt;

  Data(
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
      this.type,
      this.price,
      this.qrCode,
      this.nflType,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
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
    type = json['type'];
    price = json['price'];
    qrCode = json['qr_code'];
    nflType = json['nfl_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['type'] = this.type;
    data['price'] = this.price;
    data['qr_code'] = this.qrCode;
    data['nfl_type'] = this.nflType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}