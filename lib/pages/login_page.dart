import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:email_validator/email_validator.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:snapchat_ui/pages/root_app.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() => runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Scaffold(
//         body: Padding(
//             padding: const EdgeInsets.only(left: 40.0,top: 60.0,right: 40.0,bottom: 40.0),
//             child: PageForm()
//         )
//     )
// ));

class PageForm extends StatefulWidget {
  //const PageForm({Key? key}) : super(key: key);

  @override
  _PageFormState createState() => _PageFormState();
}


class _PageFormState extends State<PageForm> {
  final _formKey = GlobalKey<FormState>();

  var _autovalidate = false;
  bool _passwordnotvisible = true;
  var _email;
  var _user;
  var _password;
  var _passwordRepeat;
  var isValid = false;

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
    //     // showDialog(context: context,
    //     //     builder: (BuildContext context) {
    //     //       return const Center(
    //     //         child: CircularProgressIndicator(
    //     //           color: Colors.amber,
    //     //         ),
    //     //       );
    //     //     });
    //     await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: _emailController.text.trim(),
    //       password: _passwordController.text.trim(),
    //     );
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

    Future signUp() async {

      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          if (kDebugMode) {
            print('The password provided is too weak.');
          }
        } else if (e.code == 'email-already-in-use') {
          if (kDebugMode) {
            print('The account already exists for that email.');
          }
        } else {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }
      //Navigator.pop(context);
    }


    return Scaffold(

      body:Padding(
        padding:  const EdgeInsets.only(left: 40.0,top: 60.0,right: 40.0,bottom: 40.0),
        child: Form(


        //autovalidate just removes the null error which come will typing only not while submitting again
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        //backgroundColor: Colors.yellow,
        child: Column(
          children:
          <Widget>[

            Container(
              decoration: BoxDecoration(
                color:Colors.yellow,
              ),
              alignment: Alignment.center,
              child: Image.asset('assets/logo.png'),
              height: 90,
            ),
            //Image.network('https://wallpaperaccess.com/full/2403655.jpg'),
            //FlutterLogo(size: 100),
            SizedBox(height: 20),
            Text('Snapchat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                )),
            SizedBox(height: 30),
            TextFormField(

                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username'
                ),
                onChanged: (value) {
                  _user = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                }
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email'
                ),
                onChanged: (value) {
                  _email = value;
                },

                // validator: (value) {
                //   isValid =  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.toString());
                //   //EmailValidator.validate(_email);
                //   if (value.isEmpty) {
                //    return 'Please Enter Email In Correct Format';
                //   } return 'Please enter your Email';
                // }else if(isValid){


      // return null;
      //           }
                         ),
            SizedBox(height: 20),
            TextFormField(
               controller: _passwordController,
                obscureText: _passwordnotvisible,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Your Password ',
                  // suffixIcon: new GestureDetector(
                  //       onTap: () async {
                  //         setState(() {
                  //           _passwordnotvisible = !_passwordnotvisible;
                  //         });
                  //       },
                  //       child:
                  //       new Icon(_passwordnotvisible ? Icons.visibility : Icons.visibility_off),
                  // ),


                ),
                onChanged: (value) {
                  _password = value;
                },

                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                }
            ),

            //SizedBox(height: 0),
            Row(
              children: [

                IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordnotvisible
                        ? Icons.check_box_outline_blank_outlined : Icons.check_box,
                    color: Theme.of(context).primaryColorDark,
                  ),



                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordnotvisible = !_passwordnotvisible;
                    });

                  },

                ),

                Text("Show Password"),
              ],
            ),


            //
            // TextFormField(
            //     obscureText: true,
            //     decoration: const InputDecoration(
            //         border: OutlineInputBorder(),
            //         labelText: 'Repeat password'
            //     ),
            //     onChanged: (value) {
            //       _passwordRepeat = value;
            //     },
            //     validator: (value) {
            //       if (_password != value) {
            //         return 'Passwords do not match';
            //       }
            //       return null;
            //     }
            // ),
            //SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                // ignore: deprecated_member_use
                child: FlatButton(
                    color: Colors.blue,
                    child: const Text('Sign Up', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                    onPressed: () {

                if (_formKey.currentState.validate()) {
                if (kDebugMode) {
                print(_emailController.text);
                print(_passwordController.text);
                }
                signUp();
                }


                      //Navigator.pushNamed(context, '/App');

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => RootApp()),
                      // );

                      // if (_formKey.currentState.validate()) {
                      //   print('$_user:$_password:$_passwordRepeat');
                      //
                      //   Scaffold.of(context)
                      //   // ignore: deprecated_member_use
                      //       .showSnackBar(const SnackBar(
                      //       backgroundColor: Colors.green,
                      //       content: Text('Submitted successfully :)')
                      //   ));
                      //
                      //
                      // } else {
                      //   Scaffold.of(context)
                      //   // ignore: deprecated_member_use
                      //       .showSnackBar(const SnackBar(
                      //       backgroundColor: Colors.redAccent,
                      //       content: Text('Problem submitting form :(')
                      //   ));
                      //   setState(() {
                      //     _autovalidate = true;
                      //   });
                      // }


                    }
                )
            ),
            EasyRichText(
              "By Sign up you acknowledge that you have read the Privacy Policy and agree Terms of Service.",
              patternList: [
                EasyRichTextPattern(
                  targetString: 'Privacy Policy',
                  style: TextStyle(color: Colors.blue),
                ),
                EasyRichTextPattern(
                  targetString: 'Terms of Service',
                  style: TextStyle(color: Colors.blue),
                ),
                // EasyRichTextPattern(
                //   targetString: 'italic',
                //   style: TextStyle(fontStyle: FontStyle.italic),
                // ),
              ],
            ),
            // Text(
            //   'By Sign up you acknowledge that you have read the Privacy Policy and agree Terms of Service.',
            //   style: TextStyle(
            //     //inbuilt named colors
            //     color: Colors.grey,
            //     fontSize: 13,
            //   ),
            // ),
          ],
        ),



    ),
      ),
    );


  }
}
