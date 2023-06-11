import 'package:flutter/material.dart';

class PagoProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String titular = '';
  String numTarjeta = '';
  String fecha = '';
  String cvv = '';

  bool _isLoading=false;

  bool get isLoading => _isLoading;

  set isLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }

  bool isValidForm(){
    (formKey.currentState?.validate());

    ('$titular - $numTarjeta - $fecha - $cvv');

    return formKey.currentState?.validate() ?? false;
  }
}

