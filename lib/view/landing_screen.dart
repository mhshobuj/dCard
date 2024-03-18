import 'package:dma_card/res/color.dart';
import 'package:dma_card/view/home/home_screen.dart';
import 'package:dma_card/view/more/more_screen.dart';
import 'package:dma_card/view/rewards/rewards_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    RewardsScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20), // Add margin to the bottom
        decoration: BoxDecoration(
          color: Colors.transparent, // Set the background color to transparent
          borderRadius: BorderRadius.circular(30), // Rounded border radius
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, -1), // Shadow below the bottom navigation bar
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // Clip the content with rounded border radius
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.redeem),
                label: 'Rewards',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more),
                label: 'More',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
