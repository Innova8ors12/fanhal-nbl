import 'package:fan_hall/models/teams_model1.dart';
import 'package:flutter/cupertino.dart';

class TeamsProvider extends ChangeNotifier {
  TeamsModel teams = TeamsModel();

  setTeam(TeamsModel teamsDetails) {
    teams = teamsDetails;
    notifyListeners();
  }
}
