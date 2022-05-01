import 'package:flutter/material.dart';
import 'package:snapchat_ui/pages/login_screen.dart';
import 'package:snapchat_ui/pages/signup_screen.dart';
import 'package:snapchat_ui/widgets/auth_button.dart';


class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 100),
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/logo.png'),
            height: 160,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                AuthButton(
                  color: Colors.red,
                  text: "LOG IN",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                AuthButton(
                  color: Colors.blue,
                  text: "SIGN UP",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
