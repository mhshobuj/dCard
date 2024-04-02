import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/user_details_response.dart';
import '../../res/color.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/login_view_model.dart';
import '../../view_model/more_view_model.dart';

class EditScreen extends StatefulWidget {
  final String? imageUrl;
  final Function(String)? onImageChanged;

  const EditScreen({Key? key, this.imageUrl, this.onImageChanged})
      : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  UserDetailsResponse? getUserDetailsResponse;
  File? _imgFile;


  _selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (img == null) return;
    setState(() {
      _imgFile = File(img.path); // convert it to a Dart:io file
    });
  }

  _captureImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.camera, // alternatively, use ImageSource.gallery
      maxWidth: 400,
    );
    if (img == null) return;
    setState(() {
      _imgFile = File(img.path); // convert it to a Dart:io file
    });
  }

  // Placeholder values
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _address;
  String? _birthDay;
  bool isLoading = false; // Track loading state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch user details after the widget is built
      getUserDetails();
    });
  }

  void onImageChanged(String imagePath) {
    setState(() {
// Update state with selected image path
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.buttonColor,
              strokeWidth: 3,
            )) // Show loading indicator if isLoading is true
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
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(AppColors
                                        .buttonColor), // Change the color here
                              ),
                              child: const Text(
                                "Choose from Gallery",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Handle camera button press
                                Navigator.pop(context); // Close the dialog
                                // Call method to capture image from camera
                                _captureImageFromCamera();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(AppColors
                                        .buttonColor), // Change the color here
                              ),
                              child: const Text(
                                "Take a Photo",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Container(
                      padding: const EdgeInsets.all(2), // Add padding inside the Container
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // Add color for the border
                          width: 2, // Add width for the border
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: (_imgFile == null)
                            ? const AssetImage('assets/images/upload_image.png')
                            : FileImage(_imgFile!) as ImageProvider,
                      ),
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
            const SizedBox(height: 30),
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
                updateProfile();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.buttonColor), // Change the color here
              ),
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
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
          _address = getUserDetailsResponse.data?.userAddress?.addressLine1.toString();
          _birthDay = getUserDetailsResponse.data?.birthDate.toString();
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

  Future<void> updateProfile() async {
    final moreViewModel = Provider.of<MoreViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    final FormData formData = FormData(); // Create FormData object

    // Convert Map to Iterable using entries
    final fieldsMap = {
      'first_name': _firstName.toString(),
      'last_name': _lastName.toString(),
      'birth_date': _birthDay.toString(),
      'usr_email': _email.toString(),
      'address_line_1': _address.toString(),
      'city': 'Dhaka',
      'state': 'BD',
      'upazila': 'Dhaka',
      'post_code': '1200',
    };
    formData.fields.addAll(fieldsMap.entries);

    // Include profile picture only if _imgFile is not null
    if (_imgFile != null) {
      try {
        final multipartFile = await MultipartFile.fromFile(_imgFile!.path,
            filename: _imgFile!.path.split('/').last); // Extract filename
        formData.files.add(MapEntry('profile_pic', multipartFile));
      } catch (error) {
        print('Error creating MultipartFile: $error');
        // Handle error (e.g., display user-friendly message)
        return; // Exit the function if error occurs
      }
    }

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      moreViewModel
          .updateProfile(token!, formData, context) // Pass formData instead of data
          .then((getUserDetailsResponse) {
        if (getUserDetailsResponse.statusCode == 200) {
          Navigator.pushNamed(context, RoutesName.more);
        }
      }).catchError((error) {
        if (kDebugMode) {
          print('Error updating profile: $error');
        }
        // Handle general errors (e.g., display user-friendly message)
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Error getting token: $error');
      }
      // Handle token retrieval errors (e.g., display user-friendly message)
    });
  }
}
