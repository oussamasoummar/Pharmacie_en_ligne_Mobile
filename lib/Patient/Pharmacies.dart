import 'package:flutter/material.dart';
import '../navbar.dart';
import 'createOrdonnance.dart'; // Import your navbar file

class PharmacieScreen extends StatefulWidget {
  @override
  _PharmacieScreenState createState() => _PharmacieScreenState();
}

class _PharmacieScreenState extends State<PharmacieScreen> {
  bool isSidebarExpanded = false;
  int? selectedPharmacyIndex;

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
                // Header with "Pharmacies" Text
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.green,
                  child: Text(
                    'Pharmacies',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Main Content
                Expanded(
                  child: Container(
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: 10, // Example: 10 dummy pharmacies
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              margin: EdgeInsets.only(bottom: 16.0),
                              child: ListTile(
                                leading: Icon(Icons.local_pharmacy, color: Colors.green),
                                title: Text('Pharmacy ${index + 1}'),
                                subtitle: Text('Location details of Pharmacy ${index + 1}'),
                                trailing: Icon(Icons.arrow_drop_down),
                                onTap: () {
                                  setState(() {
                                    selectedPharmacyIndex = selectedPharmacyIndex == index ? null : index;
                                  });
                                },
                              ),
                            ),
                            if (selectedPharmacyIndex == index)
                              Container(
                                padding: EdgeInsets.all(16.0),
                                margin: EdgeInsets.only(bottom: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pharmacy Details',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text('Name: Pharmacy ${index + 1}'),
                                    Text('Location: Location details of Pharmacy ${index + 1}'),
                                    Text('Phone: +1234567890'),
                                    SizedBox(height: 16.0),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {
                                           Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CreateOrdonnanceScreen(
                                                pharmacyName: 'Pharmacy ${index + 1}',
                                                username: 'oussama',
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(),
                                        child: Text('Create Ordonnance'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
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
