import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import '../ui/widgets/ConnectivityAlert.dart';

/*
    Coordinator's module used by ViewModels to check for internet connection availability.
    usage : Subscribe to the stream exposed by "connectionChangeController"
*/
abstract class IConnectivity {
  StreamSubscription subscribeToConnectivity(Function handler);
  Stream<bool>  connectionChangeStream();
  void    initializeConnectivityModule();
  void    showAlert(BuildContext context);
}

class ConnectivityModule implements IConnectivity {
  static final ConnectivityModule  _instance = ConnectivityModule._internal();
  static final ConnectivityAlertWidget _connectivityAlertWidget = ConnectivityAlertWidget();
  factory ConnectivityModule() {
    return  _instance;
  }
  ConnectivityModule._internal();

  bool _hasConnection;
  final StreamController<bool> connectionChangeController = new StreamController<bool>.broadcast();
  final Connectivity _connectivity = Connectivity();

  void _initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    _connectivityAlertWidget.subscribeToConnectivity(connectionChangeController.stream);
    checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = _hasConnection;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _hasConnection = true;
      } else {
        _hasConnection = false;
      }
    } on SocketException catch(_) {
      _hasConnection = false;
    }
    //The connection status changed send out an update to all listeners
    if (previousConnection != _hasConnection) {
      connectionChangeController.add(_hasConnection);
    }
    return _hasConnection;
  }

  @override
  Stream<bool> connectionChangeStream() {
    return connectionChangeController.stream;
  }

  @override
  void initializeConnectivityModule() {
    this._initialize();
  }

  @override
  StreamSubscription subscribeToConnectivity(Function handler) {
    return connectionChangeController.stream.listen(handler);
  }

  @override
  void showAlert(BuildContext context) {
    _connectivityAlertWidget.showAlert(context);
  }
}