import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snapchat_ui/pages/root_app.dart';
import 'package:snapchat_ui/widgets/login_signup_button.dart';
import 'package:snapchat_ui/widgets/txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = "";
  String username = "";
  String password = "";
  String email = "";
  final _nameController = TextEditingController();
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

    // Future signUp() async {
    //
    //   try{
    //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: _emailController.text.trim(),
    //       password: _passwordController.text.trim(),
    //     );
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'weak-password') {
    //       if (kDebugMode) {
    //         print('The password provided is too weak.');
    //       }
    //     } else if (e.code == 'email-already-in-use') {
    //       if (kDebugMode) {
    //         print('The account already exists for that email.');
    //       }
    //     } else {
    //       if (kDebugMode) {
    //         print(e.toString());
    //       }
    //     }
    //   }
    //   //Navigator.pop(context);
    // }
    var errorMessage;

    void signUp() async {
      if (_formKey.currentState.validate()) {
        try {

           await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
            .then((value) => {postDetailsToFirestore()})
            .catchError((e){
            final nackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(e.message),
            );
            ScaffoldMessenger.of(context).showSnackBar(nackBar);
          });

        }on FirebaseAuthException catch (error) {
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
              errorMessage = "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          //Fluttertoast.showToast(msg: erorMessage!);
          final nackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(errorMessage),
          );
          ScaffoldMessenger.of(context).showSnackBar(nackBar);
          print(error.code);
        }
      }
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      //resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 40,right: 30,left: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      alignment:Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                          size: 35,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    fieldOnScreen(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(

                  children: [
                    Material(
                     borderRadius: BorderRadius.circular(40),
                 child:ElevatedButton(

                    child:Text("Sign Up & Accept"),


                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Colors.blue,

                    ),

                    // color: Colors.blue,

                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                        signUp();
                      }
                    },
              )
                    )

                  ],
                ),
              ),
              //signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  fieldOnScreen() {
    return Container(
      child: Column(
        children: [
          // the text

          Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),

          // TxtFieldForScreen(
          //   txtType: TextInputType.name,
          //   label: "Username",
          //   obscure: false,
          //
          //   onChange: (val) {
          //     setState(() {
          //       return username = val;
          //     });
          //   },
          // ),
          TextFormField(

             controller: _nameController,
              decoration: InputDecoration(
                  //border: OutlineInputBorder(),
                  labelText: 'Username'
              ),

              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your username';
                }
                if(value.length < 6) {
                  return "Minimum 6 characters are needed" ;
                }
                return null;
              }
          ),

          SizedBox(
            height: 10,
          ),


      TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
            //border: OutlineInputBorder(),
            labelText: 'Email'
        ),
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

          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: RichText(
              text: TextSpan(
                  text:
                      "By tapping Sign Up & Accept you acknowledge that you have read the ",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: "Privacy Policy ",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: "and agree to the ",
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                    TextSpan(
                      text: "Terms of Service",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.name = _nameController.text;


    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Text("Account created successfully :) "),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => RootApp()),
            (route) => false);
  }

  // signUpButton() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         LoginAndSignUpButton(
  //           color: Colors.blue,
  //           text: "Sign Up & Accept",
  //           onPress: () async {
  //             if (_formKey.currentState.validate()) {
  //               if (kDebugMode) {
  //                 print(_emailController.text);
  //                 print(_passwordController.text);
  //               }
  //               signUp();
  //             }
  //             //if (_formKey.currentState.validate()) {}
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}
