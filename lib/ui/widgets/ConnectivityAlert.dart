import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ConnectivityAlertWidget extends StatefulWidget{
  final ConnectivityAlertWidgetState _state = ConnectivityAlertWidgetState();
  @override
  State<StatefulWidget> createState() {
    return _state;
  }
  void subscribeToConnectivity(Stream<bool> stream){
    _state.subscribeToConnectivity(stream);
  }
  void showAlert(BuildContext context){
    if (!_state._flushBar.isShowing())
      _state._flushBar.show(context);
  }
}

class ConnectivityAlertWidgetState extends State<ConnectivityAlertWidget>{
  final Flushbar _flushBar = connectivityAlertFlushBar();
  StreamSubscription connectivitySub;

  @override
  void dispose(){
    if (this.connectivitySub != null)
      connectivitySub.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _flushBar;
  }

  void subscribeToConnectivity(Stream<bool> stream){
    this.connectivitySub = stream.listen(this._connectivityHandler);
  }

  void _connectivityHandler(bool value) {
    if (value)
    {
      if (_flushBar.isShowing()
          && !_flushBar.isDismissed())
        _flushBar.dismiss();
    }
  }
}

Flushbar connectivityAlertFlushBar() {
  return Flushbar(
    title: "Internet Connection Status",
    message: "Your device is currently offline, some of Partnership's features are disabled.",
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.GROUNDED,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    // boxShadow: BoxShadow(
    //     color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0),
    backgroundGradient: LinearGradient(colors: [Colors.red, Colors.black]),
    isDismissible: true,
    icon: Icon(
      Icons.info_outline,
      color: Colors.amber,
    ),
    showProgressIndicator: false,
    progressIndicatorBackgroundColor: Colors.blueGrey,
  );
}