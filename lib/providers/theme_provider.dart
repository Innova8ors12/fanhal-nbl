import 'package:fan_hall/models/theme_model.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:fan_hall/widgets/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../services/local_preference.dart';

class ThemeProvider with ChangeNotifier {
  Theme1Model theme1model = Theme1Model();

  settheme(Theme1Model themeDetails) {
    theme1model = themeDetails;
    // primarycolor = HexColor(theme1model.primaryColor!.toString());
    notifyListeners();
  }

  // LocalPreference themePreference = LocalPreference();
  // String _themeCode = "null";
  // Theme1Model _themes = Theme1Model();

  // String get themeCode => _themeCode;
  // Theme1Model get themes => _themes;

  // set theme(Theme1Model themesDetail) {
  //   // _themeCode = code;
  //   _themes = themesDetail;
  //   // themePreference.setTheme();
  //   notifyListeners();
  // }
}
