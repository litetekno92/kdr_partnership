import 'package:flutter/material.dart';
import 'package:partnership/model/ATableModel.dart';
import 'package:partnership/model/ApiRoutes.dart';
import 'dart:convert';

class StoryModel {
  final String title;
  final String description;
  final String imgPath;
  StoryModel({@required String title, @required String imgPath, @required String description}) : title = title, description = description, imgPath = imgPath {}
}

class StoriesModel extends ATableModel {
  List<StoryModel> _stories;
  StoriesModel({@required String useruid}) :
    super(path: ApiRoutes.getStories, header: {
      "uuid":useruid,
      "token":"token"
    });
  @override
  readJSON() {
    Map<String, dynamic> json = this.requestedJSON;
    if (json == null)
      return ;
    _stories = List<StoryModel>();
    StoryModel toadd;
    var value = json["value"];
    var to_parse = null;
    for (var elem in value) {
      toadd = _createStoryModel(elem);
      if (toadd != null)
        _stories.add(toadd);
    }
  }
  Future<List<StoryModel>> getStories() async {
    if (this.isUpToDate() == false);
      await this.fetch();
    return _stories;
  }
  static StoryModel _createStoryModel(Map data) {
    if (!data.containsKey("title") || !data.containsKey("imgPath") || !data.containsKey("description"))
      return (null);
    final String title = data["title"];
    final String imgPath = data["imgPath"];
    final String description = data["description"];
    if (title == null || title.isEmpty || imgPath == null || imgPath.isEmpty || description == null || description.isEmpty)
      return (null);
    return (StoryModel(title:title, imgPath:imgPath, description:description));
  }
}