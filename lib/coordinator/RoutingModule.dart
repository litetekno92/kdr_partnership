import 'package:flutter/material.dart';
import '../utils/Routes.dart';
/*
*   RoutingModule:
*     Singleton, responsible for routing in the Application and accessible from the Coordinator.
*/
abstract class IRouting {
  void navigateTo({@required String route, @required BuildContext context, bool popStack = false});
  dynamic  routeMap();
  String get initialRoute;
}

class RoutingModule implements IRouting {
  static final RoutingModule _instance = RoutingModule._internal();
  factory RoutingModule() {
    return _instance;
  }
  RoutingModule._internal();
  IRoutes _routes = Routes();
  void _navigateTo({@required String route, @required BuildContext context, bool popStack = false}) {
    try {
      if (!this._routes.routeList().contains(route))
        throw Exception("Routing error: trying to reach an unknown route: "+route);
      if (popStack)
        Navigator.pushNamedAndRemoveUntil(context, route, ModalRoute.withName(_routes.loginPage));
      else
        Navigator.pushNamed(context, route);
    }
    catch(error){
      rethrow;
    }
  }

  @override
  void navigateTo({String route, BuildContext context, bool popStack = false}) {
    this._navigateTo(route: route, context: context, popStack: popStack);
  }

  @override
  dynamic routeMap() {
    return this._routes.routeMap();
  }

  @override
  String get initialRoute => this._routes.loginPage;
}
