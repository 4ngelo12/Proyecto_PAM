import 'package:flutter/material.dart';

class PayProvider extends ChangeNotifier {
  GlobalKey<FormState> formKeyPay = GlobalKey<FormState>();

  String titular = '';
  String numTarjeta = '';
  String fecha = '';
  String cvv = '';

  bool _isLoadingPay=false;

  bool get isLoadingPay=>_isLoadingPay;

  set isLoadingPay(bool value){
    _isLoadingPay=value;
    notifyListeners();
  }

  bool isValidFormPay(){
    (formKeyPay.currentState?.validate());

    ('$titular - $numTarjeta - $fecha - $cvv');

    return formKeyPay.currentState?.validate() ?? false;
  }
}