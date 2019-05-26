import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthentication {
  Future<FirebaseUser> loginByEmail({@required String userEmail, @required String userPassword});
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword});
  FirebaseUser         getLoggedInUser();
}

class AuthenticationModule implements IAuthentication {
  static final AuthenticationModule _instance = AuthenticationModule._internal();
  final FirebaseAuth  _auth = FirebaseAuth.instance;
  FirebaseUser        _loggedInUser;

  factory AuthenticationModule(){
      return _instance;
  }
  AuthenticationModule._internal();

  //Email Authentification
  Future<FirebaseUser> _loginByEmail({@required String userEmail, @required String userPassword}) async {
    try {
      assert(userEmail != null && userEmail.isNotEmpty, "userMail must be a valid Email");
      assert(userPassword != null && userPassword.isNotEmpty, "userPassword must be a valid Password");
      final FirebaseUser user = await this._auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      final FirebaseUser currentUser = await this._auth.currentUser();
      assert(user != null, "FirebaseUser is null");
      assert(await user.getIdToken() != null, "FirebaseUser.getIdToken() returned null");
      assert(user.uid == currentUser.uid, "Mismatch between FirebaseUser.uid and currentUser.uid");
      this._loggedInUser = currentUser;
      return this._loggedInUser;
    }
    catch (error){
      print(error);
      return null;
    }
  }

  // Email SignUp
  Future<FirebaseUser> _signUpByEmail({@required String newEmail, @required String newPassword}) async {
    try{
      assert(newEmail != null && newEmail.isNotEmpty, "newEmail must be a valid Email");
      assert(newPassword != null && newPassword.isNotEmpty, "newPassword must be a valid Password");
      final FirebaseUser user = await this._auth.createUserWithEmailAndPassword(email: newEmail, password: newPassword);
      final FirebaseUser currentUser = await this._auth.currentUser();
      assert(user != null, "FirebaseUser is null");
      assert(await user.getIdToken() != null, "FirebaseUser.getIdToken() returned null");
      assert(user.uid == currentUser.uid, "Mismatch between FirebaseUser.uid and currentUser.uid");
      this._loggedInUser = currentUser;
      return this._loggedInUser;
    }
    catch(error){
      print(error);
      return null;
    }
  }

  @override
  Future<FirebaseUser> loginByEmail({@required String userEmail, @required String userPassword}) {
    return this._loginByEmail(userEmail: userEmail, userPassword: userPassword);
  }

  @override
  Future<FirebaseUser> signUpByEmail({@required String newEmail, @required String newPassword}) {
    return this._signUpByEmail(newEmail: newEmail, newPassword: newPassword);
  }

  @override
  FirebaseUser getLoggedInUser() {
    return this._loggedInUser;
  }
}
