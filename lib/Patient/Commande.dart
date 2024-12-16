import 'package:flutter/material.dart';
import '../navbar.dart'; // Import your navbar file
import '../patient/Commande details.dart'; // Import the details screen
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryCommandeScreen extends StatefulWidget {
  @override
  _HistoryCommandeScreenState createState() => _HistoryCommandeScreenState();
}

class _HistoryCommandeScreenState extends State<HistoryCommandeScreen> {
  bool isSidebarExpanded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchOrdonnances();
  }

  Future<void> fetchOrdonnances() async {
    try {
      final response = await http.get(
        Uri.parse('http://your-backend-url/orders?userId=123'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          ordonnances = data.map((item) => Ordonnance.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching orders: $error');
    }
  }

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
                          'History Commande',
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
                                  builder: (context) => CommandeDetailsScreen(
                                      date: '12/14/2003',
                                      ordonnanceImage: 'assets/images/ordonnance_$index.png',
                                      patient: 'oussama',
                                      pharmacie: 'pharmacie kasbat ',
                                      montantTotal: ( index +1)*10.0 ,
                                      statutcomm: 'delivered')
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
