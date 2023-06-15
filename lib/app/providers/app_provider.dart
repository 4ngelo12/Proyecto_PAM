import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPay = GlobalKey<FormState>();

  //Login variables
  String email='';
  String password='';

  //Pay variables
  String titular = '';
  String numTarjeta = '';
  String fecha = '';
  String cvv = '';

  //Validation Form
  bool _isLoadingForm=false;

  bool get isLoadingForm=>_isLoadingForm;

  set isLoadingForm(bool value){
    _isLoadingForm=value;
    notifyListeners();
  }

  //Validation Pay
  bool _isLoadingPay=false;

  bool get isLoadingPay=>_isLoadingPay;

  set isLoadingPay(bool value){
    _isLoadingPay=value;
    notifyListeners();
  }

  //Login methods
  bool isValidLoginForm(){
    (formKeyLogin.currentState?.validate());

    ('$email - $password');

    return formKeyLogin.currentState?.validate() ?? false;
  }

  //Pay Methods
  bool isValidFormPay(){
    (formKeyPay.currentState?.validate());

    ('$titular - $numTarjeta - $fecha - $cvv');

    return formKeyPay.currentState?.validate() ?? false;
  }
}