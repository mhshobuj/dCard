import 'package:dma_card/model/user_details_response.dart';
import 'package:dma_card/view_model/more_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/login_view_model.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  UserDetailsResponse? getUserDetailsResponse;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Fetch user details after the widget is built
      getUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                // Profile card
                const SizedBox(height: 20),
                Center(
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100, // Adjust height as needed
                                width: 100, // Adjust width as needed
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    getUserDetailsResponse
                                            ?.data?.usrProfilePic ??
                                        '', // Update with actual profile image URL
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Username Text
                          Text(
                            '${getUserDetailsResponse?.data?.firstName ?? ''} ${getUserDetailsResponse?.data?.lastName ?? ''}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          // Email Text
                          Text(
                            getUserDetailsResponse?.data?.usrEmail ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Other list items
                _buildListItem(context, 'FAQ', Icons.help_outline, () {
                  Navigator.pushNamed(context, RoutesName.faq);
                }),
                _buildListItem(context, 'Support', Icons.support, () {
                  Navigator.pushNamed(context, RoutesName.support);
                }),
                _buildListItem(context, 'About', Icons.info_outline, () {
                  Utils.flushBarErrorMessage("Under Development", context);
                }),
                _buildListItem(
                    context, 'Change Password', Icons.security_outlined, () {
                  Utils.flushBarErrorMessage("Under Development", context);
                }),
                _buildListItem(context, 'Logout', Icons.logout, () {
                  _logout(context, tokenViewModel);
                }),
                const SizedBox(height: 20),
                // Copyright notice
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Copyright © $currentYear Datasoft Manufacturing & Assembly Inc. Limited. All Rights Reserved.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildListItem(
      BuildContext context, String title, IconData icon, Function onTap) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios), // Add arrow icon
        ),
      ),
    );
  }

  void _logout(BuildContext context, TokenViewModel tokenViewModel) {
    // Implement your logout logic here
    // For example, you can clear user authentication token, navigate to login screen, etc.
    // Once logged out, navigate to the login screen
    tokenViewModel.remove();
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.login, (route) => false);
  }

  void getUserDetails() {
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
          isLoading = false;
        });
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        // Handle error here
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      // Handle error here
    });
  }
}
