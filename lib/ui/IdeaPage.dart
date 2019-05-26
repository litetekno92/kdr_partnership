import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/Routes.dart';
import '../viewmodel/IdeaPageViewModel.dart';
import '../viewmodel/AViewModelFactory.dart';
import 'package:image_picker/image_picker.dart';

class IdeaPage extends StatefulWidget {
  @override
  IdeaPageState createState() => IdeaPageState();
}

class IdeaPageState extends State<IdeaPage> {
  IRoutes _routing = Routes();

 IdeaPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.ideaPage];

  File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 250, maxWidth: 250);
    setState(() {
      _image = image;
    });
  }

  bool _validateName = false;
  bool _validateDesc = false;
  final _nameIdea = TextEditingController();
  final _descriptionIdea = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _nameIdea.dispose();
    _descriptionIdea.dispose();
    super.dispose();
  }

  NetworkImage get image => viewModel.image;
  AssetImage get background => viewModel.background;

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _ideaPageHeaderWidget(),
                  SizedBox(width: 0.0, height: 10.0),
                  _ideaPageContentWidget()
                ],
              ),
            )
        )
    );
  }

  Widget _ideaPageHeaderWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _clipPathWidget(),
              _ideaPageImageWidget(),
              _changePhotoButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ideaPageContentWidget() {
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
              Text('Nom de l\'idée',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white),
              ),
              _ideaPageNameWidget(),
              SizedBox(width: 0, height: 10),
              Text('Description:',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white),
              ),
              _descriptionAtWidget(),
            ],
          ),
        )
    );
  }

  Widget _ideaPageImageWidget() {
    if (_image == null) {
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: image,
                //fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: FileImage(_image),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
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

  Widget _ideaPageNameWidget(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: TextField(
                controller: _nameIdea,
                decoration: InputDecoration(
                    errorText: _validateName ? "Ce champ ne peut être vide" : null,
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    icon: Icon(Icons.edit, color: Colors.white)
                ),
                maxLines: 1,
              )
          ),
        ),
      ],
    );
  }


  Widget _descriptionAtWidget(){
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: TextField(
                controller: _descriptionIdea,
                decoration: InputDecoration(
                    errorText: _validateDesc ? "Ce champ ne peut être vide" : null,
                    labelStyle: TextStyle(
                        color: Colors.white
                    ),
                    icon: Icon(Icons.edit, color: Colors.white)
                ),
                maxLines: 3,
              )
          ),
        ),
      ],
    );
  }

  Widget _changePhotoButton() {
    return FloatingActionButton(
      onPressed: _getImage,
      child: Icon(Icons.photo_camera, size: 35),
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
    );
  }
}