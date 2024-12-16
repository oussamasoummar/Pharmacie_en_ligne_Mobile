import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import './createOrdonnance.dart';



class Pharmacy {
  final String name;
  final double latitude;
  final double longitude;
  final bool isActive;
  double distance; // Distance will be dynamically calculated

  Pharmacy({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.isActive,
    this.distance = 0.0,
  });
}

class PharmacyLocationApp extends StatelessWidget {
  const PharmacyLocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pharmacy Finder',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Back button functionality
            },
          ),
        ),
        body: const PharmacyMapView(),
      ),
    );
  }
}

class PharmacyMapView extends StatefulWidget {
  const PharmacyMapView({super.key});

  @override
  State<PharmacyMapView> createState() => _PharmacyMapViewState();
}

class _PharmacyMapViewState extends State<PharmacyMapView> {
  final List<Pharmacy> allPharmacies = [
    // Example pharmacies with latitude and longitude
    Pharmacy(
        name: 'Pharmacie1',
        latitude: 12.9716,
        longitude: 77.5946,
        isActive: true),
    Pharmacy(
        name: 'Phar2', latitude: 37.3393900, longitude: -121.8949600, isActive: false),
    Pharmacy(
        name: 'Pharmacie3',
        latitude: 12.9630,
        longitude: 77.5990,
        isActive: true),
  ];

  Position? currentPosition; // User's current position
  List<Pharmacy> filteredPharmacies = [];
  String searchQuery = '';
  bool showActiveOnly = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  // Fetch user location
  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied.');
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
      _calculateDistances();
    });
  }

  // Calculate distances between user and each pharmacy
  void _calculateDistances() {
    if (currentPosition == null) return;

    for (var pharmacy in allPharmacies) {
      pharmacy.distance = Geolocator.distanceBetween(
        currentPosition!.latitude,
        currentPosition!.longitude,
        pharmacy.latitude,
        pharmacy.longitude,
      ) /
          1000; // Convert to kilometers
    }

    _filterPharmacies();
  }

  void _filterPharmacies() {
    setState(() {
      filteredPharmacies = allPharmacies
          .where((pharmacy) =>
      pharmacy.name.toLowerCase().contains(searchQuery.toLowerCase()) &&
          (!showActiveOnly || pharmacy.isActive))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Map Section
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: currentPosition == null
              ? const Center( // Show a loading spinner while location is loading
            child: CircularProgressIndicator(),
          ):
          GoogleMap(
            initialCameraPosition:  CameraPosition(
              target: LatLng(currentPosition!.latitude, currentPosition!.longitude)
                  , // Initial position
              zoom: 14.0,
            ),
            markers: filteredPharmacies
                .map((pharmacy) => Marker(
              markerId: MarkerId(pharmacy.name),
              position: LatLng(pharmacy.latitude, pharmacy.longitude),
              infoWindow: InfoWindow(
                  title: pharmacy.name,
                  snippet:
                  '${pharmacy.distance.toStringAsFixed(2)} km ${pharmacy.isActive ? "(Active)" : "(Inactive)"}'),
            ))
                .toSet(),
            myLocationEnabled: true,
            zoomControlsEnabled: true,
          ),
        ),
        const SizedBox(height: 10),
        // Search and Filter Section
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search pharmacy...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    searchQuery = value;
                    _filterPharmacies();
                  },
                ),
              ),
            ),
            Switch(
              value: showActiveOnly,
              onChanged: (value) {
                setState(() {
                  showActiveOnly = value;
                  _filterPharmacies();
                });
              },
            ),
            const Text('Active Only'),
          ],
        ),
        const SizedBox(height: 10),
        // Pharmacy List
        Expanded(
          child: ListView.builder(
            itemCount: filteredPharmacies.length,
            itemBuilder: (context, index) {
              final pharmacy = filteredPharmacies[index];
              return PharmacyCard(
                pharmacy: pharmacy,
              );
            },
          ),
        ),
      ],
    );
  }
}

class PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;

  const PharmacyCard({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: pharmacy.isActive ? Colors.green : Colors.red,
          child: const Icon(Icons.local_pharmacy, color: Colors.white),
        ),
        title: Text(
          pharmacy.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${pharmacy.distance.toStringAsFixed(2)} km away'),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateOrdonnanceScreen(
                  pharmacyName: 'Pharmacy',
                  username: 'oussama',
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          child: const Text('Book'),
        ),
      ),
    );
  }
}
