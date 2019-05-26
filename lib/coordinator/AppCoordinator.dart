import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../coordinator/RoutingModule.dart';
import '../coordinator/ConnectivityModule.dart';
import '../coordinator/AuthenticationModule.dart';
import '../coordinator/NotificationModule.dart';
import '../viewmodel/AViewModel.dart';
import '../viewmodel/AViewModelFactory.dart';
/*
    Head of the App, brings severals utility modules like Routing, internet connectivity etc...
    Responsible of ViewModels's management.
*/

abstract class ICoordinator{
  bool fetchRegisterToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = false});
  String getInitialRoute();
  Future<FirebaseUser> loginByEmail({@required String userEmail, @required String userPassword});
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword});
  StreamSubscription   subscribeToConnectivity(Function handler);
  void                 showConnectivityAlert(BuildContext context);
  FirebaseUser         getLoggedInUser();
  AssetBundle          getAssetBundle();
}

class Coordinator extends State<PartnershipApp> implements ICoordinator {
  static final Coordinator      _instance = Coordinator._internal();
  final IRouting                _router = RoutingModule();
  final IConnectivity           _connectivity = ConnectivityModule();
  final INotification           _notification = NotificationModule();
  final IAuthentication         _authentication = AuthenticationModule();
  final Map<String, AViewModel> _viewModels = AViewModelFactory.register;
  AssetBundle                   _assetBundle;
  StreamSubscription<bool>      _connectivitySub;

  Coordinator._internal(){
    _connectivity.initializeConnectivityModule();
    _notification.initializeNotificationModule();
  }

   factory Coordinator(){
      return _instance;
   }

    IAuthentication get authentication => this._authentication;
    IConnectivity   get connectivity => this._connectivity;
    INotification   get notification => this._notification;

  @override
  void initState(){
    super.initState();
    this._connectivitySub = this._connectivity.subscribeToConnectivity(this._connectivityHandler);
  }

  @override
  void dispose(){
    this._connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    MaterialApp app = MaterialApp(
      onGenerateTitle: (context) {
      return 'PartnerSHIP';
      },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: this._router.routeMap(),
      //onGenerateRoute: this._router.generator(),
      //home: LoginPage(),
      initialRoute: this._setUpInitialRoute(),
    );
    this._assetBundle = DefaultAssetBundle.of(_context);
    //this._setUpInitialRoute();
    return app;
  }

  String _setUpInitialRoute(){
    if (!this.fetchRegisterToNavigate(route: "/", context: null, navigate: false))
      return null;
    if (this.fetchRegisterToNavigate(route: this._router.initialRoute, context: null, navigate: false))
      return this._router.initialRoute;
    return null;
  }

  bool _fetchRegisterToNavigate({@required String route, @required BuildContext context, bool navigate = true, bool popStack = false}) {
    try {
      AViewModelFactory(route);
      if (!this._viewModels.containsKey(route) || !(this._viewModels[route] != null))
        throw Exception("Missing ViewModel for route \"$route\"");
      if (navigate)
        this._router.navigateTo(route: route, context: context, popStack: popStack);
      return true;
    }
    catch (error) {
      print(error);
      return false;
    }
  }

  @override
  bool fetchRegisterToNavigate({String route, BuildContext context, bool navigate = true, bool popStack = false}) {
    return this._fetchRegisterToNavigate(route: route, context: context, navigate: navigate, popStack: popStack);
  }

  @override
  Future<FirebaseUser> loginByEmail({@required String userEmail, @required String userPassword}) {
    return this._authentication.loginByEmail(userEmail: userEmail, userPassword: userPassword);
  }

  @override
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword}) {
    return this._authentication.signUpByEmail(newEmail: newEmail, newPassword: newPassword);
  }

  @override
  FirebaseUser getLoggedInUser() {
    return this.authentication.getLoggedInUser();
  }

  @override
  AssetBundle getAssetBundle() {
    return this._assetBundle;
  }

  @override
  StreamSubscription subscribeToConnectivity(Function handler) {
    return this._connectivity.subscribeToConnectivity(handler);
  }

  void _connectivityHandler(bool value) {
    // Do something involving internet connection's status
  }

  @override
  void showConnectivityAlert(BuildContext context) {
    this._connectivity.showAlert(context);
  }

  @override
  String getInitialRoute() {
    return this._router.initialRoute;
  }
}

// Main entry of the Application
class PartnershipApp extends StatefulWidget {
  @override
  State<PartnershipApp> createState() {
    return Coordinator();
  }
}