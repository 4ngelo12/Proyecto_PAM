import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  bool _result = false;

  bool get result => _result;

  void setResult(bool value) {
    _result = value;
    notifyListeners();
  }

  void setResultFromFuture(Future<bool> futureResult) {
    futureResult.then((value) {
      setResult(value);
    }).catchError((error) {
      print("Ocurrió un error al obtener el resultado: $error");
    });
  }
}