import 'package:flutter/material.dart';

class CommandeDetailsScreen extends StatelessWidget {
  final String date;
  final String ordonnanceImage;
  final String patient;
  final String pharmacie;
  final double montantTotal;
  final String statutcomm;


  const CommandeDetailsScreen({
    Key? key,
    required this.date,
    required this.ordonnanceImage,
    required this.patient,
    required this.pharmacie,
    required this.montantTotal,
    required this.statutcomm,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commande Details',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
        ),

        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ordonnance Image
            Center(
              child: Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                  image: DecorationImage(
                    image: NetworkImage(ordonnanceImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // user
            Text(
              'patient : $patient',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Pharmacie: $pharmacie',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            // Date
            Text(
              'Date: $date',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),

            // Montant Total
            Text(
              'Montant Total: \$${montantTotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),

            // Statut
            Text(
              'Statut: $statutcomm',
              style: TextStyle(
                fontSize: 16.0,
                color: statutcomm.toLowerCase() == 'delivered' ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 8.0),

          ],
        ),
      ),
    );
  }
}
