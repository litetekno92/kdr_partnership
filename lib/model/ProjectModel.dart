import 'package:flutter/material.dart';
import '../model/AModel.dart';
import '../model/UserPageModel.dart';
import '../utils/FBCollections.dart';

class ProjectModel extends AModel {
  UserPageModel _userModel;
  ProjectModel(): super();
  
  void setUserModel({@required UserPageModel model}) {
    this._userModel = model;
  }
  void createProject({@required String name, @required Function onResult}) async {
    onResult(false, "Impossible de créer le projet $name pour le moment");
  }
}
