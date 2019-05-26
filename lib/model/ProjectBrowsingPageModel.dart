import 'package:flutter/material.dart';
import '../model/AModel.dart';
import '../utils/FBCollections.dart';
import '../model/ATableModel.dart';
import '../model/ApiRoutes.dart';

class ProjectDescriptionItemData {
  final String bannerPath;
  final String logoPath;
  final String description;
  final String name;
  ProjectDescriptionItemData(
      {@required String bannerPath,
      @required String logoPath,
      @required String description,
      @required String name})
      : bannerPath = bannerPath,
        logoPath = logoPath,
        description = description,
        name = name;
}

class ProjectDescriptionListModel extends ATableModel {
  ProjectDescriptionListModel()
      : super(path: ApiRoutes.getProjectQueryResult, header: {"query": ""}) {}
  List<ProjectDescriptionItemData> _list;
  Future<List<ProjectDescriptionItemData>> getList() async {
    if (!this.isUpToDate()) {
      await this.fetch();
    }
    return (this._list);
  }

  @override
  void readJSON() {
    Map<String, dynamic> json = this.requestedJSON;
    if (json == null) return;
    _list = List<ProjectDescriptionItemData>();
    var value = json["value"];
    var to_parse = null;
    ProjectDescriptionItemData toadd;
    print("before loop $value");
    for (var elem in value) {
      toadd = _createProjectDescriptionItemData(elem);
      if (toadd != null) _list.add(toadd);
    }
  }

  ProjectDescriptionItemData _createProjectDescriptionItemData(Map data) {
    if (!data.containsKey("name") ||
        !data.containsKey("bannerPath") ||
        !data.containsKey("description") ||
        !data.containsKey("logoPath"))
        return (null);
    final String title = data["name"];
    final String bannerPath = data["bannerPath"];
    final String description = data["description"];
    final String logoPath = data["logoPath"];
    print("create");
    if (title == null ||
        title.isEmpty ||
        bannerPath == null ||
        bannerPath.isEmpty ||
        logoPath == null ||
        logoPath.isEmpty ||
        description == null ||
        description.isEmpty) return (null);
    print("one okay");
    return (ProjectDescriptionItemData(
        name: title,
        bannerPath: bannerPath,
        logoPath: logoPath,
        description: description));
  }
}

class ProjectBrowsingPageModel extends AModel {
  ProjectBrowsingPageModel() : super();
  ProjectDescriptionListModel _listModel = ProjectDescriptionListModel();
  Future<List<ProjectDescriptionItemData>> getProjectList(String query) async {
    _listModel.updateHeader({"query": query});
    await _listModel.fetch();
    print("http ok");
    return (this._listModel.getList());
  }
}
