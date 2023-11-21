// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:via_wall/controller/Api.dart';
import 'package:via_wall/model/PhotosModel.dart';
import 'package:via_wall/view/Widget/CustomAppBar.dart';
import 'package:via_wall/view/page/FullScreen.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, required this.query});
  String query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<PhotosModel> searchResult = [];

  getSearchresult() async {
    searchResult = await ApiOperations.searchWallpapers(widget.query);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchresult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const CustomAppbar(word1: "Vi - ", word2: "Wallpaper"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: searchResult.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 350,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenWallpaper(
                              imgUrl: searchResult[index].imgSrc),
                        ));
                  },
                  child: Hero(
                    tag: searchResult[index].imgSrc,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amberAccent,
                      ),
                      height: 500,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          searchResult[index].imgSrc,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
