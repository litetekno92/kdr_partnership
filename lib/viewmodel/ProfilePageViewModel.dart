import 'dart:io';
import '../viewmodel/AViewModel.dart';
import '../model/ProfilePageModel.dart';

class ProfilePageViewModel extends AViewModel {
  ProfilePageModel                  _model;
  ProfilePageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  ProfilePageModel get model => this._model;
  //////////////////GETTERS
  String get name => this.model.name;
  String get location => this.model.location;
  String get studies => this.model.studies;
  String get workLocation => this.model.workLocation;
  String get job => this.model.job;
  String get photoUrl => this.model.photoUrl;
  String get backgroundUrl => this.model.backgroundUrl;
  //////////////////
  updateProfileInformations(List<String> data, File image){
    if (image != null)
      {
        // Upload image on storage
        // Get the URL and add it to payload
      }
  }
}