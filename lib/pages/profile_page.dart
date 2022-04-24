
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:snapchat_ui/pages/authentication_screen.dart';
import'package:snapchat_ui/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  //const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthenticationScreen()));
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

            Text("Name :- "+"${loggedInUser.name}",
            style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            )),

          SizedBox(
            height: 15,
          ),

            Text("Email :- "+"${loggedInUser.email}",
            style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            )),

          SizedBox(
                height: 15,
                ),
          Container(
          child: ElevatedButton.icon(
          onPressed: () => logout(context),
          icon: Icon(Icons.logout),
          label: Text('Sign Out'),
          )
          ),

    ],
    )

      ),
    );
  }
}