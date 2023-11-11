import 'package:cached_network_image/cached_network_image.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/survey_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../widgets/common.dart';
import '../../../../widgets/style.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  List<SurveyModel> Survey = [];
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  int selectedSurveyIndex = 0;

  onSurveySelect(int index) {
    setState(() {
      selectedSurveyIndex = index;
    });
  }


  bool voted = false;
  bool votedONE = false;
  sendSurvey(String? surveyId, String? option) async {
    // var userDetails = Provider.of<UserModel>(context, listen: false);

    //scrollToBottom();
    var response = await ApiModel.sendSurvey(
        id: surveyId, Option: option!, accessToken: accessToken);
    if (response != null) {
      if (response['status']) {
        
        getteamSurvey();
        
      } else {

        Fluttertoast.showToast(
            msg: "Survey not sent", toastLength: Toast.LENGTH_SHORT);
            customToast(response['msg']);
      }
    } else {
      Fluttertoast.showToast(msg: "Try again", toastLength: Toast.LENGTH_SHORT);
    }
  }

  getteamSurvey() async {
    setLoading(true);
    var res = await ApiModel().getSurvey();

    SurveyModel? _survey;
    // print(res);
    Survey.clear();
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _survey = SurveyModel.fromJson(item);

        Survey.add(_survey);
      }
      setLoading(false);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getteamSurvey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.02),

            ///appbar
            MenuAppbar(allowBack: true),
            //SizedBox(height: size.height * 0.03),
            isLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )
                : Container(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.03),
                child: ListView.separated(
                    itemCount: Survey.length,
                    separatorBuilder: (_, index) {
                      return Divider(
                          color: primaryColorB,
                          height: size.height * 0.05,
                          thickness: 1);
                    },
                    itemBuilder: (_, index) {
                      return Survey[index].surveyType == "image"
                          ? Container(
                              // height: size.height * 0.50,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.08,
                                  vertical: size.height * 0.03),
                              decoration: BoxDecoration(
                                  color: primaryColorB.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Row(
                                    // crossAxisAlignment: Cro,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      VariableText(
                                        text: Survey[index].question.toString(),
                                        fontsize: size.height * 0.014,
                                        fontcolor: primaryColorW,
                                        fontFamily: fontMedium,
                                        weight: FontWeight.w600,
                                        textAlign: TextAlign.center,
                                        max_lines: 5,
                                        line_spacing: 1.4,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                        


                                         sendSurvey(
                                              Survey[index].id.toString(),
                                              "option_a");
                                          setState(() {
                                            onSurveySelect(index);
                                            if (selectedSurveyIndex == index) {
                                              voted = true;
                                            }
                                            
                                          });
                                        },
                                        child: Container(
                                          height: size.height * 0.13,
                                          width: size.width * 0.30,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF0555555),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              )),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: Survey[index]
                                                    .optionA
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              if (voted)
                                                Container(
                                                  height: size.height * 0.2,
                                                  width: size.width *
                                                      (Survey[index].optiona==null?0: Survey[index].optiona!/
                                                      330),
                                                  decoration: BoxDecoration(
                                                    color: backgroundColor1,
                                                  ),
                                                ),
                                              if (voted)
                                                VariableText(
                                                  text:
                                                      '${ (Survey[index].optiona==null?0: Survey[index].optiona!
                                                      )}%',
                                                  fontsize: size.height * 0.014,
                                                  fontcolor: primaryColorW,
                                                  fontFamily: fontMedium,
                                                  weight: FontWeight.w500,
                                                  textAlign: TextAlign.start,
                                                  max_lines: 1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // SizedBox(width: size.width * 0.05),
                                      InkWell(
                                        onTap: () {
                                         sendSurvey(
                                              Survey[index].id.toString(),
                                              "option_b");
                                          setState(() {
                                            onSurveySelect(index);
                                            if (selectedSurveyIndex == index) {
                                              voted = true;
                                            }
                                            
                                          });
                                        },
                                        child: Container(
                                          height: size.height * 0.13,
                                          width: size.width * 0.30,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF0555555),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              )),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: Survey[index]
                                                    .optionB
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                // placeholder: (context, url) =>
                                                //     CircularProgressIndicator(
                                                //   color: Theme.of(context)
                                                //       .primaryColor,
                                                // ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                              if (voted)
                                                Container(
                                                  height: size.height * 0.13,
                                                  width: size.width *
                                                      (Survey[index].optionb==null?0: Survey[index].optionb!/
                                                      330),
                                                  decoration: BoxDecoration(
                                                    color: backgroundColor1,
                                                  ),
                                                ),
                                              if (voted)
                                                VariableText(
                                                  text: '${ (Survey[index].optionb==null?0: Survey[index].optionb!)}%',
                                                  fontsize: size.height * 0.014,
                                                  fontcolor: primaryColorW,
                                                  fontFamily: fontMedium,
                                                  weight: FontWeight.w500,
                                                  textAlign: TextAlign.start,
                                                  max_lines: 1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                         sendSurvey(
                                              Survey[index].id.toString(),
                                              "option_c");
                                          setState(() {
                                            onSurveySelect(index);
                                            if (selectedSurveyIndex == index) {
                                              voted = true;
                                            }
                                          
                                          });
                                        },
                                        child: Container(
                                          height: size.height * 0.13,
                                          width: size.width * 0.30,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF0555555),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              )),
                                          child: Stack(
                                            children: [
                                            
                                              CachedNetworkImage(
                                                imageUrl: Survey[index]
                                                    .optionC
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                // placeholder: (context, url) =>
                                                //     CircularProgressIndicator(
                                                //   color: Theme.of(context)
                                                //       .primaryColor,
                                                // ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                                if (voted)
                                                Container(
                                                  height: size.height * 0.2,
                                                  width: size.width *  (Survey[index].optionc==null?0: Survey[index].optionc!),
                                                  decoration: BoxDecoration(
                                                    color: backgroundColor1,
                                                  ),
                                                ),
                                              if (voted)
                                                VariableText(
                                                  text: '${ (Survey[index].optionc==null?0: Survey[index].optionc!)}%',
                                                  fontsize: size.height * 0.014,
                                                  fontcolor: primaryColorW,
                                                  fontFamily: fontMedium,
                                                  weight: FontWeight.w500,
                                                  textAlign: TextAlign.start,
                                                  max_lines: 1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // SizedBox(width: size.width * 0.05),
                                      InkWell(
                                        onTap: () {
                                          sendSurvey(
                                              Survey[index].id.toString(),
                                              "option_d");

                                          setState(() {
                                            onSurveySelect(index);
                                            if (selectedSurveyIndex == index) {
                                              voted = true;
                                            }
                                            
                                          });
                                        },
                                        child: Container(
                                          height: size.height * 0.13,
                                          width: size.width * 0.30,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF0555555),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              )),
                                          child: Stack(
                                            children: [
                                            
                                              CachedNetworkImage(
                                                imageUrl: Survey[index]
                                                    .optionD
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                // placeholder: (context, url) =>
                                                //     CircularProgressIndicator(
                                                //   color: Theme.of(context)
                                                //       .primaryColor,
                                                // ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                                if (voted)
                                                Container(
                                                  height: size.height * 0.2,
                                                  width: size.width * (Survey[index].optiond==null?0: Survey[index].optiond!),
                                                  decoration: BoxDecoration(
                                                    color: backgroundColor1,
                                                  ),
                                                ),
                                              if (voted)
                                                VariableText(
                                                  text: '${ (Survey[index].optiona==null?0: Survey[index].optiona!)}%',
                                                  fontsize: size.height * 0.014,
                                                  fontcolor: primaryColorW,
                                                  fontFamily: fontMedium,
                                                  weight: FontWeight.w500,
                                                  textAlign: TextAlign.start,
                                                  max_lines: 1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (voted)
                                    SizedBox(height: size.height * 0.03),
                                  if (voted)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: VariableText(
                                            text:
                                                '${Survey[index].totalcount==Null? "":Survey[index].totalcount!.toString()} Total Votes',
                                            fontsize: size.height * 0.014,
                                            fontcolor: primaryColorW,
                                            fontFamily: fontMedium,
                                            weight: FontWeight.w600,
                                            textAlign: TextAlign.end,
                                            max_lines: 1,
                                            line_spacing: 1.4,
                                          ),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            )
                          : Container(
                              // height: size.height * 0.50,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.08,
                                  vertical: size.height * 0.03),
                              decoration: BoxDecoration(
                                  color: primaryColorB.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: VariableText(
                                          text:
                                              Survey[index].question.toString(),
                                          fontsize: size.height * 0.014,
                                          fontcolor: primaryColorW,
                                          fontFamily: fontMedium,
                                          weight: FontWeight.w600,
                                          textAlign: TextAlign.center,
                                          max_lines: 5,
                                          line_spacing: 1.4,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  InkWell(
                                    onTap: () {
                                       sendSurvey(Survey[index].id.toString(),
                                          "option_a");

                                      setState(() {
                                        onSurveySelect(index);
                                        if (selectedSurveyIndex == index) {
                                          voted = true;
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: size.height * 0.06,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF0555555),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(200),
                                              topLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200),
                                              bottomRight: Radius.circular(200),
                                              bottomLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200))),
                                      child: Stack(
                                        children: [
                                          if (voted)
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width *
                                                  (Survey[index].optiona==null?0: Survey[index].optiona!/
                                                  135),
                                              decoration: BoxDecoration(
                                                color: backgroundColor1,
                                              ),
                                            ),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (Survey[index]
                                                          .surveyType
                                                          .toString() ==
                                                      "text")
                                                    Expanded(
                                                      child: VariableText(
                                                        text: Survey[index]
                                                            .optionA
                                                            .toString(),
                                                        fontsize:
                                                            size.height * 0.014,
                                                        fontcolor:
                                                            primaryColorW,
                                                        fontFamily: fontRegular,
                                                        weight: FontWeight.w400,
                                                        textAlign:
                                                            TextAlign.start,
                                                        max_lines: 1,
                                                      ),
                                                    )
                                                  else
                                                    Expanded(
                                                        child:
                                                            CachedNetworkImage(
                                                      imageUrl: Survey[index]
                                                          .optionA
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      // placeholder: (context, url) =>
                                                      //     CircularProgressIndicator(
                                                      //   color: Theme.of(context)
                                                      //       .primaryColor,
                                                      // ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )),
                                                  if (voted)
                                                    VariableText(
                                                      text:
                                                          '${  (Survey[index].optiona==null?0: Survey[index].optiona!)}%',
                                                      fontsize:
                                                          size.height * 0.014,
                                                      fontcolor: primaryColorW,
                                                      fontFamily: fontMedium,
                                                      weight: FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.start,
                                                      max_lines: 1,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  InkWell(
                                    onTap: () {
                                     sendSurvey(Survey[index].id.toString(),
                                          "option_b");
                                      setState(() {
                                        onSurveySelect(index);
                                        if (selectedSurveyIndex == index) {
                                          voted = true;
                                        }
                                         
                                      });
                                    },
                                    child: Container(
                                      height: size.height * 0.06,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF0555555),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(200),
                                              topLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200),
                                              bottomRight: Radius.circular(200),
                                              bottomLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200))),
                                      child: Stack(
                                        children: [
                                          if (voted)
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width *
                                                  (Survey[index].optionb==null?0: Survey[index].optionb!/
                                                  135),
                                              decoration: BoxDecoration(
                                                color: backgroundColor1,
                                              ),
                                            ),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (Survey[index]
                                                          .surveyType
                                                          .toString() ==
                                                      "text")
                                                    Expanded(
                                                      child: VariableText(
                                                        text: Survey[index]
                                                            .optionB
                                                            .toString(),
                                                        fontsize:
                                                            size.height * 0.014,
                                                        fontcolor:
                                                            primaryColorW,
                                                        fontFamily: fontRegular,
                                                        weight: FontWeight.w400,
                                                        textAlign:
                                                            TextAlign.start,
                                                        max_lines: 1,
                                                      ),
                                                    )
                                                  else
                                                    Expanded(
                                                        child:
                                                            CachedNetworkImage(
                                                      imageUrl: Survey[index]
                                                          .optionB
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      // placeholder: (context, url) =>
                                                      //     CircularProgressIndicator(
                                                      //   color: Theme.of(context)
                                                      //       .primaryColor,
                                                      // ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )),
                                                  if (voted)
                                                    VariableText(
                                                      text:
                                                          '${  (Survey[index].optiona==null?0: Survey[index].optiona!)}%',
                                                      fontsize:
                                                          size.height * 0.014,
                                                      fontcolor: primaryColorW,
                                                      fontFamily: fontMedium,
                                                      weight: FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.start,
                                                      max_lines: 1,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  InkWell(
                                    onTap: () {
                                      sendSurvey(Survey[index].id.toString(),
                                          "option_c");
                                      setState(() {
                                        onSurveySelect(index);
                                        if (selectedSurveyIndex == index) {
                                          voted = true;
                                        }
                                        

                                      });
                                    },
                                    child: Container(
                                      height: size.height * 0.06,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF0555555),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(200),
                                              topLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200),
                                              bottomRight: Radius.circular(200),
                                              bottomLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200))),
                                      child: Stack(
                                        children: [
                                          if (voted)
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width *
                                                   (Survey[index].optionc==null?0: Survey[index].optionc!/
                                                  135),
                                              decoration: BoxDecoration(
                                                color: backgroundColor1,
                                              ),
                                            ),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (Survey[index]
                                                          .surveyType
                                                          .toString() ==
                                                      "text")
                                                    Expanded(
                                                      child: VariableText(
                                                        text: Survey[index]
                                                            .optionC
                                                            .toString(),
                                                        fontsize:
                                                            size.height * 0.014,
                                                        fontcolor:
                                                            primaryColorW,
                                                        fontFamily: fontRegular,
                                                        weight: FontWeight.w400,
                                                        textAlign:
                                                            TextAlign.start,
                                                        max_lines: 1,
                                                      ),
                                                    )
                                                  else
                                                    Expanded(
                                                        child:
                                                            CachedNetworkImage(
                                                      imageUrl: Survey[index]
                                                          .optionC
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      // placeholder: (context, url) =>
                                                      //     CircularProgressIndicator(
                                                      //   color: Theme.of(context)
                                                      //       .primaryColor,
                                                      // ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )),
                                                  if (voted)
                                                    VariableText(
                                                      text:
                                                          '${(Survey[index].optionc==null?0: Survey[index].optionc!)}%',
                                                      fontsize:
                                                          size.height * 0.014,
                                                      fontcolor: primaryColorW,
                                                      fontFamily: fontMedium,
                                                      weight: FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.start,
                                                      max_lines: 1,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  InkWell(
                                    onTap: () {
                                      onSurveySelect(index);

                                     sendSurvey(Survey[index].id.toString(),
                                          "option_d");
                                      setState(() {
                                        onSurveySelect(index);
                                        if (selectedSurveyIndex == index) {
                                          voted = true;
                                        }
                                        
                                      });
                                    },
                                    child: Container(
                                      height: size.height * 0.06,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF0555555),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(200),
                                              topLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200),
                                              bottomRight: Radius.circular(200),
                                              bottomLeft: voted
                                                  ? Radius.circular(0)
                                                  : Radius.circular(200))),
                                      child: Stack(
                                        children: [
                                          if (voted)
                                            Container(
                                              height: size.height * 0.06,
                                              width: size.width *
                                                   (Survey[index].optiond==null?0: Survey[index].optiond!/
                                                  135),
                                              decoration: BoxDecoration(
                                                color: backgroundColor1,
                                              ),
                                            ),
                                          Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      size.width * 0.05),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (Survey[index]
                                                          .surveyType
                                                          .toString() ==
                                                      "text")
                                                    Expanded(
                                                      child: VariableText(
                                                        text: Survey[index]
                                                            .optionD
                                                            .toString(),
                                                        fontsize:
                                                            size.height * 0.014,
                                                        fontcolor:
                                                            primaryColorW,
                                                        fontFamily: fontRegular,
                                                        weight: FontWeight.w400,
                                                        textAlign:
                                                            TextAlign.start,
                                                        max_lines: 1,
                                                      ),
                                                    )
                                                  else
                                                    Expanded(
                                                        child:
                                                            CachedNetworkImage(
                                                      imageUrl: Survey[index]
                                                          .optionD
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      // placeholder: (context, url) =>
                                                      //     CircularProgressIndicator(
                                                      //   color: Theme.of(context)
                                                      //       .primaryColor,
                                                      // ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )),
                                                  if (voted)
                                                    VariableText(
                                                      text:
                                                          '${  (Survey[index].optiond==null?0: Survey[index].optiond!)}%',
                                                      fontsize:
                                                          size.height * 0.014,
                                                      fontcolor: primaryColorW,
                                                      fontFamily: fontMedium,
                                                      weight: FontWeight.w500,
                                                      textAlign:
                                                          TextAlign.start,
                                                      max_lines: 1,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (voted)
                                    SizedBox(height: size.height * 0.03),
                                  if (voted)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: VariableText(
                                            text:
                                                '${Survey[index].totalcount==Null? "":Survey[index].totalcount!.toString()} Total Votes',
                                            fontsize: size.height * 0.014,
                                            fontcolor: primaryColorW,
                                            fontFamily: fontMedium,
                                            weight: FontWeight.w600,
                                            textAlign: TextAlign.end,
                                            max_lines: 1,
                                            line_spacing: 1.4,
                                          ),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                            );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
