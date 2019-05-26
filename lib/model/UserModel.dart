import 'package:partnership/model/AModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:partnership/utils/FBCollections.dart';
import 'package:partnership/model/ATableModel.dart';
import 'package:partnership/model/ApiRoutes.dart';

class UserModel extends ATableModel {
  UserModel() :
    super(path: ApiRoutes.helloWorld, header: {
      "token":"token"
    });
  @override
  readJSON() {
    
  }
}