import 'package:flutter/material.dart';

class StoryList extends StatelessWidget {
  List<StoryListItem> _list;
  double _height;
  StoryList({double height = 450}) :_height = height;
  void updateList({@required List<StoryListItem> list}) {
    _list = list;
  }
  void setHeight(double height) {
    _height = height;
  }
  Container _mapList() {
    return (Container(height: _height, child: SingleChildScrollView(child: Column(children:_list),),));
  }
  @override
  Widget build(BuildContext context) {
    if (_list == null) {
      return (Text(""));
    }
    return (_mapList());
  }
}

const TextStyle storyHeaderTextStyle = TextStyle(fontSize: 20, fontFamily: "Roboto", color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 10)]);
const TextStyle storyDescriptionTextStyle = TextStyle(fontFamily: "Roboto", color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 10)]);

class StoryListItem extends StatelessWidget {
  final String _imgPath;
  final String _title;
  final String _description;
  StoryListItem({@required String imgPath, @required String title, String description = ""}) :_imgPath = imgPath, _title = title, _description = description;
  Text _buildTitle() {
    return (Text(_title, textAlign: TextAlign.left, style: storyHeaderTextStyle, maxLines: 1, overflow: TextOverflow.fade,));
  }
  Text _buildDescription() {
    return (Text(_description, textAlign: TextAlign.right, style: storyDescriptionTextStyle, maxLines: 2, overflow: TextOverflow.fade));
  }
  Container _buildContainer({double width}) {
    DecorationImage image = DecorationImage(image:NetworkImage(_imgPath), fit: BoxFit.cover, alignment: Alignment.topCenter);
    BoxDecoration decoration =BoxDecoration(color: Colors.lightBlue[200], borderRadius: BorderRadius.all(Radius.circular(5)), image: image);
    final double sidePadding = 10;
    Container result = Container(
      decoration: decoration,
      height: 120,
      width: width,
      padding: EdgeInsets.only(bottom: 10, top: 10, left: sidePadding, right: sidePadding),
      child: Column(
        children: <Widget>[Container(width: width - sidePadding * 2, child: _buildTitle()), Container( width:width- 10, child: _buildDescription())],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      
    );
    return (result);
  }
  @override
  Widget build(BuildContext context) {
    
    Container result = _buildContainer(width:MediaQuery.of(context).size.width);
    
    return (Padding(child: result, padding: EdgeInsets.only(bottom: 8),));
  }
}