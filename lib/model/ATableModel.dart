import 'dart:async';

import 'package:flutter/material.dart';
import '../model/AModel.dart';
import '../model/AREST.dart';
import 'dart:convert';

abstract class ATableModel implements AModel {
  bool _upToDate = false;
  bool _working = false;
  final int _updateDuration;
  final String _path;
  Map requestedJSON;
  Map<String, String> _header;
  ATableModel({int updateDurationInSeconds = 10, @required String path, @required header}) :
    _updateDuration = updateDurationInSeconds,
    _header = header,
    _path = path;
  void updateHeader(Map<String, String> newHeader) {
    _header = newHeader;
  }
  void _handleDisupdating() async{
    Duration waitingTime = Duration(seconds: _updateDuration);
    await Future.delayed(waitingTime);
    this._upToDate = false;
  }
  Future<bool> waitForWorkDone() async {
    while (_working) {
      await Future.delayed(Duration(seconds: 1));
    }
    return (true);
  }
  bool isUpToDate() {
    return (_upToDate);
  }
  Future<void> _getJSON() async {
    _working = true;
    requestedJSON = null;
    await AREST.httpsGetRequest(
      path: _path,
      header: _header,
      onError: (onErrorResult) {
        this._upToDate = false;
        _working = false;
      },
      onSuccess: (onSuccessResult) {
        this._upToDate = true;
        Map returnedJSON = jsonDecode(onSuccessResult);
        if (returnedJSON.keys.contains("error") || returnedJSON.keys.contains("Error"))
          this._upToDate = false;
        else {
          requestedJSON = returnedJSON; 
          readJSON();
          _handleDisupdating();
        }
        _working = false;
      }
    );
  }
  void readJSON();
  Future<void> fetch() async {
    if (_upToDate == true)
      return ;
    await _getJSON();
  }
}
