import 'package:flutter/material.dart';
import 'dart:async';
import '../ui/widgets/LabeledIconButton.dart';
import '../ui/widgets/LabeledIconButtonList.dart';
import '../ui/widgets/LargeButton.dart';
import '../utils/Routes.dart';
import '../viewmodel/AViewModelFactory.dart';
import '../viewmodel/HomePageViewModel.dart';
import '../ui/widgets/StoryList.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  StoryList     _stories = StoryList();
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  HomePageViewModel get viewModel =>
      AViewModelFactory.register[_routing.homePage];
  bool isOffline = false;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  StreamSubscription<dynamic> sub;
  //StreamSubscription<QuerySnapshot> user_sub;
  void listencb() {}
  void pausecb() {}
  void resumecb() {}
  void cancelcb() {}

  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
    viewModel.getStoryList((value) => this._updateStoryList(value));
  }
  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }
  Widget _buildDisconnectButton() {
    return (LargeButton(
      text: "Se déconnecter",
      onPressed: () => this
          .viewModel
          .changeView(route: _routing.loginPage, widgetContext: context, popStack: true),
    ));
  }
  List<Widget> _buildRightDrawerButtons(BuildContext context) {

    LabeledIconButton testButton = LabeledIconButton(
      icon: Icon(Icons.account_circle),
      toolTip: 'Accéder à mon profil',
      onPressed: () => this.viewModel.goToProfile(context),
      text: "Accéder à mon profil",
      fullWidth: true,
    );
    LabeledIconButton disconnectButton = LabeledIconButton(
      icon: Icon(Icons.power_settings_new),
      toolTip: 'Me déconnecter',
      onPressed: () => this.viewModel.disconnect(context),
      text: "Me déconnecter",
      fullWidth: true,
    );
    List<LabeledIconButton> result = new List<LabeledIconButton>();
    result.addAll([
      testButton,
      disconnectButton,
    ]);
    return (result);
  }
  Widget _buildRightDrawer(BuildContext context) {
    BoxDecoration drawerDecoration =
        new BoxDecoration();
    List<LabeledIconButton> buttons = _buildRightDrawerButtons(context);

    LabeledIconButtonList drawerContent = LabeledIconButtonList(childs: buttons, forceFullWidth: true,);
    Widget drawerContentPositioning = Padding(
      child: drawerContent,
      padding: EdgeInsets.only(top: 24.0),
    );
    
    return (Drawer(
      child: Container(
        child: drawerContentPositioning,
        decoration: drawerDecoration,
      ),
    ));
  }
  void _updateStoryList(List<StoryData> param) {
    this.setState(() {
      if (!mounted)
        return ;
      this._stories = StoryList();
      List<StoryListItem> newStories = param.map((elem) {
        return (StoryListItem(imgPath: elem.imgPath, title:elem.title, description: elem.description));
      }).toList();
      this._stories.updateList(list:newStories);
    });
  }
  Container _buildActions(BuildContext context, double height) {
    FloatingActionButton createProjectAction = FloatingActionButton(heroTag: "add", child:Icon(Icons.add), onPressed: () {this.viewModel.goToCreateProjectPage(context);}, backgroundColor: Colors.grey[700],);
    FloatingActionButton joinProjectAction = FloatingActionButton(heroTag: "join", child:Icon(Icons.file_download), onPressed: () {this.viewModel.goToBrowsingProjectPage(context);}, backgroundColor: Colors.grey[700]);
    Row actionsRow = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(child: createProjectAction, padding:EdgeInsets.symmetric(horizontal: 5)),
          Padding(child: joinProjectAction, padding: EdgeInsets.only(left: 5)),
        ],
    );
    Container actions = Container(child:actionsRow);
    return (actions);
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double paddedHeight = screenSize.height - 24;
    _stories.setHeight(paddedHeight - 14);
    Widget actions = _buildActions(context, paddedHeight / 8);
    Widget rightDrawer = _buildRightDrawer(context);
    Widget view = Scaffold(
      floatingActionButton: actions,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      endDrawer: rightDrawer,
      body: Container(
          height: screenSize.height,
          padding: EdgeInsets.only(top:24.0, bottom: 0, left: 14, right: 14),
          width: screenSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[_stories],
          )),
    );
    return (WillPopScope(onWillPop: null, child: view));
  }
  void _connectivityHandler(bool value) {

  }
}
