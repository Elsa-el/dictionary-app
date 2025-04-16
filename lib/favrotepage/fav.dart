import 'package:dictonary/commonpage/fav_shared.dart';
import 'package:flutter/material.dart';

class FavoriteWordAdapter extends StatefulWidget {
  const FavoriteWordAdapter({super.key});

  @override
  State<FavoriteWordAdapter> createState() => _FavoriteWordAdapterState();
}

class _FavoriteWordAdapterState extends State<FavoriteWordAdapter> {
  List<String> favList = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    List<String> bookmarks = await getData();
    setState(() {
      favList = bookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [for (String word in favList) ListTile(title: Text(word))],
    );
  }
}
