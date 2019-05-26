import '../viewmodel/AViewModel.dart';
import '../viewmodel/HomePageViewModel.dart';
import '../viewmodel/LoginPageViewModel.dart';
import '../viewmodel/SignInPageViewModel.dart';
import '../viewmodel/SignUpPageViewModel.dart';
import '../viewmodel/ProfilePageViewModel.dart';
import '../viewmodel/CreationPageViewModel.dart';
import '../viewmodel/IdeaPageViewModel.dart';
import '../viewmodel/ProjectDescriptionPageViewModel.dart';
import '../viewmodel/ProjectBrowsingPageViewModel.dart';
import '../utils/Routes.dart';
/*
    Responsible for creating/managing all the ViewModel, accessible from the Coordinator.
*/

abstract class AViewModelFactory
{
  // Register to store and reuse (without changes in state) instanciated ViewModels
  static final Map<String, AViewModel> register = <String, AViewModel>{};

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
  // Factory to instanciate ViewModels from routes
  factory AViewModelFactory(String route){
    if  (register.containsKey(route))
      return register[route];
    else {
      AViewModel  viewModel;
      IRoutes     _routing = Routes();
      RoutesEnum  targetedRoute = fetchRoutes(route, _routing);
      switch (targetedRoute){
        case RoutesEnum.loginPage:
          viewModel = LoginPageViewModel(_routing.loginPage);
          register[_routing.loginPage] = viewModel;
          break;
        case RoutesEnum.signInPage:
          viewModel = SignInPageViewModel(_routing.signInPage);
          register[_routing.signInPage] = viewModel;
          break;
        case RoutesEnum.signUpPage:
          viewModel = SignUpPageViewModel(_routing.signUpPage);
          register[_routing.signUpPage] = viewModel;
          break;
        case RoutesEnum.profilePage:
          viewModel = ProfilePageViewModel(_routing.profilePage);
          register[_routing.profilePage] = viewModel;
          break;
        case RoutesEnum.creationPage:
          viewModel = CreationPageViewModel(_routing.creationPage);
          register[_routing.creationPage] = viewModel;
          break;
        case RoutesEnum.homePage:
          viewModel = HomePageViewModel(_routing.homePage);
          register[_routing.homePage] = viewModel;
          break;
        case RoutesEnum.projectDescriptionPage:
          viewModel = ProjectDescriptionPageViewModel(_routing.projectDescriptionPage);
          register[_routing.projectDescriptionPage] = viewModel;
          break;
        case RoutesEnum.projectBrowsingPage:
          viewModel = ProjectBrowsingPageViewModel(_routing.projectBrowsingPage);
          register[_routing.projectBrowsingPage] = viewModel;
          break;
        case RoutesEnum.ideaPage:
          viewModel = IdeaPageViewModel(_routing.ideaPage);
          register[_routing.ideaPage] = viewModel;
          break;
        default:
          throw Exception("Error while constructing ViewModel: the route \"$route\" provided is unknown !");
          break;
      }
      return viewModel;
    }
  }
}