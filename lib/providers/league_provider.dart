import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/config.dart';
import 'package:fan_hall/models/teams_model1.dart';

import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class LeagueProvider extends ChangeNotifier {
  TeamsModel teams = TeamsModel();

  setUser(TeamsModel teamsDetails) {
    teams = teamsDetails;
    notifyListeners();
  }

  List<TeamsModel> teams1 = [];
  List<Teams> allTeamsList = [];

  List<Teams> All = [];
  List<Teams> AFC_East = [];

  List<Teams> AFC_West = [];
  List<Teams> AFC_North = [];

  List<Teams> AFC_South = [];
  setLeagueTeams(List<TeamsModel> Allteams) {
    teams1.clear();
    teams1.addAll(Allteams);
    allTeamsList.clear();

    for (var item in teams1) {
      allTeams(item.teams!);

      if (item.name?.toUpperCase().toString() == "AFC EAST" ||
          item.name?.toUpperCase().toString() == "NFC EAST") {
        afcEast(item.teams!);
      }
      if (item.name?.toUpperCase().toString() == "AFC NORTH" ||
          item.name?.toUpperCase().toString() == "NFC NORTH") {
        afcNorth(item.teams!);
      }
      if (item.name?.toUpperCase().toString() == "AFC WEST" ||
          item.name?.toUpperCase().toString() == "NFC WEST") {
        afcWest(item.teams!);
      }
      if (item.name?.toUpperCase().toString() == "AFC SOUTH" ||
          item.name?.toUpperCase().toString() == "NFC SOUTH") {
        afcSouth(item.teams!);
      }
    }
    notifyListeners();
  }

  afcNorth(List<Teams> events) {
    AFC_North.clear();
    AFC_North.addAll(events);
    notifyListeners();
  }

  afcSouth(List<Teams> events) {
    AFC_South.clear();
    AFC_South.addAll(events);
    notifyListeners();
  }

  afcEast(List<Teams> events) {
    AFC_East.clear();
    AFC_East.addAll(events);
    notifyListeners();
  }

  afcWest(List<Teams> events) {
    AFC_West.clear();
    AFC_West.addAll(events);
    notifyListeners();
  }

  allTeams(List<Teams> eventTeam) {
    // allTeamsList.clear();
    for (var element in eventTeam) {
      allTeamsList.add(element);
    }
    notifyListeners();
  }

  southTeamSelect(int index) {
    for (var element in AFC_South) {
      element.isSelected = false;
    }
    AFC_South[index].isSelected = true;

    notifyListeners();
  }

  eastTeamSelect(int index) {
    for (var element in AFC_East) {
      element.isSelected = false;
    }
    AFC_East[index].isSelected = true;

    notifyListeners();
  }

  westTeamSelect(int index) {
    for (var element in AFC_West) {
      element.isSelected = false;
    }
    AFC_West[index].isSelected = true;

    notifyListeners();
  }

  northTeamSelect(int index) {
    for (var element in AFC_North) {
      element.isSelected = false;
    }
    AFC_North[index].isSelected = true;

    notifyListeners();
  }

  allTeamSelect(int index) {
    for (var element in allTeamsList) {
      element.isSelected = false;
    }
    allTeamsList[index].isSelected = true;

    notifyListeners();
  }
//  League_Model post = League_Model();
//   bool loading = false;

//   getPostData(context) async {
//     loading = true;
//     post = await getAll();
//     loading = false;

//     notifyListeners();
//   }

  // final _service = ApiModel();
  // bool isLoading = false;
  // List<League_Model> _todos = [];
  // List<League_Model> get todos => _todos;

  // Future<void> getAllTodos() async {
  //   isLoading = true;
  //   notifyListeners();

  //   final response = await _service.getAll();

  //   _todos = response;
  //   isLoading = false;
  //   notifyListeners();
  // }

  // League_Model responseData = League_Model();

  // bool isLoading = false;

  // Future<dynamic> getMyData() async {
  //   isLoading = true;
  //   responseData = await getAll();
  //   isLoading = false;
  //   notifyListeners();
  // }

  // Future<League_Model> getAll() async {
  //   var url = CONFIG.domain + CONFIG.getleague;

  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     print(response);
  //     if (response.statusCode == 200) {
  //       final item = json.decode(response.body);
  //       responseData = League_Model.fromJson(item);
  //       notifyListeners();
  //       print(response.statusCode);
  //     } else {
  //       print("else");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   return responseData;
  // }
}
