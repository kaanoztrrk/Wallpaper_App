// ignore_for_file: file_names, prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:math';

import '../model/CategoryModel.dart';
import '../model/PhotosModel.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static String _apiKey =
      "563492ad6f91700001000001647b18af76064a2290c59e8b19a9c3d7";
  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization": _apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingWallpapers.add(PhotosModel.fromAPIApp(element));
      }
    });

    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": _apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      for (var element in photos) {
        searchWallpapersList.add(PhotosModel.fromAPIApp(element));
      }
    });

    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final random = Random();

      PhotosModel photoModel =
          (await searchWallpapers(catName))[0 + random.nextInt(11 - 0)];

      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}
