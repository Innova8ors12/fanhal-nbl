import 'dart:io';

import 'package:fan_hall/models/league_model.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../models/user_model.dart';
import '../config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationService with ChangeNotifier {
  List _data = [];

  List get data => _data;

  // Future<dynamic> getLeagues(LeagueModel league_model) async {
  //   var url = CONFIG.domain + CONFIG.getleague;
  //   var userleaguedata = {"img": league_model.img};

  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     final extractedData = json.decode(response.body) as List;

  //     _data = extractedData;

  //     notifyListeners();
  //     print(_data);
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<dynamic> loginUser(UserModel userModel) async {
    var url = CONFIG.domain + CONFIG.loginUser;
    print(url);
    print(userModel.token);
    var userPostdata = {
      "username": userModel.username,
      "password": userModel.token
    };
    try {
      var response = await http
          .post(Uri.parse(url),
              headers: <String, String>{"Content-Type": "application/json"},
              body: jsonEncode(userPostdata))
          .timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        print(data.toString());
        return data;
      } else {
        // var data = jsonDecode(utf8.decode(response.bodyBytes));
        // print(data.toString());
        // return data;
      }
    } catch (e) {
      print("loginUser: " + e.toString());
      return e;
    }
  }
// Future<dynamic> addUserImage(File? image, String accessToken) async {
//     String url ="${CONFIG.domain}${"api/users/register"}";
//     //print(url);
//     var userImage = await http.MultipartFile.fromFile(image!.path,
//         filename: image.path.split('/').last,
//         contentType: MediaType('image', 'jpg'));

//     FormData postData = FormData.fromMap({
//       "img": userImage,
//     });

//     try {
//       Dio dio = Dio();
//       var response = await dio.post(url,
//           data: postData,
//           options: Options(
//               contentType: 'multipart/form-data; boundary=1000',
//               headers: <String, String>{
//                 "Authorization":"Bearer " + accessToken,
//                 "Content-Type": "application/json",
//                 "Accept": "application/json"}
//           )).timeout(
//           Duration(seconds: CONFIG.timeoutDuration),
//           onTimeout: () {
//             throw "Request time out";
//           }
//       );
//       //print(response.statusCode.toString());
//       if (response.statusCode == 200) {
//         return response.data;
//       }else{
//         var data = jsonDecode(utf8.decode(response.data));
//         print(data.toString());
//         return data;
//       }
//     } catch (e) {
//       //print("addUserImage Exception: " + e.toString());
//       return null;
//     }
//   }
  Future<dynamic> userCreate(UserModel userDetails) async {
    var uri = Uri.parse("${CONFIG.domain}${"api/users/register"}");
    print(uri);

    final Map<String, String> userSignupdata = {
      "name": userDetails.name.toString(),
      "username": userDetails.username.toString(),
      "email": userDetails.email.toString(),
      "password": userDetails.token.toString(),
      "dob": userDetails.dob.toString(),
      "gender": userDetails.gender.toString(),
      "nationality": userDetails.nationality.toString(),
      "city": userDetails.city.toString(),
      "league_name": userDetails.leagueName.toString(),
      "team_id": userDetails.teamId.toString(),
      "card_img": userDetails.cardImg.toString(),
      "profile_img": userDetails.img.toString(),
      "latitude": userDetails.latitude.toString(),
      "longitude": userDetails.longitude.toString()
    };
    try {
      final headers = {
        'Content-Type': 'application/json',
      };
      var request = http.MultipartRequest('POST', uri);
      request.fields.addAll(userSignupdata);
      request.headers.addAll(headers);

      if (userDetails.cardImg.toString() != "null") {
        var multipartFile = await http.MultipartFile.fromPath(
          'card_img', userDetails.cardImg!,
          filename: userDetails.cardImg!.split('/').last,
          //contentType: MediaType("image", "jpg")
        );

        request.files.add(multipartFile);
      }
      if (userDetails.img.toString() != "null") {
        var multipartFile = await http.MultipartFile.fromPath(
          'profile_img', userDetails.img!,
          filename: userDetails.img!.split('/').last,
          //contentType: MediaType("image", "jpg")
        );

        request.files.add(multipartFile);
      }
      String jsonBody = json.encode(request.fields);

      var response = await request.send();

      final res = await http.Response.fromStream(response);
      // print(res[].toString());

      var res_data = json.decode(res.body.toString());
      // customToast(res_data['msg'].toString());
      if (res_data['status']) {
        return res_data;
      }
    } catch (e) {
      customToast("$e");
    }
  }
  // Future<dynamic> userCreate(UserModel userDetails) async {
  //   var url = "${CONFIG.domain}${"api/users/register"}";
  //   print(url);
  //   var userSignupdata = {
  //     "name": userDetails.name,
  //     "username": userDetails.username,
  //     "email": userDetails.email,
  //     "password": userDetails.token,
  //     "dob": userDetails.dob,
  //     "gender": userDetails.gender,
  //     "nationality": userDetails.nationality,
  //     "city": userDetails.city,
  //     "league_name": userDetails.leagueName,
  //     "team_id": userDetails.teamId,
  //     "card_img": userDetails.cardImg,
  //     "profile_img": userDetails.img
  //   };
  //   try {
  //     var response = await http
  //         .post(Uri.parse(url),
  //             headers: <String, String>{"Content-Type": "application/json"},
  //             body: jsonEncode(userSignupdata))
  //         .timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
  //       throw "Request time out";
  //     });
  //     print(response.statusCode.toString());
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(utf8.decode(response.bodyBytes));
  //       print(data.toString());
  //       return data;
  //     } else {
  //       var statusData = jsonDecode(utf8.decode(response.bodyBytes));
  //       return response.statusCode.toString();
  //     }
  //   } catch (e) {
  //     print("userCreate: " + e.toString());
  //     return e;
  //   }
  // }

  Future<dynamic> getLoggedUser(String? token) async {
    var url = '${CONFIG.domain}${CONFIG.getLogedUser}';
    print(url);
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      ).timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        print(data.toString());
        return data;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print("getLoggedUser: " + e.toString());
      return e;
    }
  }

  Future<dynamic> forgotPassword(String? email) async {
    var url = "${CONFIG.domain}${CONFIG.forgotPassword}";
    print(url);
    var userPostdata = {"email": email};
    try {
      var response = await http
          .post(Uri.parse(url),
              headers: <String, String>{"Content-Type": "application/json"},
              body: jsonEncode(userPostdata))
          .timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));

        return data;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print("forgotPassword: " + e.toString());
      return e;
    }
  }

  Future<dynamic> checkOTP(String email, String? otp) async {
    var url = "${CONFIG.domain}${CONFIG.checkotp}";
    print(url);
    print("Entered OTP");
    var userPostdata = {"email": email, "otp": otp};
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Content-Type": "application/json"},
          body: jsonEncode(userPostdata));

      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        print(data.toString());
        return data;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      print("checkOTP: " + e.toString());
      return e;
    }
  }

  void uploadImage(File imageFile) async {
    var dio = Dio();
    var file = await MultipartFile.fromFile(imageFile.path);
    var formData = FormData.fromMap({
      "img": file,
    });
    var response =
        await dio.post("${CONFIG.domain}${CONFIG.createUser}", data: formData);
    if (response.statusCode == 200) {
      print('Uploaded!');
    } else {
      print('Failed to upload image');
    }
  }

  Future<dynamic> updatePasswordCustomer(
      String? email, String? newpassword) async {
    var url = "${CONFIG.domain}${CONFIG.changePassword}";
    print(url);
    print(" email " + email.toString() + "password " + newpassword.toString());
    var updatepassword = {"email": email, "password": newpassword};
    try {
      print(url);

      var response = await http
          .post(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(updatepassword),
      )
          .timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        print(data.toString());
        return data;
      } else {
        return response.statusCode.toString();
      }
      return response;
      // return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e, stack) {
      print("updatePassword Exception: " + e.toString());
    }
  }
}
