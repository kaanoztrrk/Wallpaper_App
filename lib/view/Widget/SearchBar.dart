// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:via_wall/view/page/Search.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: const Color.fromARGB(125, 238, 238, 238),
          border: Border.all(),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search Wallpaper",
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SearchPage(query: _searchController.text),
                  ));
            },
            child: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
