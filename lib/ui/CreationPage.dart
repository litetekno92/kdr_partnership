import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/Routes.dart';
import '../viewmodel/CreationPageViewModel.dart';
import '../viewmodel/AViewModelFactory.dart';
import 'package:image_picker/image_picker.dart';

class CreationPage extends StatefulWidget {
    @override
    CreationPageState createState() => CreationPageState();
}

class CreationPageState extends State<CreationPage> {
  IRoutes _routing = Routes();

  CreationPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.creationPage];

  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    setState(() {
      _image = image;
    });
  }

  bool _validateName = false;
  bool _validateDesc = false;
  final _nameProject = TextEditingController(text: "Nom du projet");
  final _descriptionProject = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _nameProject.dispose();
    _descriptionProject.dispose();
    super.dispose();
  }

  bool isEditing = false;
  String get name => viewModel.name;
  String get location => viewModel.location;
  NetworkImage get image => viewModel.image;
  AssetImage get background => viewModel.background;

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CreationProjectInheritedWidget(
      child: Scaffold(
          floatingActionButton: _editingButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _creationProjectHeaderWidget(),
                    SizedBox(width: 0.0, height: 10.0),
                    _creationProjectContentWidget()
                  ],
                ),
              )
          )
      ),
      state: this,
    );
  }

  Widget _editingButton(){
    var ret;
    if (this.isEditing){
      ret = FloatingActionButton(
        onPressed: () => this.setState((){
          this.isEditing = !this.isEditing;
         if((_nameProject.text.isEmpty ? _validateName = true : _validateName = false) ||
             (_descriptionProject.text.isEmpty ? _validateDesc = true : _validateDesc = false))
           this.isEditing = !this.isEditing;
        }),
        child: Icon(Icons.check, size: 35),
        tooltip: "Sauvegarder",
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      );
    }
    else {
      ret = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        FloatingActionButton(
        onPressed: () => this.setState((){
          this.isEditing = !this.isEditing;
        }),
        child: Icon(Icons.edit, size: 35),
        tooltip: "Editer",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      FloatingActionButton(
        onPressed: () => this.setState((){
        }),
        child: Icon(Icons.add, size: 35),
        tooltip: "Créer le projet",
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      )]
      );
    }
    return ret;
  }

  Widget _creationProjectHeaderWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _clipPathWidget(),
              _creationProjectImageWidget(),
              this.isEditing ? this._changePhotoButton() : SizedBox(width: 0,height: 0)
            ],
          ),
        ),
      ],
    );
  }

  Widget _creationProjectContentWidget(){
    return Container(
        decoration: BoxDecoration(
            color: Colors.green,
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
              _creationProjectNameWidget(),
              SizedBox(width: 0, height: 10),
              _descriptionAtWidget(),
            ],
          ),
        )
    );
  }

  Widget _descriptionAtWidget(){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Description :",
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
            this.isEditing ? this._editablePresenterDescriptionProject("Qui êtes-vous, que proposez-vous ...", "Changer votre description ici") :
            Text(
                _descriptionProject.text,
                softWrap: false,
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
                image: AssetImage('assets/blue_texture.jpg'),
                fit: BoxFit.cover
            )
        ),
      ),
      clipper: ProfileClipper(),
    );
  }

  Widget _creationProjectImageWidget() {
    if (_image == null) {
      return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: image,
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
    else {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                image: FileImage(_image),
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
  }

  Widget _editablePresenterNameProject(String label, String hint){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: label,
                    errorText: _validateName ? "Ce champ ne peut être vide" : null,
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    icon: Icon(Icons.edit, color: Colors.white)
                ),
                controller: _nameProject,
              )
          ),
        ),
      ],
    );
  }

  Widget _editablePresenterDescriptionProject(String label, String hint){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: TextField(
                controller: _descriptionProject,
                decoration: InputDecoration(
                    labelText: label,
                    errorText: _validateDesc ? "Ce champ ne peut être vide" : null,
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    icon: Icon(Icons.edit, color: Colors.white)
                ),
                maxLines: 5,
              )
          ),
        ),
      ],
    );
  }

  Widget _creationProjectNameWidget(){
    var ret;
    if (this.isEditing) {
      ret = this._editablePresenterNameProject("Nom du projet", "Changer le nom du projet");
    }
    else {
      ret = Text(
        _nameProject.text,
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

  Widget _changePhotoButton() {
    return FloatingActionButton(
      onPressed: _getImage,
      child: Icon(Icons.photo_camera, size: 35),
    );
  }
}

class CreationProjectInheritedWidget extends InheritedWidget {
  final CreationPageState state;
  CreationProjectInheritedWidget(
      {
        this.state,
        Widget child
      }) : super(child: child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
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

