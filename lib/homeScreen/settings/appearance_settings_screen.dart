import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  _AppearanceSettingsScreenState createState() => _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {
  bool isDarkMode = false;
  Color selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      final colorValue = prefs.getInt('selectedColor') ?? Colors.blue.value;
      selectedColor = Color(colorValue);
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    await prefs.setInt('selectedColor', selectedColor.value);
  }

  void _changeThemeColor(Color color) {
    setState(() {
      selectedColor = color;
    });
    _saveSettings();
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedColor,
        title: Row(
          children: [
            Image.asset(
              'images/logo.png',
              height: 40,
            ),
            const SizedBox(width: 8.0),
            Text(
              'Appearance Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[850],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize Appearance',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Mode', style: TextStyle(fontSize: 16.0)),
                Switch(
                  value: isDarkMode,
                  onChanged: _toggleDarkMode,
                  activeColor: selectedColor,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Theme Color',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                _buildColorPicker(Colors.blue),
                _buildColorPicker(Colors.red),
                _buildColorPicker(Colors.green),
                _buildColorPicker(Colors.purple),
                _buildColorPicker(Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker(Color color) {
    return GestureDetector(
      onTap: () => _changeThemeColor(color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selectedColor == color
              ? Border.all(color: Colors.black, width: 2.0)
              : null,
        ),
      ),
    );
  }
}
