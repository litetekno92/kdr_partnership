import '../viewmodel/AViewModel.dart';
import '../model/SignInPageModel.dart';
import 'package:flutter/material.dart';

class SignInPageViewModel extends AViewModel {
  SignInPageModel                 _model;
  SignInPageModel get model => this._model;

  SignInPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  Future<bool> signInAction(SignInData inputs){
    Future<bool> ret = this.signIn(email: inputs.email, password: inputs.password).then((result){
      if (result != null)
        return true;
      else
        return false;
    });
    return ret;
  }
  void afterSignIn(BuildContext context) {
    print("after signin $context");
    this.changeView(
      route:"/home_page",
      widgetContext: context,
      popStack: true
    );
  }
}

class SignInData {
  String email = '';
  String password = '';
}