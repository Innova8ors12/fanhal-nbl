import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fan_hall/controller/auth/league_api.dart';
import 'package:fan_hall/controller/config.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/profile/menu/edit_profile/change_team_screem.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../models/user_model.dart';
import '../../../../../widgets/common.dart';
import '../../../../../widgets/style.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? imageFile;

  void uploadImage(XFile imageFile) async {
    var dio = Dio();
    var file = await MultipartFile.fromFile(imageFile.path);
    var formData = FormData.fromMap({
      "img": file,
    });

    var response =
        await dio.post("${CONFIG.domain}${CONFIG.updateData}", data: formData);
    if (response.statusCode == 200) {
      // UserModel userModel = UserModel(img: file.toString());

      // Provider.of<UserProvider>(context).setUser(userModel);
      customToast('Uploaded!');
    } else {
      customToast('Failed to upload image');
    }
  }

  @override
  Widget build(BuildContext context) {
   
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: size.width * horizontalPadding),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),

              ///appbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: primaryColorW)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: InkWell(
                      onTap: () {
                        uploadImage(imageFile!);
                      },
                      child: VariableText(
                        text: "Save",
                        fontcolor: Theme.of(context).primaryColor,
                        fontsize: size.height * 0.018,
                        fontFamily: fontRegular,
                        max_lines: 1,
                        textAlign: TextAlign.center,
                        underlined: true,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.00),
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: imageFile == null
                    ? Image.network(
                        user.img!,
                        scale: 2,
                        fit: BoxFit.fill,
                        height: size.height * 0.12,
                        width: size.width * 0.25,
                      )
                    : Image.file(
                        File(
                          imageFile!.path,
                        ),
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                        // width: 150,
                      ),
              ),

              SizedBox(height: size.height * 0.03), //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      imageFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                    },
                    child: VariableText(
                      text: "Edit picture",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.016,
                      fontFamily: fontRegular,
                      max_lines: 1,
                      textAlign: TextAlign.center,
                      underlined: true,
                    ),
                  )
                ],
              ),
              Divider(
                  color: primaryColorB,
                  thickness: 4,
                  height: size.height * 0.05),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: VariableText(
                      text: "Name",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.016,
                      fontFamily: fontRegular,
                      max_lines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: VariableText(
                      text: user.name!.toUpperCase(),
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.016,
                      fontFamily: fontRegular,
                      max_lines: 1,
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: VariableText(
                      text: "Username",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.016,
                      fontFamily: fontRegular,
                      max_lines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: VariableText(
                      text: user.username!,
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.016,
                      fontFamily: fontRegular,
                      max_lines: 1,
                    ),
                  )
                ],
              ),
              Divider(
                  color: primaryColorB,
                  thickness: 4,
                  height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VariableText(
                    text: "City",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.016,
                    fontFamily: fontRegular,
                    max_lines: 1,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VariableText(
                          text: user.city,
                          fontcolor: Color(0xFF777777),
                          fontsize: size.height * 0.016,
                          fontFamily: fontRegular,
                          max_lines: 1,
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: size.height * 0.02, color: primaryColorW)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VariableText(
                    text: "Mail",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.016,
                    fontFamily: fontRegular,
                    max_lines: 1,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VariableText(
                          text: user.email,
                          fontcolor: Color(0xFF777777),
                          fontsize: size.height * 0.016,
                          fontFamily: fontRegular,
                          max_lines: 1,
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: size.height * 0.02, color: primaryColorW)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VariableText(
                    text: "Mobile",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.016,
                    fontFamily: fontRegular,
                    max_lines: 1,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        VariableText(
                          text: "+ 1 717 724 814",
                          fontcolor: Color(0xFF777777),
                          fontsize: size.height * 0.016,
                          fontFamily: fontRegular,
                          max_lines: 1,
                        ),
                        Icon(Icons.arrow_forward_ios,
                            size: size.height * 0.02, color: primaryColorW)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      SwipeUpAnimationRoute(widget: ChangeTeamScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VariableText(
                      text: "Change team",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.016,
                      fontFamily: fontRegular,
                      max_lines: 1,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          VariableText(
                            text: "Steelers",
                            fontcolor: Color(0xFF777777),
                            fontsize: size.height * 0.016,
                            fontFamily: fontRegular,
                            max_lines: 1,
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: size.height * 0.02, color: primaryColorW)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
