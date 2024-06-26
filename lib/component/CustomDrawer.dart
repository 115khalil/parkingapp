import 'package:flutter/material.dart';
import 'package:parking/AeroportsPage.dart';
import 'package:parking/BookingPage.dart';
import 'package:parking/ContactUsPage.dart';
import 'package:parking/HelpPage.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding:
            EdgeInsets.zero, // Important: Remove any padding from the ListView.
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF4b39ef), // Primary color for the header
            ),
            child: Text(
              'Navigation',
              style: TextStyle(color: Colors.white),
            ), // Default text color
          ),
          ListTile(
            leading: Icon(Icons.book), // Default icon color
            title: const Text('Reservation'), // Default text color
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.airport_shuttle), // Default icon color
            title: const Text(
              'Aeroports',
            ), // Default text color
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AeroportsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_phone), // Default icon color
            title: const Text('Contact Us'), // Default text color
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help), // Default icon color
            title: const Text('Help'), // Default text color
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
