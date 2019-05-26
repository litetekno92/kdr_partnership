import '../model/AModel.dart';
import '../model/LoginPageModel.dart';
import '../model/ProjectModel.dart';
import '../model/SignInPageModel.dart';
import '../model/SignUpPageModel.dart';
import '../model/ProfilePageModel.dart';
import '../model/CreationPageModel.dart';
import '../model/IdeaPageModel.dart';
import '../model/ProjectBrowsingPageModel.dart';
import '../utils/Routes.dart';

abstract class AModelFactory{
  static final Map<String, AModel> register = <String, AModel>{};

  static RoutesEnum fetchRoutes(String route, IRoutes routing){
    RoutesEnum target;
    routing.routeList().forEach((value){
      if (value == route){
        target = routing.routeEnumMap()[value];
        return target;
      }
    });
    return target;
  }

  factory AModelFactory(String route){
    if (register.containsKey(route))
      return register[route];
    else {
      AModel model;
      IRoutes _routing = Routes();
      RoutesEnum targetedRoute = fetchRoutes(route, _routing);
      switch (targetedRoute){
        case RoutesEnum.loginPage:
          model = LoginPageModel();
          register[_routing.loginPage] = model;
          break;
        case RoutesEnum.signInPage:
          model = SignInPageModel();
          register[_routing.signInPage] = model;
          break;
        case RoutesEnum.signUpPage:
          model = SignUpPageModel();
          register[_routing.signUpPage] = model;
          break;
        case RoutesEnum.profilePage:
          model = ProfilePageModel();
          register[_routing.profilePage] = model;
          break;
        case RoutesEnum.creationPage:
          model = CreationPageModel();
          register[_routing.creationPage] = model;
          break;
        case RoutesEnum.homePage:
          model = ProjectModel();
          register[_routing.homePage] = model;
          break;
        case RoutesEnum.projectBrowsingPage:
          model = ProjectBrowsingPageModel();
          register[_routing.projectBrowsingPage] = model;
          break;
        case RoutesEnum.ideaPage:
          model = IdeaPageModel();
          register[_routing.ideaPage] = model;
          break;
        default:
          model = null;
          break;
      }
      return model;
    }
  }
}