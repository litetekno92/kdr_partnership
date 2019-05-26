import '../viewmodel/AViewModel.dart';
import '../model/ProjectBrowsingPageModel.dart';
import 'package:flutter/material.dart';
import '../ui/widgets/ProjectScrollList.dart';


class ProjectBrowsingPageViewModel extends AViewModel {
  ProjectBrowsingPageModel                  _model;
  ProjectBrowsingPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  void getProjectList({@required String query, @required Function onUpdate}) async {
    print("==========test==============");
    final List<ProjectScrollListItemData> result = (await this._model.getProjectList(query))
      .map((elem) {
        return (ProjectScrollListItemData(name: elem.name, logo: elem.logoPath, banner: elem.bannerPath));
      })
      .toList();
    print("result = $result");
    onUpdate(result);
  }
  Future<dynamic>  searchTag(String value) async {
    List<dynamic> result = List<dynamic>();
    return (result);
  }
  ProjectBrowsingPageModel get model => this._model;
}