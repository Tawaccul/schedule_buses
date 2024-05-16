// lib/presentation/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:testappflutter/presentation/consts/colors.dart';
import '../viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Image.network('https://www.shutterstock.com/image-vector/camping-van-bus-school-vector-600nw-2322944825.jpg',
                      width: 300,
                      height: 300,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.navigateToMainScreen(context),
                    
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16.0)),
                      backgroundColor: MaterialStateProperty.all<Color>(mainGreenColor),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      minimumSize: MaterialStateProperty.all<Size>(const Size(200, 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text('Перейти к автобусам'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  TextButton(
                    onPressed: () => viewModel.openUrl('https://github.com/Tawaccul'),
                    child: const Text('Terms and Conditions', style: TextStyle(color: mainGreenColor),),
                  ),
                  TextButton(
                    onPressed: () => viewModel.openUrl('https://github.com/Tawaccul',),
                    child: const Text('Privacy Policy',  style: TextStyle(color: mainGreenColor)),
                  ),
                    ],
                    )
                  
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}