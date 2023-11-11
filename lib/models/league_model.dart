import 'package:flutter/cupertino.dart';

import 'dart:convert';

LeagueModel? leagueModelFromJson(String str) => LeagueModel.fromJson(json.decode(str));

String leagueModelToJson(LeagueModel? data) => json.encode(data!.toJson());

class LeagueModel {
    LeagueModel({
        this.status,
        this.data,
    });

    bool? status;
    List<Data?>? data;

    factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Data?>.from(json["data"]!.map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
    };
}

class Data {
    Data({
        this.id,
        this.img,
        this.name,
        this.active,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? img;
    String? name;
    dynamic active;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        img: json["img"],
        name: json["name"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "name": name,
        "active": active,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}