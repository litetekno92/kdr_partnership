import 'package:flutter/material.dart';
import '../utils/Routes.dart';
import '../viewmodel/AViewModelFactory.dart';
import '../viewmodel/SignInPageViewModel.dart';
import '../ui/widgets/ThemeContainer.dart';
import '../ui/widgets/RoundedGradientButton.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'dart:async';
import 'dart:ui';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _mainKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInData           _data = SignInData();
  bool                        busy = false;
  bool                       _switch = false;
  StreamSubscription _connectivitySub;
  FocusNode _focusNode = FocusNode();
  MainAxisAlignment _formAlignment = MainAxisAlignment.center;
  IRoutes _routing = Routes();
  SignInPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.signInPage];

  void  displaySuccessSnackBar()
    {
      var snackbar = SnackBar(content: Text("SignIn successful!"), duration: Duration(milliseconds: 5000));
                  this._mainKey.currentState.showSnackBar(snackbar);
    }
  @override
  void initState(){
    super.initState();
    this._connectivitySub = viewModel.subscribeToConnectivity(this._connectivityHandler);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        //_controller.forward();
        setState(() {
          _formAlignment = MainAxisAlignment.start;
        });
      } else {
        //_controller.reverse();
        setState(() {
          _formAlignment = MainAxisAlignment.center;
        });
      }
    });
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
/*
    final Size screenSize = MediaQuery.of(context).size;
    final topBar = AppBar(
      backgroundColor: Colors.lightBlueAccent.shade100,
      title: Text('Connectez vous'),
      centerTitle: true,
    );
    final signInButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: Text('Je me connecte', style: TextStyle(color: Colors.white)),
          onPressed: () {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            if (_formKey.currentState.validate()) {
              this._formKey.currentState.save();
              setState(() {
                busy = true;
              });
              this.viewModel.signInAction(this._data).then((value){
                if (value) {
                  print("coucou !");
                  this.viewModel.afterSignIn(context);
                }
                setState(() {
                  busy = false;
                });
              });
            }
          },
        ),
      ),
    );
    final formContainer = Container(
        padding: EdgeInsets.all(20.0),
        width: screenSize.width,
        child: Form(
          key: this._formKey,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/img/logo_partnership.png',
                height: 50,
              ),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('Veuillez saisir une adresse email valide');
                    }
                    bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                    if (!emailValid) {
                      return ('Email invalide');
                    }
                  },
                  onSaved: (value) => this._data.email = value,
                  keyboardType: TextInputType
                      .emailAddress, // Use email input type for emails.
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hintText: 'Une adresse email valide',
                  )),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('Veuillez saisir un mot de passe');
                    }
                    //TODO regex pour le mdp

                    /*bool emailValid =
                        RegExp('r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+"')
                            .hasMatch(value);
                    if (!emailValid) {
                      return ('Mot de passe invalide');
                    }*/
                  },
                  onSaved: (value) => this._data.password = value,
                  obscureText: true, // Use secure text for passwords.
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.grey,
                    ),
                    hintText: 'Mot de passe',
                  )),
              Container(
                width: screenSize.width,
                child: signInButton,
              )
            ],
          ),
        ));
    final bottomContainer = Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              '-  Ou connecte toi avec  -',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Icon(FontAwesomeIcons.facebookF),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Icon(FontAwesomeIcons.google),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
*/
    final loginSwitcher = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: FlatButton(
                onPressed: () => setState(() => _switch = !_switch),
                child: AutoSizeText(
                  'Email',
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      color: _switch ? Colors.grey : Colors.white,
                      fontFamily: 'Orkney',
                      fontSize: 15
                  ),
                ),
            ),
          ),
          ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height / 8,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              )
          ),
          Expanded(
            child: FlatButton(
              onPressed: () => setState(() => _switch = !_switch),
              child: AutoSizeText(
                'Réseaux Sociaux',
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    color: _switch ? Colors.white : Colors.grey,
                    fontFamily: 'Orkney',
                    fontSize: 15
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final formContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      //color: Colors.blue,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: _formAlignment,
          children: <Widget>[
            Padding(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                maxLength: 30,
                //focusNode: _focusNode,
                validator: (String value){
                  if (value.isEmpty) {
                    return ('Veuillez saisir une adresse email valide');
                  }
                  bool emailValid =
                  RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return ('Email invalide');
                  }
                },
                onSaved: (value) => this._data.email = value,
                decoration: InputDecoration(
                  hintText: 'Adresse email valide',
                  labelStyle: TextStyle(fontFamily: "Orkney"),
                  hintStyle: TextStyle(fontFamily: "Orkney"),
                  icon: Padding(
                    child: Icon(Icons.mail, size: 30, color: Colors.white),
                    padding: EdgeInsets.only(top: 25)
                  )
                )
              ),
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 5,
                right: MediaQuery.of(context).size.width / 5
              )
            ),
            Padding(
              child: TextFormField(
                maxLines: 1,
                maxLength: 30,
                obscureText: true,
                focusNode: _focusNode,
                validator: (String value){
                  if (value.isEmpty) {
                    return ('Veuillez saisir un mot de passe');
                  }
                },
                onSaved: (value) => this._data.password = value,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  icon: Padding(
                    child: Icon(Icons.vpn_key, size: 30, color: Colors.white),
                    padding: EdgeInsets.only(top: 25)
                  )
                ),
              ),
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 5,
                    right: MediaQuery.of(context).size.width / 5
                )
            ),
            Padding(
              child: RoundedGradientButton(
                child: AutoSizeText(
                  'CONNEXION',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Orkney'
                  ),
                ),
                callback: () {
                  if (_formKey.currentState.validate()) {
                    this._formKey.currentState.save();
                    setState(() {
                      busy = true;
                    });
                    this.viewModel.signInAction(this._data).then((value){
                      if (value) {
                        print("coucou !");
                        this.viewModel.afterSignIn(context);
                      }
                      setState(() {
                        busy = false;
                      });
                    });
                  }
                },
                increaseWidthBy: 80,
                increaseHeightBy: 10
              ),
              padding: EdgeInsets.only(top: 40),
            ),
            //SizedBox(height: _animation.value)
          ],
        ),
      ),
    );

    final providersContainer = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
//      color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Center(child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              )
          )),
          Center(child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.height / 3,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
              )
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_google.png', width: 60, height: 60),
                    onPressed: null,
                  ),
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_fb.png', width: 60, height: 60),
                    onPressed: null,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_insta.png', width: 60, height: 60),
                    onPressed: null,
                  ),
                  MaterialButton(
                    child: Image.asset('assets/img/login_provider_twitter.png', width: 60, height: 60),
                    onPressed: null,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          splashColor: Colors.transparent,
          child: SafeArea(
              top: false,
              child: ThemeContainer(context, Column(
                children: <Widget>[
                  Padding(
                    child: Image.asset('assets/img/partnership_logo.png', width:110, height: 110),
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                  ),
                  AutoSizeText(
                    'Connexion',
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Orkney'
                    ),
                  ),
                  loginSwitcher,
                  Padding(
                    child: _switch ? providersContainer : formContainer,
                    padding: EdgeInsets.only(top: 10),
                  )
                ],
              ))
          )
        )
    );
  }
  void _connectivityHandler(bool value) {

  }
}

