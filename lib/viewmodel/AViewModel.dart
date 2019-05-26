import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../viewmodel/AViewModelFactory.dart';
import '../model/AModelFactory.dart';
import '../model/AModel.dart';
import '../coordinator/AppCoordinator.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
    Abstract class defining all ViewModels, destined to be instanciated within the Coordinator by AViewModelFactory.
    Implements methods common to all ViewModels (ex: methods to ask Coordinator to change View/ViewModel).
*/
abstract class AViewModel implements AViewModelFactory
{
  final ICoordinator _coordinator = Coordinator();
  AModel            _abstractModel;
  String            _route;

  AViewModel();

  void initModel(String route){
    try {
      this._route = route;
      AModelFactory(this._route);
      if (!AModelFactory.register.containsKey(this._route) || !(AModelFactory.register[this._route] != null))
        throw Exception("Missing Model for "+this._route);
      this._abstractModel = AModelFactory.register[this._route];
    }
    catch (error){
      print(error);
    }
  }

  AModel get abstractModel => this._abstractModel;
  String get route => this._route;

  bool changeView({@required String route,@required BuildContext widgetContext, bool popStack = false}){
      return this._coordinator.fetchRegisterToNavigate(route: route, context: widgetContext, popStack: popStack);
  }
  Future<FirebaseUser> signUp({@required String email, @required String password}) {
    return this._coordinator.signUpByEmail(newEmail: email, newPassword: password);
  }
  Future<FirebaseUser> signIn({@required String email, @required String password}) {
    return this._coordinator.loginByEmail(userEmail: email, userPassword: password);
  }
  FirebaseUser loggedInUser(){
    return this._coordinator.getLoggedInUser();
  }
  AssetBundle getAssetBundle(){
    return this._coordinator.getAssetBundle();
  }
  StreamSubscription subscribeToConnectivity(Function handler){
    return this._coordinator.subscribeToConnectivity(handler);
  }
  void showConnectivityAlert(BuildContext context){
    this._coordinator.showConnectivityAlert(context);
  }
  String getInitialRoute(){
    return this._coordinator.getInitialRoute();
  }
}