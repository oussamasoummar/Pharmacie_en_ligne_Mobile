import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class CreateOrdonnanceScreen extends StatefulWidget {
  final String pharmacyName;
  final String username;

  const CreateOrdonnanceScreen({
    Key? key,
    required this.pharmacyName,
    required this.username,
  }) : super(key: key);

  @override
  _CreateOrdonnanceScreenState createState() => _CreateOrdonnanceScreenState();
}

class _CreateOrdonnanceScreenState extends State<CreateOrdonnanceScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Function to handle image capture
  Future<void> _takePicture() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error taking picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take picture')),
      );
    }
  }

  // Function to submit ordonnance
  Future<void> _submitOrdonnance() async {
    // Check if image is selected
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please take a picture of the ordonnance first')),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      // Prepare multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://your-backend-url.com/ordonnance/create')
      );

      // Add image file to the request
      request.files.add(
          await http.MultipartFile.fromPath(
              'image',
              _imageFile!.path
          )
      );

      // Add additional form fields
      request.fields['pharmacyName'] = widget.pharmacyName;
      request.fields['username'] = widget.username;

      // Send the request
      var response = await request.send();

      // Remove loading indicator
      Navigator.of(context).pop();

      // Check the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response
        final responseBody = await response.stream.bytesToString();
        final responseData = json.decode(responseBody);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message'] ?? 'Ordonnance submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Reset image
        setState(() {
          _imageFile = null;
        });

        // Optionally navigate back or to another screen
        // Navigator.of(context).pop();
      } else {
        // Parse error response
        final responseBody = await response.stream.bytesToString();
        final errorData = json.decode(responseBody);

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorData['error'] ?? 'Failed to submit ordonnance'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Remove loading indicator
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Ordonnance',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pharmacy: ${widget.pharmacyName}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'User: ${widget.username}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Upload Ordonnance:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Image Preview
            if (_imageFile != null)
              Center(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 8.0),
            ElevatedButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera_alt),
              label: Text('Take Picture'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Please make sure the ordonnance is clear and readable before taking the picture.',
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _submitOrdonnance,
                child: Text('Submit Ordonnance'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}