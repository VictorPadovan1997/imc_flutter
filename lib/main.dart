import 'package:flutter/material.dart';
import 'package:imc_flutter/repositories/local_data/check_user_inset_height.dart';

void main() {
  runApp(const ImcWithFlutter());
}

class ImcWithFlutter extends StatelessWidget {
  const ImcWithFlutter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        errorColor: Colors.red,
        primaryColor: Colors.indigo[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[900],
        ),
      ),
      home: const CheckUserInsetHeight(),
    );
  }
}
