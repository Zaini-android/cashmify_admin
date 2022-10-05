import 'package:cashmify_admin/pages/home/home.dart';
import 'package:cashmify_admin/pages/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? home = const InitialLoadingScreen();
  var auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getRoute();
  }

  getRoute() async {
    // if (await auth.authStateChanges().first != null) {
      setState(() {
        home = Home();
      });
    // } else {
    //   setState(() {
    //     home = Login();
    //   });
    }




  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fx Admin',
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.grey.shade200,
      ),
      home: home,
    );
  }
}

class InitialLoadingScreen extends StatelessWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
