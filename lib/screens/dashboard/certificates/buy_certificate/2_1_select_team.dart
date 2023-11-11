import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/halloffame.dart';
import 'package:fan_hall/models/seasons.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/constants.dart';
import '3_certificate_type.dart';

class SelectTeamScreen extends StatefulWidget {
  final String? id;
  bool isfame;
   SelectTeamScreen({Key? key, required this.id ,this.isfame=false}) : super(key: key);

  @override
  State<SelectTeamScreen> createState() => _SelectTeamScreenState();
}

class _SelectTeamScreenState extends State<SelectTeamScreen> {
  String? selectedTeam;
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  List<String> years=[];
 
  getteamSeasons() async {
    setLoading(true);
    var res = await ApiModel().getSeasons(widget.id.toString());

    Seasons? _season;
    // print(res);
    TeamSeasons.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _season = Seasons.fromJson(item);

        TeamSeasons.add(_season);
//  herosNameIdTeams.add(_herosName.id!.toString());
      }
      setLoading(false);
      print(nationalities1);
      // nationalId = leagueModel!.data![1]!.id.toString();
      setState(() {});
    }
  }

  gethalloffameSeasons() async {
    setLoading(true);
    var res = await ApiModel().gethalloffame();

    Halloffame? _season;
    // print(res);
    halloffame.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _season = Halloffame.fromJson(item);

        halloffame.add(_season);
        years.add(_season.Class!);
      }
      setLoading(false);

      setState(() {});
    }
  }
   gethalloffameSeasonsbyyear(String year) async {
    setLoading(true);
    var res = await ApiModel().gethalloffamebyyears(year);

    Halloffame? _season;
    // print(res);
    halloffame.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _season = Halloffame.fromJson(item);

        halloffame.add(_season);
      }
      setLoading(false);

      setState(() {});
    }
  }

  void initState() {
     widget.isfame?gethalloffameSeasons(): getteamSeasons();
    // TODO: implement initState
    super.initState();
  }

  // var nickName;
  List<Seasons> TeamSeasons = [];
  List<Halloffame> halloffame = [];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),

            ///appbar
            MenuAppbar(),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.20),
              child: Container(
                  height: size.height * 0.06,
                  child: InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: primaryColorW,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(200),
                            borderSide:
                                BorderSide(color: primaryColorW, width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(200),
                            borderSide:
                                BorderSide(color: primaryColorW, width: 2.0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(200),
                            borderSide:
                                BorderSide(color: primaryColorW, width: 2.0)),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset(
                                    'assets/icons/ic_dropdown.png',
                                    color: textColor1,
                                    scale: 2),
                              ),
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: VariableText(
                                  text: "Season",
                                  fontsize: size.height * 0.017,
                                  fontcolor: textColor1,
                                  fontFamily: fontMedium,
                                ),
                              ),
                              value: selectedTeam,
                              dropdownColor: primaryColorW,
                              isExpanded: true,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (String? value) {
                                setState(() {
                                  selectedTeam = value;
   
                                
                                });

                                gethalloffameSeasonsbyyear(selectedTeam!);
                              },
                              style: TextStyle(
                                  fontSize: size.height * 0.017,
                                  color: textColor1),
                              items: Constants.teams
                                  .map<DropdownMenuItem<String>>((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: VariableText(
                                      text: item,
                                      fontsize: size.height * 0.017,
                                      fontcolor: textColor1,
                                      fontFamily: fontMedium,
                                    ),
                                  ),
                                );
                              }).toList())))),
            ),
            SizedBox(height: size.height * 0.06),
            //Divider(color: primaryColorB,height: size.height * 0.05, thickness: 1),
            isLoading == true
                ? Container(
                    height: size.height * 0.05,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * horizontalPadding),
                      child: Scrollbar(
                        thickness: 5.0,
                        child: ListView.separated(
                          itemCount:widget.isfame?halloffame.length: TeamSeasons.length,
                          separatorBuilder: (_, index) {
                            return Divider(
                                color: primaryColorB,
                                height: size.height * 0.05,
                                thickness: 1);
                          },
                          itemBuilder: (_, index) {
                            return InkWell(
                              onTap: () {
                                SeasonYear =widget.isfame?halloffame[index].Class: TeamSeasons[index].year;
                                selectedmomentId = null;
                                selectedHero = null;
                                Navigator.push(
                                    context,
                                    SwipeLeftAnimationRoute(
                                        widget: CertificateTypeScreen(
                                      CertificateId: widget.id.toString(),
                                      seasonid:
                                         widget.isfame?halloffame[index].id.toString(): TeamSeasons[index].id.toString(),

                                       isfame: widget.isfame,

                                    )));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: index == 19
                                        ? size.height * 0.015
                                        : 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    VariableText(
                                      text: widget.isfame?halloffame[index].name:TeamSeasons[index].team!.name,
                                      fontcolor: primaryColorW,
                                      fontsize: size.height * 0.016,
                                      fontFamily: fontMedium,
                                      max_lines: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.05),
                                      child: VariableText(
                                        text:  widget.isfame?halloffame[index].Class:TeamSeasons[index].year,
                                        fontcolor: primaryColorW,
                                        fontsize: size.height * 0.016,
                                        fontFamily: fontMedium,
                                        max_lines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
