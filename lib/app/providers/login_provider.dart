import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  String email='';
  String password='';

  bool _isLoadingForm=false;

  bool get isLoadingForm=>_isLoadingForm;

  set isLoadingForm(bool value){
    _isLoadingForm=value;
    notifyListeners();
  }
  
  bool isValidLoginForm(){
    (formKeyLogin.currentState?.validate());

    ('$email - $password');

    return formKeyLogin.currentState?.validate() ?? false;
  }
}