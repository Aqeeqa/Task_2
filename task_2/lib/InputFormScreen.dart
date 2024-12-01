import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ViewPreferencesScreen.dart';


class InputFormScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  InputFormScreen({required this.themeNotifier});

  @override
  _InputFormScreenState createState() => _InputFormScreenState();
}

class _InputFormScreenState extends State<InputFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  String _selectedTheme = "Light";

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('theme') ?? "Light";
    setState(() {
      _selectedTheme = savedTheme;
      widget.themeNotifier.value =
      savedTheme == "Dark" ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> _savePreferences() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', _usernameController.text);
      await prefs.setString('theme', _selectedTheme);

      widget.themeNotifier.value =
      _selectedTheme == "Dark" ? ThemeMode.dark : ThemeMode.light;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preferences saved successfully!")),
      );
    }
  }

  void _viewPreferences() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewPreferencesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00848F), // Set AppBar color
        centerTitle: true, // Center the title
        title: Text(
          "User Preferences",
          style: TextStyle(
            color: Colors.white, // Title color
            fontSize: 18, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
      ),
      body: SingleChildScrollView( // Allow vertical scrolling
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                cursorColor: Color(0xFF00848F),
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(
                    color: Color(0xFF004249),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(
                  color: Color(0xFF00848F),
                  fontSize: 16,
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Please enter a username" : null,
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedTheme,
                items: ["Light", "Dark"]
                    .map((theme) => DropdownMenuItem(
                  value: theme,
                  child: Text(
                    theme,
                    style: TextStyle(color: Color(0xFF00848F)),
                  ),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedTheme = value!),
                decoration: InputDecoration(
                  labelText: "Preferred Theme",
                  labelStyle: TextStyle(
                    color: Color(0xFF004249),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Ensure proper spacing
                children: [
                  Expanded( // Allow buttons to adapt to available space
                    child: ElevatedButton(
                      onPressed: _savePreferences,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00848F), // Button background color
                        foregroundColor: Colors.white, // Button text color
                        padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("Save Preferences"),
                    ),
                  ),
                  SizedBox(width: 16.0), // Add space between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _viewPreferences,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004249), // Button background color
                        foregroundColor: Colors.white, // Button text color
                        padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text("View Preferences"),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }}
