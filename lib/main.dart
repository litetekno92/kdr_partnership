import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './coordinator/AppCoordinator.dart';

void main() {
  //ApplicationSwitcherDescription description = ApplicationSwitcherDescription(label:'LOL', primaryColor: 0xff502e54);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  //SystemChrome.setApplicationSwitcherDescription(description).then((_){
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
      runApp(new PartnershipApp());
    });
  //});
}