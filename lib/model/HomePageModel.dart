import 'dart:async';

import 'package:flutter/material.dart';
import '../model/AModel.dart';
import '../model/StoriesModel.dart';
import '../utils/FBCollections.dart';

class StoryDataModel {
  final String img_path;
  final String title;
  final String description;
  StoryDataModel({@required String img_path, @required String title, @required String description}) :
    img_path = img_path,
    title = title,
    description = description;
}

class HomePageModel extends AModel {
  HomePageModel(): super();
  StoriesModel _stories = StoriesModel(
    useruid:"FALSE UID"
  );
  List<StoryDataModel> _debugMockupList() {
    List<StoryDataModel> result = List<StoryDataModel>();
    result.add(StoryDataModel(img_path: "assets/img/login_logo.png", title: "Titre1", description: "description1",));
    result.add(StoryDataModel(img_path: "assets/img/logo_partnership.png", title: "Titre2", description: "description2 description2 description2 description2 description2 description2 description2 description2 description2",));
    result.add(StoryDataModel(img_path: "assets/blue_texture.jpg", title: "Titre3 Titre3 Titre3 Titre3 Titre3 Titre3", description: "description3",));
    result.add(StoryDataModel(img_path: "", title: "Titre4", description: "description4",));
    result.add(StoryDataModel(img_path: "", title: "Titre5", description: "description5",));
    result.add(StoryDataModel(img_path: "", title: "Titre6", description: "description6",));
    result.add(StoryDataModel(img_path: "", title: "Titre7", description: "description7",));
    result.add(StoryDataModel(img_path: "", title: "Titre8", description: "description8",));
    return (result);
  }
  Future<List<StoryDataModel>> getStories() async {
    List<StoryDataModel> result;
    await this._stories.fetch();
    List<StoryModel> value = await this._stories.getStories();
    result = value.map((item) => (StoryDataModel(description: item.description, title: item.title, img_path: item.imgPath))).toList();
    return (result);
  }
}