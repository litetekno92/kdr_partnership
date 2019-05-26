import '../viewmodel/AViewModel.dart';
import '../model/IdeaPageModel.dart';
import '../utils/Routes.dart';
import 'package:flutter/material.dart';

class IdeaPageViewModel extends AViewModel {
  IdeaPageModel                 _model;
  IdeaPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  NetworkImage    image = NetworkImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg');
  AssetImage      background = AssetImage('assets/blue_texture.jpg');

  IdeaPageModel get model => this._model;
}