import 'package:flutter/material.dart';
import '../utils/Routes.dart';
import '../viewmodel/ProfilePageViewModel.dart';
import '../viewmodel/AViewModelFactory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission/permission.dart';
import 'dart:async';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
  static ProfilePageState of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ProfileInheritedWidget) as ProfileInheritedWidget).state;
  }
}

class ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{
  static final IRoutes      _routing = Routes();
  static final ProfilePageViewModel viewModel = AViewModelFactory.register[_routing.profilePage];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _mainKey = GlobalKey<ScaffoldState>();
  StreamSubscription _connectivitySub;
  Map<String, Key> _keyMap = Map<String, Key>();
  List<String> values = List<String>();
  List<MyItems> items = [MyItems("Projects", "body"),MyItems("Partners", "body"),MyItems("Other", "body")];
  bool isEditing = false;
  bool isBusy = false;
  File imagePickerFile;
  /////////////////////////////////////GETTERS
  String get name => viewModel.name;
  String get location => viewModel.location;
  String get workLocation => viewModel.workLocation;
  String get job => viewModel.job;
  String get studies => viewModel.studies;
  String get photoUrl => viewModel.photoUrl;
  String get backgroundUrl => viewModel.backgroundUrl;
  ////////////////////////////////////

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

  @override
  Widget build(BuildContext context) {
    return ProfileInheritedWidget(
      child: Scaffold(
        key: _mainKey,
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue[600],
          child: Container(height: 50),
        ),
        floatingActionButton: _editingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _profileHeaderWidget(),
                    SizedBox(width: 0.0, height: 10.0),
                    _profileContentWidget()
                  ],
                ),
              )
            )
        )
      ),
      state: this,
    );
  }

  Widget _editingButton(){
    return FloatingActionButton(
        onPressed: (){
          if (this.isEditing) {
            if (this._formKey.currentState.validate()) {
              this._formKey.currentState.save();
              viewModel.updateProfileInformations(this.values, this.imagePickerFile);
            }
          }
          this.setState((){
            this.isEditing = !this.isEditing;
          });
        },
        child: this.isEditing ? Icon(Icons.check, size: 35) : Icon(Icons.edit, size: 35),
        tooltip: this.isEditing ? "save changes" : "edit",
        foregroundColor: Colors.white,
        backgroundColor: this.isEditing ? Colors.green : Colors.blueAccent,
      );
  }

  Widget _profileHeaderWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _clipPathWidget(),
              _profileImageWidget(),
              this.isEditing ? this._changePhotoButton() : SizedBox(width: 0,height: 0),
              _spinner()
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileContentWidget(){
    return Container(
        decoration: BoxDecoration(
            //image: DecorationImage(image: NetworkImage(viewModel.backgroundUrl), fit: BoxFit.fill),
            gradient: LinearGradient(
                colors: [Colors.cyan[700], Colors.cyan[400], Colors.cyan[700]],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,//Alignment(0.8, 0.0),
                tileMode: TileMode.clamp
            )
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(width: 0, height: 10),
              _profileNameWidget(),
              SizedBox(width: 0, height: 10),
              _livesAtWidget(),
              _studiedAtWidget(),
              _worksAtWidget(),
              _jobWidget(),
              _profilePanelList()
            ],
          ),
        )
    );
  }

  Widget _livesAtWidget(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            )
        ),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("lives at:",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
            this.isEditing ? this._editablePresenter(this.location, "change location here", "location", this._keyMap) :
            Text(
                this.location,softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white)
            ),
          ],
        )
    );
  }

  Widget _studiedAtWidget(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            )
        ),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("studied at:",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
            this.isEditing ? this._editablePresenter(this.studies, "change studies location here", "studies", this._keyMap) :
            Text(
                this.studies,softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white)
            ),
          ],
        )
    );
  }

  Widget _worksAtWidget(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            )
        ),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("works at:",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
            this.isEditing ? this._editablePresenter(this.workLocation, "change work location here", "workLocation", this._keyMap) :
            Text(
                this.workLocation,softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white)
            ),
          ],
        )
    );
  }

  Widget _jobWidget(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            )
        ),
        //color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Work as:",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
            this.isEditing ? this._editablePresenter(this.job, "change job here", "job", this._keyMap) :
            Text(
                this.job,softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white)
            ),
          ],
        )
    );
  }

  Widget _clipPathWidget(){
    return ClipPath(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(this.backgroundUrl),
                fit: BoxFit.cover
            )
        ),

      ),
      clipper: ProfileClipper(),
    );
  }

  Future _getImage() async {
    List<Permissions> permissionNames = await Permission.requestPermissions([PermissionName.Camera, PermissionName.Storage]);
    List<Permissions> permissions = await Permission.getPermissionsStatus([PermissionName.Camera, PermissionName.Storage]);
    if (permissions[0].permissionStatus == PermissionStatus.allow && permissions[1].permissionStatus == PermissionStatus.allow){
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        this.imagePickerFile = image;
      });
    }
  }

  Widget _profileImageWidget(){
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: imagePickerFile != null ? Image.file(imagePickerFile).image : NetworkImage(this.photoUrl),
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.all(Radius.circular(75.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 7.0,
                color: Colors.black
            )
          ]
      ),
    );
  }

  Widget _editablePresenter(String label, String hint, String keyLabel, Map<String, Key> keyMap){
    Widget ret;
    Key key = Key(keyLabel);
    print("key : "+key.toString());
    ret = Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: TextFormField(
                validator: (value){
                  _formValidation(value);
                },
                onSaved: (value){
                  _onSaved(value);
                },
                key: key,
                decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    icon: Icon(Icons.edit, color: Colors.white)
                ),
              )
          ),
        ),
        FlatButton.icon(
            onPressed: null,
            icon: Icon(Icons.cancel, color: Colors.red),
            label: Text("cancel",
              style: TextStyle(
                  color: Colors.red),
            )
        )
      ],
    );
    keyMap[keyLabel] = key;
    return ret;
  }

  Widget _profileNameWidget(){
    var ret;
    if (this.isEditing) {
      ret = this._editablePresenter(this.name, "change name here", "name", this._keyMap);
    }
    else {
      ret = Text(
        this.name,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.white),
      );
    }
    return Container(
      alignment: Alignment.center,
      child: ret,
      width: MediaQuery.of(context).size.width,
      height: 70,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 2.5,
                  color: Colors.white
              )
          )
      ),
    );
  }

  Widget _profilePanelList(){
    List<MyItems> items = this.items;
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded){
        setState(() {
          items[index].isExpanded = !items[index].isExpanded;
        });
      },
      children: items.map((item){
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) => _profilePanelHeader(item.header),
            isExpanded: item.isExpanded,
            body: _profilePanelBody(item.body)
        );
      }).toList(),
    );
  }
  Widget _profilePanelHeader(String header){
    return Container(
      padding: EdgeInsets.only(bottom:20.0,left:MediaQuery.of(context).size.width / 2.5),
      alignment: Alignment.centerLeft,
      child: Text(
          header,
          textAlign: TextAlign.center,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.black,
          )
      ),
    );
  }
  Widget _profilePanelBody(String body){
    return Column(
      children: <Widget>[
        Text(body),
        Text(body),
        Text(body),
        Text(body),
        Text(body),
      ],
    );
  }

  Widget _changePhotoButton() {
    return FloatingActionButton(
      onPressed: _getImage,
      child: Icon(Icons.photo_camera, size: 35),
    );
  }

  String _formValidation(String value) {
    if (value.isEmpty)
      return ("Value can't be empty");
    return null;
  }

  void _onSaved(String value) {
    this.values.add(value);
  }

  Widget _spinner() {
    if (this.isBusy)
      return Positioned(
        child: CircularProgressIndicator(),
        top: MediaQuery.of(context).size.width / 2.2,
        left: MediaQuery.of(context).size.height / 2.2);
    return SizedBox(width: 0, height: 0);
  }

  void _connectivityHandler(bool value) {

  }
}

class ProfileInheritedWidget extends InheritedWidget {
  final ProfilePageState state;
  ProfileInheritedWidget(
      {
        this.state,
        Widget child
      }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class MyItems{
  String header;
  String body;
  bool isExpanded;
  MyItems(String h,String b){
    header = h;
    body = b;
    isExpanded = false;
  }
}

class ProfileClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    /*
    path.lineTo(0.0, size.height / 6.0);
    path.lineTo(size.width / 2, size.height / 3.0);
    path.lineTo(size.width, size.height / 6.0);
    path.lineTo(size.width, 0.0);
    */
    path.lineTo(0.0, size.height - 20.0);
    path.lineTo(10.0, size.height - 10.0);
    path.lineTo(size.width / 4, size.height - 10.0);
    path.lineTo(size.width / 3, size.height);
    path.lineTo(size.width - (size.width / 3), size.height);
    path.lineTo(size.width - (size.width / 4), size.height - 10.0);
    path.lineTo(size.width - 10.0, size.height - 10.0);
    path.lineTo(size.width, size.height - 20.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}