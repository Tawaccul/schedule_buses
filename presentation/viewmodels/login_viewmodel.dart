// lib/presentation/viewmodels/login_viewmodel.dart

import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  void navigateToMainScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/main');
  }

  void openUrl(String url) {
    // Открытие URL в браузере, может потребовать использования url_launcher пакета
  }
}