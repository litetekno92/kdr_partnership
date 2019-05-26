import 'package:flutter/material.dart';
import '../utils/Routes.dart';
import '../viewmodel/AViewModelFactory.dart';
import '../viewmodel/ProjectDescriptionPageViewModel.dart';
import 'dart:async';

final String lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class ProjectDescriptionPage extends StatefulWidget {
  @override
  _ProjectDescriptionPageState createState() => _ProjectDescriptionPageState();
}

class _ProjectDescriptionPageState extends State<ProjectDescriptionPage> {
  bool busy = false;
  IRoutes _routing = Routes();
  StreamSubscription _connectivitySub;
  ProjectDescriptionPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.projectDescriptionPage];

  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  Row _buildBanner(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Row result;
    Image img = Image.asset(
            'assets/img/logo_partnership.png',
            height: 150,
            width: width,

          );
    Image banner =Image.asset('assets/blue_texture.jpg');
    BoxDecoration bd =BoxDecoration(color: Colors.red, image:DecorationImage(fit: BoxFit.fill,image:AssetImage("assets/blue_texture.jpg")));
    result = Row(children: <Widget>[Container(decoration: bd, child:img, height: 180)], mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
    return (result);
  }
  Row _buildTitle () {
    Text title = Text("Titre Projet", style: TextStyle(color:Colors.blueGrey, fontFamily: "Roboto", fontSize: 30),);
    Row result =Row(children: <Widget>[title], mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
    return (result);
  }
  Row _buildDescription (BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final double paddingvalue = 5;
    Text text =Text(lorem);
    Padding padding =Padding(child: Container(child:text, width: width - paddingvalue * 2,), padding: EdgeInsets.all(paddingvalue),);
    Row result = Row(children: <Widget>[Column(children: <Widget>[padding],mainAxisSize: MainAxisSize.max,)], mainAxisSize: MainAxisSize.max,);
    return (result);
  }
  @override
  Widget build(BuildContext context) {
    Row bannerRow;
    Row titleRow;
    Row descriptionRow;

    bannerRow = _buildBanner(context);
    titleRow =_buildTitle();
    descriptionRow = _buildDescription(context);
    Column column = Column( 
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[bannerRow, Padding(child:titleRow, padding: EdgeInsets.only(top: 10)), descriptionRow],
    );
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(child:Container(child: column,), padding: EdgeInsets.only(top:24),));
  }

  void _connectivityHandler(bool value) {

  }
}
