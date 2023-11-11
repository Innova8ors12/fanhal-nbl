import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/models/city_model.dart';
import 'package:fan_hall/models/get_countries.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/screens/dashboard/certificates/buy_certificate/2_4_2_select_league.dart';
import 'package:fan_hall/screens/registration_screens/3_select_league.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../widgets/common.dart';
import '../../widgets/constants.dart';
import '../../widgets/style.dart';
import '../login_screens/welcome_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  TextEditingController _city = TextEditingController();

  // String? selectedGender;
  validate() {
    bool allSet = false;
    // if (dobFormatter.toString().isEmpty) {
    if (selectedGender == null) {
      print("selectedGender");
      if (selectedNationality.toString().isEmpty) {
        if (dobFormatter.toString().isNotEmpty ||
            selectedGender.toString().isNotEmpty ||
            selectedNationality.toString().isNotEmpty) {
          Navigator.pushReplacement(
              context,
              SwipeLeftAnimationRoute(
                  milliseconds: 200, widget: const UserLeagueScreen()));
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please Select Nationality", toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please Select Gender", toastLength: Toast.LENGTH_SHORT);
    }
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Please Select Date", toastLength: Toast.LENGTH_SHORT);

    return allSet;
  }

  List<String> nationalities1 = [];
  List<String> region1 = [];
  getCountries() async {
    var res = await ApiModel().getcountries();
    // print(res);
    if (res != null && res['status']) {
      for (var item in res['data']) {
        _getCountries = GetCountries.fromJson(item);
        nationalities1.add(_getCountries!.name!.toString());
      }
      print(nationalities1);
      // nationalId = leagueModel!.data![1]!.id.toString();
      setState(() {});
    }
  }

  String countryId = "1";
  Future getCity() async {
    region1.clear();
    if (selectedNationality == "United States") {
      countryId = "1";
      var res = await ApiModel().getcities(countryId);

      if (res != null && res['status']) {
        region1.clear();
        for (var item in res['data']) {
          _getCity = GetCity.fromJson(item);
          region1.add(_getCity!.name!.toString());
        }
        print(region1);
        // nationalId = leagueModel!.data![1]!.id.toString();
        setState(() {});
      }
    }
    if (selectedNationality == "Mexico") {
      countryId = "2";
      var res = await ApiModel().getcities(countryId);

      if (res != null && res['status']) {
        region1.clear();
        for (var item in res['data']) {
          _getCity = GetCity.fromJson(item);
          region1.add(_getCity!.name!.toString());
        }
        print(region1);
        // nationalId = leagueModel!.data![1]!.id.toString();
        setState(() {});
      }
    }
    if (selectedNationality == "Canada") {
      countryId = "3";
      var res = await ApiModel().getcities(countryId);

      if (res != null && res['status']) {
        region1.clear();
        for (var item in res['data']) {
          _getCity = GetCity.fromJson(item);
          region1.add(_getCity!.name!.toString());
        }
        print(region1);
        // nationalId = leagueModel!.data![1]!.id.toString();
        setState(() {});
      }
    } else {}
  }

  GetCountries? _getCountries;
  GetCity? _getCity;
  @override
  void initState() {
    getCountries();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned(
            child: Image.asset("assets/images/welcome_background.png",
                fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0xFF000000).withOpacity(0.8),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.17),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.15),
                      Image.asset("assets/icons/ic_logo.png", scale: 5.8),
                      SizedBox(height: size.height * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: VariableText(
                              text: "Start your journey to become a fan!",
                              fontsize: size.height * 0.026,
                              fontcolor: textColorW,
                              fontFamily: fontBold,
                              weight: FontWeight.w700,
                              textAlign: TextAlign.center,
                              line_spacing: 1.5,
                              max_lines: 3,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.04),

                      ///Dob
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime.now(),
                              builder:(context,child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          textTheme:TextTheme(),
                                          colorScheme:  ColorScheme.light(
                                            brightness: Brightness.light,
                                           primary: Colors.blue,
                                           onPrimary: Colors.white,
                                           onSurface: Colors.white,
                                           
                                          ),

                                         
                                        ),
                                        
                                        child:child!,
                                      );
                                    } );

                          if (pickedDate != null) {
                            print("pickedDate $pickedDate");
                            setState(() {
                              selectedDate = dobFormatter.format(pickedDate);
                            });
                          } else {
                            customToast("Date is not selected");
                            print("Date is not selected");
                          }
                        },
                        child: Container(
                          height: size.height * 0.06,
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              border:
                                  Border.all(color: primaryColorW, width: 2.0)),
                          child: Row(
                            children: [
                              Expanded(
                                child: VariableText(
                                  text: selectedDate != null
                                      ? selectedDate!.split("-").first
                                      : "DD",
                                  fontsize: size.height * 0.017,
                                  fontcolor: selectedDate != null
                                      ? primaryColorW
                                      : Theme.of(context).hintColor,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                height: size.height * 0.025,
                                width: 1,
                                color: borderColor,
                              ),
                              Expanded(
                                child: VariableText(
                                  text: selectedDate != null
                                      ? selectedDate!.split("-")[1]
                                      : "MM",
                                  fontsize: size.height * 0.017,
                                  fontcolor: selectedDate != null
                                      ? primaryColorW
                                      : Theme.of(context).hintColor,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                height: size.height * 0.025,
                                width: 1,
                                color: borderColor,
                              ),
                              Expanded(
                                child: VariableText(
                                  text: selectedDate != null
                                      ? selectedDate!.split("-")[2]
                                      : "YYYY",
                                  fontsize: size.height * 0.017,
                                  fontcolor: selectedDate != null
                                      ? primaryColorW
                                      : Theme.of(context).hintColor,
                                  fontFamily: fontMedium,
                                  weight: FontWeight.w400,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),

                      ///Gender
                      Container(
                          height: size.height * 0.06,
                          child: InputDecorator(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.asset(
                                            'assets/icons/ic_dropdown.png',
                                            scale: 2),
                                      ),
                                      hint: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: VariableText(
                                          text: "Select Gender",
                                          fontsize: size.height * 0.017,
                                          fontcolor:
                                              Theme.of(context).hintColor,
                                          fontFamily: fontMedium,
                                        ),
                                      ),
                                      value: selectedGender,
                                      dropdownColor: backgroundColor1,
                                      isExpanded: true,
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedGender = value;
                                        });
                                      },
                                      style: TextStyle(
                                          fontSize: size.height * 0.017,
                                          color: textColorW),
                                      items: Constants.gender
                                          .map<DropdownMenuItem<String>>(
                                              (String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: VariableText(
                                              text: item,
                                              fontsize: size.height * 0.017,
                                              fontcolor: textColorW,
                                              fontFamily: fontMedium,
                                            ),
                                          ),
                                        );
                                      }).toList())))),
                      SizedBox(height: size.height * 0.02),

                      ///Nationality
                      Container(
                          height: size.height * 0.06,
                          child: InputDecorator(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.asset(
                                            'assets/icons/ic_dropdown.png',
                                            scale: 2),
                                      ),
                                      hint: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: VariableText(
                                          text: "Countries",
                                          fontsize: size.height * 0.017,
                                          fontcolor:
                                              Theme.of(context).hintColor,
                                          fontFamily: fontMedium,
                                        ),
                                      ),
                                      value: selectedNationality,
                                      dropdownColor: backgroundColor1,
                                      isExpanded: true,
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      onChanged: (String? value) {
                                        selectedcity = null;
                                        setState(() {
                                          selectedNationality =
                                              value.toString();
                                        });

                                        getCity();
                                      },
                                      style: TextStyle(
                                          fontSize: size.height * 0.017,
                                          color: textColorW),
                                      items: nationalities1
                                          .map<DropdownMenuItem<String>>(
                                              (String? item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: VariableText(
                                              text: item,
                                              fontsize: size.height * 0.017,
                                              fontcolor: textColorW,
                                              fontFamily: fontMedium,
                                            ),
                                          ),
                                        );
                                      }).toList())))),
                      SizedBox(height: size.height * 0.02),
                      Container(
                          height: size.height * 0.06,
                          child: InputDecorator(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(200),
                                    borderSide: BorderSide(
                                        color: primaryColorW, width: 2.0)),
                                contentPadding: EdgeInsets.all(10),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.asset(
                                            'assets/icons/ic_dropdown.png',
                                            scale: 2),
                                      ),
                                      hint: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: VariableText(
                                          text: "State or Province",
                                          fontsize: size.height * 0.017,
                                          fontcolor:
                                              Theme.of(context).hintColor,
                                          fontFamily: fontMedium,
                                        ),
                                      ),
                                      value: selectedcity,
                                      dropdownColor: backgroundColor1,
                                      isExpanded: true,
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        // selectedcity = null;
                                      },
                                      onChanged: (String? value) {
                                        setState(() {
                                        selectedcity = value.toString();  
                                        });
                                        
                                      },
                                      style: TextStyle(
                                          fontSize: size.height * 0.017,
                                          color: textColorW),
                                      items: region1
                                          .map<DropdownMenuItem<String>>(
                                              (String? item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: VariableText(
                                              text: item,
                                              fontsize: size.height * 0.017,
                                              fontcolor: textColorW,
                                              fontFamily: fontMedium,
                                            ),
                                          ),
                                        );
                                      }).toList())))),

                      ///City
                      // MyRoundTextField(
                      //   text: "Your City",
                      //   cont: _city,
                      // ),
                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                SwipeLeftAnimationRoute(
                                    widget: WelcomeScreen()),
                                (route) => route.isCurrent);
                          },
                          child: VariableText(
                            text: "Skip",
                            fontsize: size.height * 0.018,
                            fontcolor: textColor3,
                            fontFamily: fontMedium,
                            weight: FontWeight.w400,
                            textAlign: TextAlign.center,
                            underlined: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MyButtonIcon(
                      btnHeight: size.height * 0.055,
                      btnColor: primaryColorW,
                      borderColor: primaryColorW,
                      btnRadius: 200,
                      btnTxt: "Continue",
                      fontSize: size.height * 0.018,
                      fontFamily: fontSemiBold,
                      weight: FontWeight.w500,
                      txtColor: textColor1,
                      onTap: () {
                        if (selectedDate == null ||
                            selectedGender == null ||
                            selectedNationality == null ||
                            selectedcity == null) {
                          customToast("Please Select the Complete Data ");
                        }
                        // validate();
                        else {
                          UserModel userDetails = UserModel();
                          userDetails.dob = selectedDate.toString();
                          userDetails.gender = selectedGender.toString();
                          userDetails.nationality =
                              selectedNationality.toString();
                          userDetails.city = selectedcity.toString();
                          Navigator.pushReplacement(
                              context,
                              SwipeLeftAnimationRoute(
                                  milliseconds: 200,
                                  widget: const UserLeagueScreen()));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: MyBackButton(),
            ),
          )
        ],
      ),
    );
  }
}
