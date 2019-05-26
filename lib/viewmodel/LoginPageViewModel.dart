import '../viewmodel/AViewModel.dart';
import '../model/LoginPageModel.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class LoginPageViewModel extends AViewModel {
  LoginPageModel                  _model;
  LoginPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  LoginPageModel get model => this._model;

  Future contactUsByInAppMail({@required String subject, @required String message}) async {
    try {
      final String scheme = 'mailto:' + 'contact.partnershipapp@gmail.com' + '?' + 'subject=' + subject + '&' + 'body=' + message;
      if (await canLaunch(scheme))
        await launch(scheme);
      else
        throw 'Could not launch $scheme';
    }
    catch (error) {
      print(error);
    }
  }

  Future showPartnershipInfoWebSite() async {
    try {
      final String scheme = 'http://partnership.ovh/';
      if (await canLaunch(scheme))
        await launch(scheme);
      else
        throw 'Could not launch $scheme';
    }
    catch (error) {
      print(error);
    }
  }

}