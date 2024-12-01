import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewPreferencesScreen extends StatefulWidget {
  @override
  _ViewPreferencesScreenState createState() => _ViewPreferencesScreenState();
}

class _ViewPreferencesScreenState extends State<ViewPreferencesScreen> {
  String? _username;
  String? _theme;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
      _theme = prefs.getString('theme');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00848F), // AppBar background color
        centerTitle: true,
        title: Text(
          "View Preferences",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFF4F6F6), // Screen background color
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPreferenceCard("Username", _username ?? "Not set"),
              SizedBox(height: 16.0),
              _buildPreferenceCard("Preferred Theme", _theme ?? "Not set"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceCard(String title, String value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF004249), // Title color
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF00848F), // Value text color
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

