import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:hive/hive.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:hive_generator/hive_generator.dart';
part 'starwars_repo.g.dart';

@HiveType(typeId: 1)
class People {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? height;
  @HiveField(2)
  String? mass;
  @HiveField(3)
  String? birthYear;
  @HiveField(4)
  String? gender;
  @HiveField(5)
  String? homeworld;
  @HiveField(6)
  String? hairColor;
  @HiveField(7)
  String? skinColor;
  @HiveField(8)
  String? eyeColor;
  @HiveField(9)
  int? no;

  People(
      {@required this.name,
      @required this.height,
      @required this.mass,
      @required this.birthYear,
      @required this.gender,
      @required this.homeworld,
      @required this.hairColor,
      @required this.skinColor,
      @required this.eyeColor,
      @required this.no});

  factory People.fromJson(Map<String, dynamic> json) {
    var box = Hive.box('starwars');
    int peopleNumber = int.parse(json["url"]
        .toString()
        .substring(29, json["url"].toString().length - 1));
    // File imageFile = FileImage(Image(image: image))(CachedNetworkImageProvider('https://starwars-visualguide.com/assets/img/characters/$peopleNumber.jpg'));
    // String path = CachedNetworkImageProvider('https://starwars-visualguide.com/assets/img/characters/$peopleNumber.jpg');
    // CachedNetworkImageProvider(
    //             'https://starwars-visualguide.com/assets/img/characters/$peopleNumber.jpg');
    People people = People(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: json["gender"],
        homeworld: json["homeworld"],
        no: peopleNumber);
    box.put(peopleNumber, people);
    return people;
  }
}

class Page {
  String? next;
  List<People>? people;
}

class StarwarsRepo {
  //Future<List<People>>
  Future getPage(int pageNum) async {
    List<People>? page;
    var dio = Dio();
    final response = await dio
        .get('https://swapi.dev/api/people/?page=$pageNum&format=json');
    page = List<People>.from(
        response.data['results'].map((x) => People.fromJson(x)));
    // return page;
  }
}
