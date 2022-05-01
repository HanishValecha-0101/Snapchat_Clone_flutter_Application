import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snapchat_ui/pages/forgot_password.dart';
import 'package:snapchat_ui/widgets/login_signup_button.dart';
import 'package:snapchat_ui/widgets/txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapchat_ui/pages/root_app.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // email and password holder and also the form state

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  // string for displaying the error Message
  String errorMessage;
  var nackBar;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    // Future signIn() async {
    //   try{
    //
    //     await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: _emailController.text.trim(),
    //       password: _passwordController.text.trim(),
    //     );
    //     //Navigator.pop(context);
    //     // setState(() {
    //     //   _loading = true;
    //     // });
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'wrong-password') {
    //       if (kDebugMode) {
    //         print('Wrong password provided for the given email!');
    //       }
    //     } else {
    //       if (kDebugMode) {
    //         print(e.toString());
    //       }
    //     }
    //   }
    // }
    Future signIn() async {
      if (_formKey.currentState.validate()) {
        print('$_emailController.text:$_passwordController.text');
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
              .then((uid) => {
            //Fluttertoast.showToast(msg: "Login Successful"),
               nackBar = SnackBar(
                 backgroundColor: Colors.green,
                  content: Text("Login Successful"),
               ),
              ScaffoldMessenger.of(context).showSnackBar(nackBar),
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RootApp())),
          });
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case "invalid-email":
              errorMessage = "Your email address appears to be malformed.";

              break;
            case "wrong-password":
              errorMessage = "Your password is wrong.";
              break;
            case "user-not-found":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "user-disabled":
              errorMessage = "User with this email has been disabled.";
              break;
            case "too-many-requests":
              errorMessage = "Too many requests";
              break;
            case "operation-not-allowed":
              errorMessage =
              "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          var snackBar = SnackBar(
            content: Text(errorMessage),
            action: SnackBarAction(
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //Fluttertoast.showToast(msg: !);
          print(error.code);
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          bottom: 40,
          left: 30,
          right: 30,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.blue,
                            size: 35,
                          ),
                          onPressed: () => Navigator.pop(context)),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      child: Column(
                        children: [fieldsOnScreen()],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(children: [
                  ElevatedButton(

                    child: Text("Log In"),

                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                         signIn();
                    },
                  )
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }

  fieldsOnScreen() {
    return Container(
      child: Column(
        children: [
          // the text

          Text(
            "Log In",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),

          TextFormField(
            controller:_emailController,
            decoration: const InputDecoration(
             // border: OutlineInputBorder(),
              labelText: 'Email',
            ),

            obscureText: false,
            validator: (val) {
              if (val.isEmpty) {
                return "Enter an email";
            }
              // reg expression for email validation
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(val)) {
                return ("Please Enter a valid email");
              }
              return null;
            }
            // onChange: (val) {
            //   setState(() {
            //     return email = val;
            //   });
            // },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller:_passwordController,
            decoration: const InputDecoration(
              //border: OutlineInputBorder(),
              labelText: 'Password',
            ),

            obscureText: true,
            validator: (val) =>
                val.length < 6 ? "password must be 6+ characters" : null,
            // onChange: (val) {
            //   setState(() {
            //     return password = val;
            //   });
            // },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()));
            },
            child: Text(
              "Forgot your password?",
              style: TextStyle(color: Colors.blue[8]),
            ),
          )
        ],
      ),
    );
  }
}
