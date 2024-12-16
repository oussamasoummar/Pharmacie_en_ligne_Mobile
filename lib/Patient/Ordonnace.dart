import 'package:flutter/material.dart';
import '../navbar.dart'; // Import your navbar file
import '../patient/Ordonnance details.dart'; // Import the details screen

class HistoryOrdonnanceScreen extends StatefulWidget {
  @override
  _HistoryOrdonnanceScreenState createState() => _HistoryOrdonnanceScreenState();
}

class _HistoryOrdonnanceScreenState extends State<HistoryOrdonnanceScreen> {
  bool isSidebarExpanded = false;

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
                    children: [
                      Expanded(
                        child: Text(
                          'History Ordonnance',
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
                    padding: EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: 10, // Example: 10 dummy orders
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Icon(Icons.shopping_cart, color: Colors.blue),
                            title: Text('Order #${index + 1}'),
                            subtitle: Text('Details about the order...'),
                            trailing: Text(
                              'Status: Delivered',
                              style: TextStyle(color: Colors.green),
                            ),
                            onTap: () {
                              // Navigate to CommandeDetailsScreen and pass arguments
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrdonnanceDetailsScreen(
                                        date: '12/14/2003',
                                        ordonnanceImage: 'assets/images/ordonnance_$index.png',
                                        patient: 'oussama',
                                        pharmacie: 'pharmacie kasbat ',
                                        statutOrd: 'accepted')
                                ),
                              );
                            },
                          ),
                        );
                      },
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
