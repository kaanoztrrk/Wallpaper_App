// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:via_wall/controller/Api.dart';
import 'package:via_wall/model/PhotosModel.dart';
import 'package:via_wall/view/Widget/CatBlock.dart';
import 'package:via_wall/view/Widget/CustomAppBar.dart';
import 'package:via_wall/view/Widget/SearchBar.dart';
import 'package:via_wall/view/page/FullScreen.dart';

import '../../model/CategoryModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<PhotosModel> trendingWallList = [];
  late List<CategoryModel> CatModList = [];
  bool isLoading = true;

  getTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  getCatDetails() async {
    CatModList = ApiOperations.getCategoriesList();
    setState(() {
      CatModList = CatModList;
    });
  }

  @override
  void initState() {
    super.initState();
    getCatDetails();
    getTrendingWallpapers();
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomSearchBar(),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: CatModList.length,
                      itemBuilder: (context, index) => CatBlock(
                        categoryImgSrc: CatModList[index].catImgUrl,
                        categoryName: CatModList[index].catName,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      },
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: trendingWallList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 350,
                          crossAxisSpacing: 13,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => GridTile(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenWallpaper(
                                        imgUrl: trendingWallList[index].imgSrc),
                                  ));
                            },
                            child: Hero(
                              tag: trendingWallList[index].imgSrc,
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
                                    trendingWallList[index].imgSrc,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
