import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectScrollListItemData {
  ProjectScrollListItemData({@required String name, @required String banner, @required String logo}) : name = name, banner = NetworkImage(banner), logo = NetworkImage(logo);
  String name;
  NetworkImage banner;
  NetworkImage logo;
}

class ProjectScrollListItem extends StatelessWidget {
  final String _name;
  final ImageProvider _banner;
  final ImageProvider _logo;
  final double _height;
  final double _logoSize;
  static final double _logoSidePadding = 20;
  static final double _bannerVerticalPadding = 5;
  static final double _itemVerticalPadding = 5;
  static final double _itemHorizontalPadding = 5;
  static final double _titleVerticalPadding = 10;

  ProjectScrollListItem({@required String name, ImageProvider banner, ImageProvider logo, double height = 100}) :
    _name = name,
    _banner = banner,
    _logo = logo,
    _height = height,
    _logoSize = height - 20;
  BoxDecoration _buildDecoration() {
    DecorationImage img = DecorationImage(image:_banner, fit: BoxFit.cover);
    BoxDecoration result = BoxDecoration(image: img, color:Colors.white);
    return (result);
  }
  Container _buildLogo() {
    Container result;
    BoxDecoration bd = BoxDecoration(
      image:DecorationImage(
        image: _logo,
        fit: BoxFit.fill
      ),
    );
    result = Container(decoration: bd, height: _logoSize, width: _logoSize,);
    return (result);
  }
  @override
  Widget build(BuildContext context) {
    Container logo = Container(
      child:_buildLogo(),
      padding: EdgeInsets.only(left: _logoSidePadding),
    );
    BoxDecoration decoration = _buildDecoration();
    BoxDecoration bd = BoxDecoration(color: Colors.white);
    Container banner = Container(
      child:Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[Padding(
          child: logo,
          padding: EdgeInsets.symmetric(vertical: _bannerVerticalPadding),
        )],
      ),
      decoration: decoration,
    );
    Row title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[Text(_name)],
    );
    Container titleContainer = Container(child:title, padding: EdgeInsets.symmetric(vertical: _titleVerticalPadding),);
    return (Padding(padding: EdgeInsets.all(5), child:Container(decoration: bd ,child:Column(children: [banner, titleContainer],))));
  }
}

class ProjectScrollList extends StatelessWidget {
  final List<ProjectScrollListItem> _list;
  final double _width;
  final double _height;
  static ProjectScrollList fromDataList(List<ProjectScrollListItemData> list, {double width, double height = 450}) {
    ProjectScrollList result;
    List<ProjectScrollListItem> tmpList;

    tmpList = list.map(
      (ProjectScrollListItemData value) => ProjectScrollListItem(name:value.name, banner: value.banner, logo: value.logo)
    ).toList();
    result = ProjectScrollList(list: tmpList, width: width, height: height,);
    return (result);
  }
  ProjectScrollList({@required List<ProjectScrollListItem> list, double width, double height = 450}) : _list = list, _height = height, _width = width;

  @override
  Widget build(BuildContext context) {
    SingleChildScrollView content;
    Container             result;

    content = SingleChildScrollView(child: Column(children:_list),);
    if (_width != null)
      result = Container(width: _width, height: _height, child: content,);
    else
      result = Container(height: _height, child: content);
    return (result);
  }
}