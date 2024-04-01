import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/user_details_response.dart';
import '../../res/color.dart';
import '../../view_model/login_view_model.dart';
import '../../view_model/more_view_model.dart';

class EditScreen extends StatefulWidget {
  final String? imageUrl;
  final Function(String)? onImageChanged;

  const EditScreen({Key? key, this.imageUrl, this.onImageChanged}) : super(key: key);


  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  UserDetailsResponse? getUserDetailsResponse;
  final _picker = ImagePicker(); // Create an ImagePicker instance

  Future<void> _selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      widget.onImageChanged?.call(pickedFile.path); // Call callback with path
    }
  }

  Future<void> _captureImageFromCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      widget.onImageChanged?.call(pickedFile.path); // Call callback with path
    }
  }

  // Placeholder values
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _address;
  bool isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch user details after the widget is built
      getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
      ),
      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator if isLoading is true
          : buildEditProfileForm(),
    );
  }

  Widget buildEditProfileForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Show dialog to select image from gallery or camera
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Change Profile Picture"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle gallery button press
                                Navigator.pop(context); // Close the dialog
                                // Call method to select image from gallery
                                _selectImageFromGallery();
                              },
                              child: Text("Choose from Gallery"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle camera button press
                                Navigator.pop(context); // Close the dialog
                                // Call method to capture image from camera
                                _captureImageFromCamera();
                              },
                              child: Text("Take a Photo"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundImage: widget.imageUrl != null
                          ? FileImage(File(widget.imageUrl!))
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // First Name Field
            TextFormField(
              initialValue: _firstName,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _firstName = value; // Update _firstName using setState
                });
              },
            ),
            const SizedBox(height: 10),
            // Last Name Field
            TextFormField(
              initialValue: _lastName,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _lastName = value;
              },
            ),
            const SizedBox(height: 10),
            // Email Field
            TextFormField(
              initialValue: _email,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(height: 10),
            // Phone Field (Non-editable)
            TextFormField(
              initialValue: _phone,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Address Field
            TextFormField(
              initialValue: _address,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _address = value;
              },
            ),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void getUserDetails() {
    setState(() {
      isLoading = true; // Start loading indicator
    });
    final moreViewModel = Provider.of<MoreViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      moreViewModel
          .getUserDetails(token!, context)
          .then((getUserDetailsResponse) {
        // Update the state with user details and dismiss loading indicator
        setState(() {
          this.getUserDetailsResponse = getUserDetailsResponse;
          _firstName = getUserDetailsResponse.data?.firstName;
          _lastName = getUserDetailsResponse.data?.lastName;
          _email = getUserDetailsResponse.data?.usrEmail;
          _phone = getUserDetailsResponse.data?.userPhone?.phnCell;
          _address =
              getUserDetailsResponse.data?.userAddress?.addressLine1.toString();
          isLoading = false; // Stop loading indicator
        });
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        // Handle error here
        setState(() {
          isLoading = false; // Stop loading indicator
        });
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      // Handle error here
      setState(() {
        isLoading = false; // Stop loading indicator
      });
    });
  }
}
