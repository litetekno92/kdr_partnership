import 'package:flutter/material.dart';
import '../utils/Routes.dart';
import '../viewmodel/AViewModelFactory.dart';
import '../viewmodel/LoginPageViewModel.dart';
import '../ui/widgets/RoundedGradientButton.dart';
import '../style/theme.dart';
import '../ui/widgets/ThemeContainer.dart';
import 'dart:async';
import 'dart:ui';

class ContactFields {
  String subject;
  String message;
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  BuildContext _scaffoldContext;
  IRoutes      _routing = Routes();
  StreamSubscription _connectivitySub;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ContactFields _data = ContactFields();
  LoginPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.loginPage];

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
    _scaffoldContext = context;

    final titleWidget = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff20264c).withOpacity(0.1), Colors.black.withOpacity(0.4), Color(0xff20264c).withOpacity(0.1)]),
                      //color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                )
            ),
            Text('PartnerShip',
                style: TextStyle(
                  //color: Colors.white,
                  fontFamily: 'Copperplate',
                  fontSize: 35,
                  foreground: Paint()
                    ..shader = Gradients.verticalMetallic.createShader(Rect.fromLTWH(0, 150, 250, 40))
              )
            ),
            ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.15,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff35294f).withOpacity(0.1), Colors.black.withOpacity(0.4), Color(0xff35294f).withOpacity(0.1)]),
                      //color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                )
            )
          ],
        )
      );

    final logButtonsWidget = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RoundedGradientButton(
              child: Text(
                  'CONNEXION',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Orkney',
                  ),
              ),
              callback: () => viewModel.changeView(route: _routing.signInPage, widgetContext: context),
              increaseWidthBy: 80,
              increaseHeightBy: 10
          ),
          RoundedGradientButton(
              child: Text(
                'INSCRIPTION',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Orkney',
                ),
              ),
              callback: () => viewModel.changeView(route: _routing.signUpPage, widgetContext: context),
              increaseWidthBy: 80,
              increaseHeightBy: 10
          )
        ],
      ),
    );

    final contactButtonsWidget = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
              onPressed: () {
                _openContactModal(widgetContext: context);
              },
              child: Text(
                'CONTACTEZ-NOUS',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Orkney',
                ),
              )
          ),
          Container(child: null, width: 10, height: 3, color: Colors.white),
          FlatButton(
              onPressed: () => viewModel.showPartnershipInfoWebSite(),
              child: Text(
                'MAIS C\'EST QUOI PARTNERSHIP ?',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Orkney',
                ),
              )
          )
        ],
      ),
    );

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            top: false,
            child: ThemeContainer(context, Column(
              children: <Widget>[
                Padding(
                  child: Image.asset('assets/img/logo_partnership.png', width:50, height: 50),
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                ),
                titleWidget,
                Padding(
                    child: logButtonsWidget,
                    padding: EdgeInsets.only(top: 50, bottom: 30)
                ),
                contactButtonsWidget
              ],
            ))
        )
    );
  }

  void _openContactModal({@required BuildContext widgetContext}){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(
          "Votre Message:",
          style: TextStyle(fontFamily: 'Orkney'),
        ),
        content: SingleChildScrollView(
            child: Container(
              child: Form(
                  key: this._formKey,
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   TextFormField(
                      maxLines: 1,
                      maxLength: 30,
                      validator: (value) {
                       if (value.isEmpty) {
                         return ('Veuillez renseigner le sujet de votre message');
                       }
                      },
                      onSaved: (value) => this._data.subject = value,
                      decoration: InputDecoration(
                        labelText: "Sujet",
                        hintText: "le sujet de votre message...",
                        labelStyle: TextStyle(fontFamily: "Orkney"),
                        hintStyle: TextStyle(fontFamily: "Orkney")
                      ),
                    ),
                    TextFormField(
                      maxLines: 10,
                      maxLength: 300,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ('Veuillez renseigner votre message');
                        }
                      },
                      onSaved: (value) => this._data.message = value,
                      decoration: InputDecoration(
                        labelText: "Message",
                        hintText: "écrivez-nous içi...",
                        labelStyle: TextStyle(fontFamily: "Orkney"),
                        hintStyle: TextStyle(fontFamily: "Orkney")
                      ),
                    )
                  ],
                )
              ),
            )
        ),
        actions: <Widget>[
          FlatButton(
              child: Text(
                "Annuler",
                style: TextStyle(fontFamily: 'Orkney')
              ),
              onPressed: () => Navigator.of(context).pop()
          ),
          FlatButton(
              child: Text(
                "Envoyer",
                style: TextStyle(fontFamily: 'Orkney')
              ),
              onPressed: () {
                if (this._formKey.currentState.validate()) {
                  this._formKey.currentState.save();
                  viewModel.contactUsByInAppMail(subject: _data.subject, message: _data.message).then((_) {
                    Navigator.of(context).pop();
                  });
                }
              }
          )
        ],
      );
    });
  }

  void _connectivityHandler(bool value) async {
    if (!value){
      viewModel.showConnectivityAlert(context);
    }
  }
}
