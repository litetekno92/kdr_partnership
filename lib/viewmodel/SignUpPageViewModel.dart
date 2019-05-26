import '../viewmodel/AViewModel.dart';
import '../model/SignUpPageModel.dart';

class SignUpPageViewModel extends AViewModel {
  SignUpPageModel                 _model;
  SignUpPageViewModel(String route) {
    super.initModel(route);
    this._model = super.abstractModel;
  }
  SignUpPageModel get model => this._model;

  Future<bool> signUpAction(SignUpData inputs){
    Future<bool> ret = this.signUp(email: inputs.email, password: inputs.password).then((value) {
      return (value == null);
    });
    return (ret);
  }
}

class SignUpData {
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
}