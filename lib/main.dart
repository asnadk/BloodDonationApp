import 'package:blood_donation/editingPage.dart';
import 'package:blood_donation/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
         apiKey: "AIzaSyCyWC5UeOmnOf4FFM8uNaNIUWRa2ErrD3Q",
  authDomain: "flutterblooddonation.firebaseapp.com",
  projectId: "flutterblooddonation",
  storageBucket: "flutterblooddonation.appspot.com",
  messagingSenderId: "342171868016",
  appId: "1:342171868016:web:7b70561ef9ee0b5c6b0db5",
  measurementId: "G-Q72QS4G01J"
      )
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/update":(context) => EditingPage()
      },
      home:  SplashScreen(),
    );
  }
}

