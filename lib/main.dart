import 'package:first_app_flutter/Patient/Commande.dart';
import 'package:first_app_flutter/Patient/Ordonnace.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import './Patient/Pharmacies.dart';
import './Patient/Home.dart';
import './Patient/Commande.dart';
import './Patient/Location.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/patient/pharmacie':(context) => PharmacieScreen(),
        '/patient/home':(context) => HomeScreen(),
        '/patient/commande':(context) => HistoryCommandeScreen(),
        '/patient/ordonnance' : (context) => HistoryOrdonnanceScreen(),
        '/patient/location' : (context) => PharmacyLocationApp()

        // '/pharmacies': (context) => PharmaciesScreen(),
      },
    );
  }
}
