import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email='';
  String password='';
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  set isLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }
  bool isValidForm(){
    (formKey.currentState?.validate());

    ('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }
}