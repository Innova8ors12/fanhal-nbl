import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/get_heros.dart';
import 'package:fan_hall/models/get_nick.dart';
import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';
import '3_certificate_type.dart';

class SelectHeroScreen extends StatefulWidget {
  final String Htype;
  const SelectHeroScreen({Key? key ,required this.Htype}  ) : super(key: key);

  @override
  State<SelectHeroScreen> createState() => _SelectHeroScreenState();
}

class _SelectHeroScreenState extends State<SelectHeroScreen> {
   bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
 getHeross() async {
  setLoading(true);
    var res = await ApiModel().getHeros(widget.Htype);
    HerosName?_herosName;
    // print(res);
    herosNameTeams.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _herosName = HerosName.fromJson(item);
         
        herosNameTeams.add(_herosName);
//  herosNameIdTeams.add(_herosName.id!.toString());

      }
      setLoading(false);
      print(nationalities1);
      // nationalId = leagueModel!.data![1]!.id.toString();
      setState(() {});
    }
  }
 void initState() {
   
 getHeross();
    // TODO: implement initState
    super.initState();
  }
  // var nickName;
  List<HerosName> herosNameTeams = [];
 

  List<Widget> normalList = [];

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
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: VariableText(
                      text: "Current Season",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.016,
                      fontFamily: fontSemiBold,
                      max_lines: 1,
                      textAlign: TextAlign.center
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.02),
            isLoading==true?Container(
                    height:size.height*0.05,
                    
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ):  Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
                child: Scrollbar(
                  thickness: 5.0,
                  child: ListView.separated(
                    itemCount:herosNameTeams.length,
                    separatorBuilder: (_, index){
                      return Divider(color: primaryColorB,height: size.height * 0.05, thickness: 1);
                    },
                    itemBuilder: (_, index){
                      return InkWell(
                        onTap: (){
                        setState(() {
                            selectedHero=herosNameTeams[index].id.toString();
                        });
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(widget: CertificateTypeScreen(CertificateId:selectedHero.toString(),))
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: index == 19 ? size.height * 0.015 : 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              VariableText(
                                text: herosNameTeams[index].name.toString(),
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.016,
                                fontFamily: fontMedium,
                                max_lines: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: size.width * 0.05),
                                child: VariableText(
                                  text:herosNameTeams[index].jerseyNo .toString(),
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
