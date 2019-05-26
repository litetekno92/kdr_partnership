import '../viewmodel/AViewModel.dart';
import '../model/CreationPageModel.dart';
import '../utils/Routes.dart';
import 'package:flutter/material.dart';

class CreationPageViewModel extends AViewModel {
  CreationPageModel                 _model;
  CreationPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  String name = 'Tom Cruise';
  String location = 'New-York';
  String studies = 'Harvard';
  String workLocation = 'Holywood Entertainment';
  String job = "famous comedian";
  NetworkImage    image = NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg');
  AssetImage      background = AssetImage('assets/blue_texture.jpg');
  void changeName(String _name){
    name = _name;
  }
  CreationPageModel get model => this._model;
}