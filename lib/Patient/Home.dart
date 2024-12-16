import 'package:flutter/material.dart';
import '../navbar.dart'; // Import your navbar file

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSidebarExpanded = false;
  String username = "oussama";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Use the existing Navbar from navbar.dart
          Navbar(
            isExpanded: isSidebarExpanded,
            onToggle: (isExpanded) {
              setState(() {
                isSidebarExpanded = isExpanded;
              });
            },
          ),
          Expanded(
            child: Column(
              children: [
                // Header with History Commande Text
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.green,
                  child: Row(
                    children:[
                      Expanded(
                        child:Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: Container(
                    color: Colors.grey[100],
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(16.0),
                    width: 1000,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Information',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Role: ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Email: dfsdfadfdfdfs',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Location: ',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}