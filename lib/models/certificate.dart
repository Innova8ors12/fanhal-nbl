class Certificate {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
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
  String? fanmatchId;
  String? serialNo;
  Null? nflCertificateId;
  String? certImg;
  Null? backgroundColor;
  String? textColor;
  String? serialColor;
  String? backgroundImg;
  String? backgroundVideo;
  Null? plateImg;
  Null? backgroundImgDigital;
  String? icon1;
  String? icon2;
  Null? icon3;
  int? leagueId;
  int? teamId;
  Null? seasonId;
  Null? heroId;
  Null? momentsId;
  String? fanMatchTitle;
  int? isFanMatch;
  String? fanMatch;
  int? noOfDesign;
  String? noOfDesignTotal;
  Null? hallOfFameId;
  String? type;
  String? price;
  String? qrCode;
  String? nflType;
  int? isAvailable;
  String? fanmatchType;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.fanmatchId,
      this.serialNo,
      this.nflCertificateId,
      this.certImg,
      this.backgroundColor,
      this.textColor,
      this.serialColor,
      this.backgroundImg,
      this.backgroundVideo,
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
      this.fanMatchTitle,
      this.isFanMatch,
      this.fanMatch,
      this.noOfDesign,
      this.noOfDesignTotal,
      this.hallOfFameId,
      this.type,
      this.price,
      this.qrCode,
      this.nflType,
      this.isAvailable,
      this.fanmatchType,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fanmatchId = json['fanmatch_id'];
    serialNo = json['serial_no'];
    nflCertificateId = json['nfl_certificate_id'];
    certImg = json['cert_img'];
    backgroundColor = json['background_color'];
    textColor = json['text_color'];
    serialColor = json['serial_color'];
    backgroundImg = json['background_img'];
    backgroundVideo = json['background_video'];
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
    fanMatchTitle = json['fan_match_title'];
    isFanMatch = json['is_fan_match'];
    fanMatch = json['fan_match'];
    noOfDesign = json['no_of_design'];
    noOfDesignTotal = json['no_of_design_total'];
    hallOfFameId = json['hall_of_fame_id'];
    type = json['type'];
    price = json['price'];
    qrCode = json['qr_code'];
    nflType = json['nfl_type'];
    isAvailable = json['is_available'];
    fanmatchType = json['fanmatch_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fanmatch_id'] = this.fanmatchId;
    data['serial_no'] = this.serialNo;
    data['nfl_certificate_id'] = this.nflCertificateId;
    data['cert_img'] = this.certImg;
    data['background_color'] = this.backgroundColor;
    data['text_color'] = this.textColor;
    data['serial_color'] = this.serialColor;
    data['background_img'] = this.backgroundImg;
    data['background_video'] = this.backgroundVideo;
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
    data['fan_match_title'] = this.fanMatchTitle;
    data['is_fan_match'] = this.isFanMatch;
    data['fan_match'] = this.fanMatch;
    data['no_of_design'] = this.noOfDesign;
    data['no_of_design_total'] = this.noOfDesignTotal;
    data['hall_of_fame_id'] = this.hallOfFameId;
    data['type'] = this.type;
    data['price'] = this.price;
    data['qr_code'] = this.qrCode;
    data['nfl_type'] = this.nflType;
    data['is_available'] = this.isAvailable;
    data['fanmatch_type'] = this.fanmatchType;
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