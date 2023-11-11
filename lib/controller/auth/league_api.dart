import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:fan_hall/models/get_photos.dart';
import 'package:fan_hall/models/league_model.dart';
import 'package:fan_hall/models/theme_model.dart';
import 'package:fan_hall/widgets/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../models/user_model.dart';
import '../config.dart';
import 'dart:convert' as convert;

class ApiModel {
  Future<dynamic> getData() async {
    List<LeagueModel> listdata = [];
    final url = Uri.parse("https://fanhall.app/api/leagues/getAll");
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> checkUserName(String username) async {
    final url = CONFIG.domain + CONFIG.checkusername;
    print(url);
    print(username);
    var postData = {
      "username": username,
    };

    try {
      var response = await http.post(Uri.parse(url), body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['status'];
      } else {
        return null;
      }
    } catch (e) {
      print("checkUserName Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> checkUserNameEmail(String usernameEmail) async {
    final url = CONFIG.domain + CONFIG.checkusernameemail;
    print(url);
    // print(username);
    var postData = {
      "email": usernameEmail,
    };

    try {
      var response = await http.post(Uri.parse(url), body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['status'];
      } else {
        return null;
      }
    } catch (e) {
      print("checkUserName Exception: " + e.toString());
      return null;
    }
  }

  Future<dynamic> getTeam(String id) async {
    List<LeagueModel> listdata = [];
    final url = Uri.parse("https://fanhall.app/api/teams/getTeam/$id");
    try {
      var response = await http.get(url);

      // var request = http.Request('GET',
      //     Uri.parse('https://fanhall.codeboxsolutions.com/api/leagues/getAll'));

      // http.StreamedResponse response = await request.send();
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;

        // var leaguedata = await response.stream.bytesToString();
        // List<dynamic> data = jsonDecode(leaguedata);
        // data.forEach((element) {
        //   LeagueModel model = LeagueModel.fromJson(element);
        //   listdata.add(model);
        // });
        // return listdata;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getScanCertificate(String id) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getScanCertificate + id);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getteamData(String id) async {
    final url = CONFIG.domain + CONFIG.getsingleTeam + id;

    try {
      var response = await http.get(Uri.parse(url));

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getcountries() async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getCountries);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getHeros(String type) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getHeros + type);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getmom() async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getMoments);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getSeasons(String id) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getSeasons + id);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> gethalloffame() async {
    final url = Uri.parse(CONFIG.domain + CONFIG.gethalloffame);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> gethalloffamebyyears(String Years) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.gethalloffamebyyears + Years);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getSurvey() async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getSurvey);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getArticle() async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getarticle);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getTeamPoster() async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getTeamPoster);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCertificate(
      String type, String teamId, int page, int limit) async {
    final url = Uri.parse(CONFIG.domain +
        CONFIG.getCerti +
        teamId +
        "/" +
        type +
        "/" +
        limit.toString() +
        "?page=$page");
    print(url);
    try {
      var response = await http.get(url);
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getFanMatchCertificate(int page, int limit) async {
    final url = Uri.parse(CONFIG.domain +
        CONFIG.getFanMatchcertificate +
        limit.toString() +
        "?page=$page");
    print(url);
    try {
      var response = await http.get(url);
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCertificatefame(
      String type, String teamId, int page, int limit) async {
    final url = Uri.parse(CONFIG.domain +
        CONFIG.getCertbyhalloffame +
        teamId +
        "/" +
        type +
        "/" +
        limit.toString() +
        "?page=$page");
    print(url);
    try {
      var response = await http.get(url);
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getShowcase(String selectedtype, int page, int limit) async {
    final url =
        Uri.parse(CONFIG.domain + CONFIG.getShowcase + "/" + selectedtype
            // +
            // "/" +
            // limit.toString() +
            // "?page=$page"

            );
    print(url);
    try {
      // var response = await http.get(url);
      var response = await http.get(
        url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + accessToken!,
        },
      ).timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(res.toString());
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getShowcaseFanMatch(
       int page, int limit) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getShowcaseFanMatch

        // +
        // "/" +
        // limit.toString() +
        // "?page=$page"

        );
    print(url);
    try {
      // var response = await http.get(url);
      var response = await http.get(
        url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + accessToken!,
        },
      ).timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(res.toString());
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCertiorder() async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getCertiorder);
    print(url);
    try {
      // var response = await http.get(url);
      var response = await http.get(
        url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + accessToken!,
        },
      ).timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> buyCertificate(
      String certId,
      String trans,
      Uint8List img,
      String name,
      String addresss,
      String phone,
      int quantity,
      String certName) async {
    String url = CONFIG.domain + CONFIG.buyCerti;
    print(url);
    var certImage = await MultipartFile.fromBytes(img,
        filename: "${DateTime.now().millisecondsSinceEpoch}.png",
        contentType: MediaType('image', 'png'));

    FormData postData = FormData.fromMap({
      "certificate_id": certId.toString(),
      "charge_id": trans.toString(),
      "name": name.toString(),
      "address": addresss.toString(),
      "phone": phone.toString(),
      "qty": quantity.toString(),
      "printname": certName.toString(),
    });
    postData.files.add(MapEntry("img", certImage));

    try {
      Dio dio = new Dio();
      var response = await dio.post(url,
          data: postData,
          options: Options(
              contentType: 'multipart/form-data; boundary=3000',
              headers: <String, String>{
                "Content-Type": "application/json",
                "Accept": "application/json",
                "Authorization": "Bearer $accessToken"
              }));
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
      /*var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken!},
          body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }*/
    } catch (e) {
      print("sendMessage Exception: " + e.toString());
      return null;
    }
  }

  Future<dynamic> CertificateconvertTo(String cert) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://v2.convertapi.com/convert/pdf/to/png?Secret=mjVnzNTHAaSpBxeK'));
    request.fields.addAll({'File': cert.toString(), 'StoreFile': 'true'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var url;
      var res = jsonDecode(await response.stream.bytesToString());
      final files = res['Files'];
      for (var file in files) {
        final fileUrl = file['Url'];

        // Do something with the file data here
        url = fileUrl.toString();
        // print('File: $fileName, Size: $fileSize, URL: $fileUrl');
      }
      print(res);

      // var url=files['Url'];
      return url;
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<dynamic> getfeeds(String token,
      {required int limit, required int page}) async {
    final url = CONFIG.domain + CONFIG.getfeeds;
    print(url);
    try {
      // var response = await http.get(url);
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        },
      ).timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getsnglepost(String token, String id) async {
    final url = CONFIG.domain + CONFIG.getsingle + id.toString();
    print(url);
    try {
      // var response = await http.get(url);
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        },
      ).timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getherosCertificate(
      String type, String teamId, int page, int limit) async {
    final url = Uri.parse(CONFIG.domain +
        CONFIG.getCertiByHero +
        teamId +
        "/" +
        type +
        "/" +
        limit.toString() +
        "?page=$page");
    print(url);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCertificatePdf(
      String name, String id, String type, String certid) async {
    final url = Uri.parse(CONFIG.domain +
        CONFIG.getCertiPdf +
        name +
        "/" +
        id +
        "/" +
        type +
        "/" +
        certid);
    print(url);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  //! create pdf for fanmatch
  Future<dynamic> getCertificatePdfforfanMatch(
      String name, String id, String username, String certid) async {
    final url = Uri.parse(CONFIG.domain +
        CONFIG.getCertiPdfforFAnmatch +
        certid +
        "/" +
        name +
        "/" +
        username);
    print(url);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getmomeCertificate(
      String type, String teamId, int page, int limit) async {
    final url = Uri.parse(CONFIG.domain +
        CONFIG.getCertiByMoments +
        teamId +
        "/" +
        type +
        "/" +
        limit.toString() +
        "?page=$page");
    print(url);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> delete(String id) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.deletepost + id);
    print(url);
    try {
      var response = await http.get(url,
          headers: <String, String>{"Authorization": "Bearer " + accessToken!});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getChatList Exception: " + e.toString());
      return null;
    }
  }

  Future<dynamic> deleteCert(String id) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.deletecert + id);
    print(url);
    try {
      var response = await http.get(url,
          headers: <String, String>{"Authorization": "Bearer " + accessToken!});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getChatList Exception: " + e.toString());
      return null;
    }
  }

  Future<dynamic> getcities(String id) async {
    final url = Uri.parse(CONFIG.domain + CONFIG.getCity + id);
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getChatList(String accessToken) async {
    String url = CONFIG.domain + CONFIG.getchatList;
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getChatList Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> getUserList(String accessToken) async {
    String url = CONFIG.domain + CONFIG.getuserList;
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getChatList Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> getScore(String accessToken) async {
    String url = CONFIG.domain + CONFIG.getteamScore;
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getChatList Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> getweek() async {
    String url = CONFIG.domain + CONFIG.getweek;
    print(url);
    try {
      var response = await http.get(Uri.parse(url));

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getyear() async {
    String url = CONFIG.domain + CONFIG.getYear;
    print(url);
    try {
      var response = await http.get(Uri.parse(url));

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getScorebyweek(
      String accessToken, String week, String year) async {
    String url = CONFIG.domain + CONFIG.getteamScorebyweek + week + "/" + year;
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getChatList Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> getUserListbyteam(
      String accessToken, String teamid) async {
    String url = CONFIG.domain + CONFIG.getuserListbyteam + teamId.toString();
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getChatList Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> getAllMessages(String id, String accessToken) async {
    String url = CONFIG.domain + CONFIG.getchatHistory + id.toString();
    print(url);
    try {
      var response = await http.get(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken});
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("getAllMessages Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> sendMessage(
      {String? id, String? content, accessToken}) async {
    String url = CONFIG.domain + CONFIG.sendMessage;
    print(url);
    var postData = {
      "user_id": id.toString(),
      "content": content!,
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken!},
          body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("sendMessage Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> DeleteMessage(String? id, String? accessToken) async {
    String url = CONFIG.domain + CONFIG.deleteMessage + id.toString();
    print(url);

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{"Authorization": "Bearer " + accessToken!},
      );
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("deleteMessage Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> sendSurvey(
      {String? id, String? Option, accessToken}) async {
    String url = CONFIG.domain + CONFIG.sendSurvey;
    print(url);
    var postData = {
      "survey_id": id.toString(),
      "option": Option!,
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken!},
          body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("sendMessage Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> checkSeen({String? id, accessToken}) async {
    String url = CONFIG.domain + CONFIG.CheckSeen;
    print(url);
    var postData = {
      "user_id": id.toString(),
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken!},
          body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("sendMessage Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> sendComment(
      {String? id, String? content, accessToken, String? photoId}) async {
    String url = CONFIG.domain + CONFIG.sendComment;
    print(url);
    var postData = {
      "user_id": id.toString(),
      "photo_id": photoId.toString(),
      "comment": content!,
    };
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken!},
          body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("sendMessage Exception: " + e.toString());
      return null;
    }
  }

  static Future<dynamic> seenMessage({String? id, String? accessToken}) async {
    String url = CONFIG.domain + CONFIG.getchatList + id.toString();
    print(url);
    var postData = {"sender_id": id.toString()};
    try {
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{"Authorization": "Bearer " + accessToken!},
          body: postData);
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data;
      } else {
        print(response.body);
        return null;
      }
    } catch (e) {
      print("seenMessage Exception: " + e.toString());
      return null;
    }
  }

  Future<dynamic> getTheme(String teamId) async {
    List<Theme1Model> listdata = [];
    final url = Uri.parse("https://fanhall.app/api/themes/getTheme/$teamId");
    try {
      var response = await http.get(url);

      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getAlbum(String token) async {
    final url = CONFIG.domain + CONFIG.getAlbum;
    print(url);
    try {
      // var response = await http.get(url);
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
        },
      ).timeout(Duration(seconds: CONFIG.timeoutDuration), onTimeout: () {
        throw "Request time out";
      });
      var res = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return res;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

// _submit() async {
//     for (int i = 0; i < images.length; i++) {
//         var path2 = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
//         var file = await getImageFileFromAsset(path2);
//         var base64Image = base64Encode(file.readAsBytesSync());
//         files.add(base64Image);
//         var data = {
//         "files": files,
//         };
//         try {
//             var response = await http.post(data, 'url')
//             var body = jsonDecode(response.body);
//             print(body);
//             if (body['msg'] == "Success!") {
//             print('posted successfully!');
//         } else {
//             _showToast(context, body['msg']);
//         }
//         } catch (e) {
//            return e.message;
//         }
//     }
// }
  Future fetchPhotos(String token) async {
    print(token);
    var url = CONFIG.domain + CONFIG.getPhotos;

    print(url);
    print(token);
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
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
      print("getEoindEvent: " + e.toString());
      return e;
    }
  }

  Future fetchAlbum(String token) async {
    print(token);
    var url = CONFIG.domain + CONFIG.getAlbum;

    print(url);
    print(token);
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
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
      print("getEoindEvent: " + e.toString());
      return e;
    }
  }

  Future fetchVideos(String token) async {
    print(token);
    var url = CONFIG.domain + CONFIG.getVideos;

    print(url);
    print(token);
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer " + token
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
      print("getEoindEvent: " + e.toString());
      return e;
    }
  }

  Future<dynamic> getPhoto(String? token) async {
    var url = Uri.parse(CONFIG.domain + CONFIG.getPhotos);

    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer$token"
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
  // try {
  //   var response = await http.get(url);

  //   var res = convert.jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     return res;

  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // } catch (e) {
  //     print(e);
  //   }
}
