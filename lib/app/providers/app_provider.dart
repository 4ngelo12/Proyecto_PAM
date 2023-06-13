import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
    (formKey.currentState?.validate());

    ('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }

  //Pay Methods
  bool isValidPayForm(){
    (formKey.currentState?.validate());

    ('$titular - $numTarjeta - $fecha - $cvv');

    return formKey.currentState?.validate() ?? false;
  }
}