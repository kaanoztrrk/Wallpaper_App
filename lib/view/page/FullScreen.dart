// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class FullScreenWallpaper extends StatelessWidget {
  FullScreenWallpaper({super.key, required this.imgUrl});

  String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          ElevatedButton(onPressed: () {}, child: const Text("Set Wallpaper")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imgUrl), fit: BoxFit.cover)),
      ),
    );
  }
}
