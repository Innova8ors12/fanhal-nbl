class Theme1Model {
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

  Theme1Model(
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

  Theme1Model.fromJson(Map<String, dynamic> json) {
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