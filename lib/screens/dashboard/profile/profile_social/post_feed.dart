import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fan_hall/controller/config.dart';
import 'package:fan_hall/models/user_model.dart';
import 'package:fan_hall/providers/theme_provider.dart';
import 'package:fan_hall/providers/userProvider.dart';
import 'package:fan_hall/screens/dashboard/profile/profile_main_screen.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:fan_hall/widgets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Post_Feeds extends StatefulWidget {
  const Post_Feeds({super.key});

  @override
  State<Post_Feeds> createState() => _Post_FeedsState();
}

class _Post_FeedsState extends State<Post_Feeds> {
  bool isupLoading = false;
  PickedFile? _imageFile1;
  TextEditingController caption = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  setupLoading(bool loading) {
    setState(() {
      isupLoading = loading;
    });
  }

  Future<void> _getFromGallery() async {
    PickedFile? imageFile1 = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    // setState(() {});

    _imageFile1 = imageFile1;
    if (imageFile1 != null) {
      setState(() {
        image_post = File(imageFile1.path.toString());
      });
      print(image1);
    }
  }

  Future<dynamic> uploadUserImage(
      imageFile1, String token, String captions) async {
    setupLoading(true);
    var url = CONFIG.domain + CONFIG.uploadPhotos;
    print(url);

    XFile tempFile = XFile(imageFile1);
    var image = await MultipartFile.fromFile(
      tempFile.path,
      filename: tempFile.path.split('/').last,
      // contentType: MediaType('image', 'jpg')
    );
    FormData postData =
        FormData.fromMap({"imgs[]": image, "caption": captions});

    try {
      Dio dio = new Dio();
      var response = await dio.post(url,
          data: postData,
          options: Options(
              contentType: 'multipart/form-data; boundary=1000',
              headers: <String, String>{
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer " + token
              }));
      print(response.statusCode.toString());
      setupLoading(false);
      image_post = null;
      Navigator.pop(context, SwipeUpAnimationRoute(widget: Post_Feeds()));

      setupLoading(false);
       
      setState(() {});
      if (response.data['status'].toString() == "true") {

        UserModel userModel = UserModel.fromJson(response.data['data']);
        Provider.of<UserProvider>(context, listen: false).setUser(userModel);
        customToast('uploaded successfully');
      }
      return response.data;
    } catch (e) {
      print("uploadUserImage Exception: " + e.toString());
      
    }
  }

  @override
  Widget build(BuildContext context) {
       var color = Provider.of<ThemeProvider>(context).theme1model;
    var user = Provider.of<UserProvider>(context).user;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isupLoading == true
                    ? Container(height: 1, child: LinearProgressIndicator())
                    : Container(
                        height: 1,
                      ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,color: textColorW,),
                      onPressed: () async {
                        Navigator.pop(context,
                            SwipeUpAnimationRoute(widget: Post_Feeds()));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('Create Post'),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () async {
                        if (caption.text.trim()!= "") {
                          uploadUserImage(
                              image_post!.path, accessToken!, caption.text);
                        } else {
                          customToast("Please Enter Caption");
                        }
                      },
                      child: VariableText(
                        text: 'Post',
                        fontcolor: Theme.of(context).iconTheme.color,
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  // contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(200)),
                        child: Image.network(user.img!,scale: 3,fit: BoxFit.fill,),
                  ),
                  title: Text(user.name!.toUpperCase()),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        // Expanded(
                        //   child: OutlinedButton.icon(
                        //     style: OutlinedButton.styleFrom(
                        //         foregroundColor: Colors.grey),
                        //     onPressed: () {},
                        //     icon: Icon(Icons.group),
                        //     label: Row(
                        //       children: [
                        //         Text('Friends'),
                        //         Expanded(
                        //           child: Icon(
                        //             Icons.arrow_drop_down,
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey),
                            onPressed: () async {
                              _getFromGallery();
                            },
                            icon: Icon(Icons.add),
                            label: Row(
                              children: [
                                Text('Photo'),
                                Expanded(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 5,
                  controller: caption,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    
                    hintText: 'What\'s on your Mind?',
                    
                    hintStyle: TextStyle(fontSize: 20,color: textColorW),
                  ),
                ),
                Container(
                  height: size.height * 0.5,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: image_post != null
                      ? Image.file(
                          image_post!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          child: Center(
                            child: VariableText(
                              text: "No Image Found!",
                              fontsize: size.height * 0.026,
                              fontcolor:HexColor(color.textColor!) ,
                              fontFamily: fontBold,
                              weight: FontWeight.w700,
                              textAlign: TextAlign.center,
                              max_lines: 2,
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
