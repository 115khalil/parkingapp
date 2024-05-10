import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:parking/PaymentPage.dart';
import 'package:parking/component/PlanBox.dart'; // Ensure this is the correct path

class CategoryPage extends StatefulWidget {
  final Duration duration;
  final String selectedLocation;
  final String licensePlate;
  final DateTime bookingStartDate;
  final DateTime bookingEndDate;

  CategoryPage({
    Key? key,
    required this.duration,
    required this.selectedLocation,
    required this.licensePlate,
    required this.bookingStartDate,
    required this.bookingEndDate,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  double? ecoPrice;
  double? luxPrice;
  double? handPrice;
  int? ecoAvailable;
  int? luxAvailable;
  int? handAvailable;

  @override
  void initState() {
    super.initState();
    fetchParkingData();
  }

  Future<void> fetchParkingData() async {
    try {
      final response =
          await http.get(Uri.parse('http://yourapi.com/api/variables'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          ecoPrice = data['ecoPrice'];
          luxPrice = data['luxPrice'];
          handPrice = data['handPrice'];
          ecoAvailable = data['ecoAvailable'];
          luxAvailable = data['luxAvailable'];
          handAvailable = data['handAvailable'];
        });
      } else {
        throw Exception('Failed to load parking data');
      }
    } catch (e) {
      print('Error fetching parking data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Parking Categories'),
        backgroundColor: Color(0xFF4b39ef),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PlanBox(
                title: "Economy Zone",
                description:
                    "Ideal for compact cars and motorcycles. Available spots: $ecoAvailable",
                price: ecoPrice ?? 0.0,
                icon: Icons.directions_car,
                selectedLocation: widget.selectedLocation,
                licensePlate: widget.licensePlate,
                bookingStartDate: widget.bookingStartDate,
                bookingEndDate: widget.bookingEndDate,
              ),
              SizedBox(height: 20),
              PlanBox(
                title: "Premium Zone",
                description:
                    "Spacious spots for SUVs and luxury vehicles. Available spots: $luxAvailable",
                price: luxPrice ?? 0.0,
                icon: Icons.local_parking,
                selectedLocation: widget.selectedLocation,
                licensePlate: widget.licensePlate,
                bookingStartDate: widget.bookingStartDate,
                bookingEndDate: widget.bookingEndDate,
              ),
              SizedBox(height: 20),
              PlanBox(
                title: "Handicap Zone",
                description:
                    "Accessible parking for permit holders. Available spots: $handAvailable",
                price: handPrice ?? 0.0,
                icon: Icons.accessible,
                selectedLocation: widget.selectedLocation,
                licensePlate: widget.licensePlate,
                bookingStartDate: widget.bookingStartDate,
                bookingEndDate: widget.bookingEndDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlanBox extends StatefulWidget {
  final String title;
  final String description;
  final double price;
  final IconData icon;
  final String selectedLocation;
  final String licensePlate;
  final DateTime bookingStartDate;
  final DateTime bookingEndDate;

  PlanBox({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.icon,
    required this.selectedLocation,
    required this.licensePlate,
    required this.bookingStartDate,
    required this.bookingEndDate,
  }) : super(key: key);

  @override
  _PlanBoxState createState() => _PlanBoxState();
}

class _PlanBoxState extends State<PlanBox> {
  String _modalMessage = '';

  void _handleClick() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text(
              'dt${widget.price.toStringAsFixed(2)} will be your total price for ${widget.title}'),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentPage(
                    selectedLocation: widget.selectedLocation,
                    licensePlate: widget.licensePlate,
                    bookingStartDate: widget.bookingStartDate,
                    bookingEndDate: widget.bookingEndDate,
                    title: widget.title,
                    price: widget.price,
                  ), // Navigate to PaymentPage with parameters
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: InkWell(
        onTap: _handleClick,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(widget.icon, size: 24),
                  SizedBox(width: 10),
                  Text(widget.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              Text(widget.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              Text('dt${widget.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
