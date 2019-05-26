import 'dart:io';
import 'package:flutter/material.dart';
import '../model/AModel.dart';
import '../utils/FBCollections.dart';

class ProfilePageModel extends AModel {
  ProfilePageModel(): super();
  String _name = 'Tom Cruise';
  String _location = 'New-York';
  String _studies = 'Harvard';
  String _workLocation = 'Holywood Entertainment';
  String _job = "famous comedian";
  String _photoUrl = 'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg';
  String _backgroundUrl = 'https://firebasestorage.googleapis.com/v0/b/partnership-app-e8d99.appspot.com/o/bubble_texture.jpg?alt=media&token=b4997ecc-dd26-418a-b0a1-20881216995c';
  //////////////////GETTERS
  String get name => this._name;
  String get location => this._location;
  String get studies => this._studies;
  String get workLocation => this._workLocation;
  String get job => this._job;
  String get photoUrl => this._photoUrl;
  String get backgroundUrl => this._backgroundUrl;
  ///////////////////
/*
  /////////////////SETTERS
  set setName(String data) => this._name = data;
  set setLocation(String data) => this._location = data;
  set setStudies(String data) => this._studies = data;
  set setWorkLocation(String data) => this._workLocation = data;
  set setJob(String data) => this._job = data;
  set setImageFile(File data) => this._imagePickerFile = data;
  set setPhotoUrl(NetworkImage data) => this._photoUrl = data;
  //set setBackground(AssetImage data) => this.background = data;
//////////////////
*/
}
