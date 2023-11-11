import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/get_awesome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/constants.dart';
import '../../../../widgets/style.dart';
import '3_certificate_type.dart';

class SelectMomentScreen extends StatefulWidget {
  const SelectMomentScreen({Key? key}) : super(key: key);

  @override
  State<SelectMomentScreen> createState() => _SelectMomentScreenState();
}

class _SelectMomentScreenState extends State<SelectMomentScreen> {
  String? selectedEvent;
  String? selectedYear;
  bool isLoading = false;
   List<GetAwesome> awesomeMomentsNames = [];
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
 getMoments() async {
  setLoading(true);
    var res = await ApiModel().getmom();
    GetAwesome?_awesomemomentName;
    // print(res);
   awesomeMomentsNames.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
       _awesomemomentName =GetAwesome.fromJson(item);
         
        awesomeMomentsNames.add(_awesomemomentName);
//  herosNameIdTeams.add(_herosName.id!.toString());

      }
      setLoading(false);
    
      setState(() {});
    }
  }
 void initState() {
   
 getMoments();
    // TODO: implement initState
    super.initState();
  }
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
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                children: [
                  // Expanded(
                  //   child: SizedBox(
                  //       height: size.height * 0.05,
                  //       child: InputDecorator(
                  //           decoration: InputDecoration(
                  //             filled: true,
                  //             fillColor: primaryColorW,
                  //             enabledBorder:OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(200),
                  //                 borderSide: BorderSide(color: primaryColorW, width: 2.0)
                  //             ),
                  //             focusedBorder: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(200),
                  //                 borderSide: BorderSide(color: primaryColorW, width: 2.0)),
                  //             border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(200),
                  //                 borderSide: BorderSide(color: primaryColorW, width: 2.0)),
                  //             contentPadding: EdgeInsets.all(10),
                  //           ),
                  //           child:  DropdownButtonHideUnderline(
                  //               child: DropdownButton<String>(
                  //                   icon: Padding(
                  //                     padding: const EdgeInsets.only(right: 10),
                  //                     child: Image.asset('assets/icons/ic_dropdown.png', color: textColor1, scale: 2),
                  //                   ),
                  //                   hint: Padding(
                  //                     padding: const EdgeInsets.only(left:8.0),
                  //                     child: VariableText(
                  //                       text: "Event",
                  //                       fontsize: size.height * 0.017,
                  //                       fontcolor: textColor1,
                  //                       fontFamily: fontMedium,
                  //                     ),
                  //                   ),
                  //                   value: selectedEvent,
                  //                   dropdownColor: primaryColorW,
                  //                   isExpanded: true,
                  //                   onTap: (){
                  //                     FocusScope.of(context).unfocus();
                  //                   },
                  //                   onChanged: (String? value){
                  //                     setState(() {
                  //                       selectedEvent = value;
                  //                     });
                  //                   },
                  //                   style: TextStyle(
                  //                       fontSize: size.height * 0.017,
                  //                       color: textColor1
                  //                   ),
                  //                   items:
                  //                   Constants.events.map<DropdownMenuItem<String>>((String item) {
                  //                     return DropdownMenuItem<String>(
                  //                       value: item,
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.only(left:8.0),
                  //                         child: VariableText(
                  //                           text: item,
                  //                           fontsize: size.height * 0.017,
                  //                           fontcolor: textColor1,
                  //                           fontFamily: fontMedium,
                  //                         ),
                  //                       ),
                  //                     );
                  //                   }).toList()
                  //               ))
                  //       )
                  //   ),
                  // ),
                  SizedBox(width: size.width * 0.06),
                  Expanded(
                    child: SizedBox(
                        height: size.height * 0.05,
                        child: InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: primaryColorW,
                              enabledBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(color: primaryColorW, width: 2.0)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(color: primaryColorW, width: 2.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200),
                                  borderSide: BorderSide(color: primaryColorW, width: 2.0)),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            child:  DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    icon: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image.asset('assets/icons/ic_dropdown.png', color: textColor1, scale: 2),
                                    ),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: VariableText(
                                        text: "Year",
                                        fontsize: size.height * 0.017,
                                        fontcolor: textColor1,
                                        fontFamily: fontMedium,
                                      ),
                                    ),
                                    value: selectedYear,
                                    dropdownColor: primaryColorW,
                                    isExpanded: true,
                                    onTap: (){
                                      FocusScope.of(context).unfocus();
                                    },
                                    onChanged: (String? value){
                                      setState(() {
                                        selectedYear = value;
                                      });
                                    },
                                    style: TextStyle(
                                        fontSize: size.height * 0.017,
                                        color: textColor1
                                    ),
                                    items:
                                    Constants.years.map<DropdownMenuItem<String>>((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: VariableText(
                                            text: item,
                                            fontsize: size.height * 0.017,
                                            fontcolor: textColor1,
                                            fontFamily: fontMedium,
                                          ),
                                        ),
                                      );
                                    }).toList()
                                ))
                        )
                    ),
                    
                  ),
                    SizedBox(width: size.width * 0.06),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.06),
            //Divider(color: primaryColorB,height: size.height * 0.05, thickness: 1),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
                child: Scrollbar(
                  thickness: 5.0,
                  child: ListView.separated(
                    itemCount:awesomeMomentsNames.length,
                    separatorBuilder: (_, index){
                      return Divider(color: primaryColorB,height: size.height * 0.05, thickness: 1);
                    },
                    itemBuilder: (_, index){
                      return InkWell(
                        onTap: (){
                          setState(() {
                             selectedmomentId =awesomeMomentsNames[index].id.toString();
                          });
                         
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(widget: CertificateTypeScreen(CertificateId: selectedmomentId.toString(),))
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: index == 19 ? size.height * 0.015 : 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              VariableText(
                                text:awesomeMomentsNames[index].name,
                                fontcolor: primaryColorW,
                                fontsize: size.height * 0.016,
                                fontFamily: fontMedium,
                                max_lines: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: size.width * 0.05),
                                child: VariableText(
                                  text: awesomeMomentsNames[index].year!,
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
