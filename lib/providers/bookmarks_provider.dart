

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:news/consts/api_consts.dart';
import 'package:news/models/bookmarks_model.dart';
import 'package:news/models/news_model.dart';
import 'package:news/services/news_api.dart';

class BookmarksProvider with ChangeNotifier {
  List<BookmarksModel> bookmarkList = [];

  List<BookmarksModel> get getBookmarkList {
    return bookmarkList;
  }

  Future<List<BookmarksModel>> fetchBookmarks() async {
    bookmarkList = await NewsAPiServices.getBookmarks() ?? [];
    notifyListeners();
    return bookmarkList;
  }


  Future<void> addToBookmark({required NewsModel newsModel}) async {
    try {
      var uri = Uri.https(BASEURL_FIREBASE, "bookmarks.json");
      var response = await http.post(uri,
          body: json.encode(
            newsModel.toJson(),
          ));
      notifyListeners();
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteBookmark({required String key}) async {
    try {
      var uri =
          Uri.https(BASEURL_FIREBASE, "bookmarks/$key.json");
      var response = await http.delete(uri);
      notifyListeners();
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (error) {
      rethrow;
    }
  }
}
