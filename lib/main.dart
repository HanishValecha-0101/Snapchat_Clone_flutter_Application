import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:snapchat_ui/pages/root_app.dart';
import 'package:snapchat_ui/pages/login_page.dart';
import 'package:snapchat_ui/pages/camera_page.dart';
import 'package:snapchat_ui/pages/chat_page.dart';
import 'package:snapchat_ui/pages/map_page.dart';
import 'package:snapchat_ui/pages/stories_page.dart';
import 'package:snapchat_ui/pages/spotlight_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapchat_ui/pages/authentication_screen.dart'; Future<void> main() async {



  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
// When navigating to the "/" route, build the FirstScreen widget. '/': (context) => AuthenticationScreen(),
      '/App': (context) => RootApp(),
      ),
  );
      }

