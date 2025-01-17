import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagePreferenceScreen extends StatefulWidget {
  const ManagePreferenceScreen({super.key});

  @override
  _ManagePreferenceScreenState createState() => _ManagePreferenceScreenState();
}

class _ManagePreferenceScreenState extends State<ManagePreferenceScreen> {
  String? selectedUniversity;
  RangeValues ageRange = const RangeValues(18, 35);
  String? selectedGender;

  final List<String> universities = [
    "University of Johannesburg",
    "Wits University",
    "University of Cape Town",
    "University of KwaZulu-Natal",
    "University of Pretoria",
    "Nelson Mandela University",
    "Stellenbosch University",
    "North-West University",
    "Rhodes University",
    "University of Limpopo",
  ];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedUniversity = prefs.getString('selectedUniversity');
      ageRange = RangeValues(
        prefs.getDouble('ageRangeStart') ?? 18,
        prefs.getDouble('ageRangeEnd') ?? 35,
      );
      selectedGender = prefs.getString('selectedGender');
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedUniversity', selectedUniversity ?? '');
    await prefs.setDouble('ageRangeStart', ageRange.start);
    await prefs.setDouble('ageRangeEnd', ageRange.end);
    await prefs.setString('selectedGender', selectedGender ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Preferences"),
        backgroundColor: Colors.orangeAccent, // Peach color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Your Preferences",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "University",
                border: OutlineInputBorder(),
              ),
              value: selectedUniversity,
              onChanged: (value) {
                setState(() {
                  selectedUniversity = value;
                });
              },
              items: universities.map((university) {
                return DropdownMenuItem(
                  value: university,
                  child: Text(university),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text("Age Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            RangeSlider(
              values: ageRange,
              min: 18,
              max: 100,
              divisions: 82,
              labels: RangeLabels(
                ageRange.start.toInt().toString(),
                ageRange.end.toInt().toString(),
              ),
              onChanged: (range) {
                setState(() {
                  ageRange = range;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              value: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
              items: ["Male", "Female", "Other"].map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await _savePreferences();
                Navigator.pop(context, {
                  "selectedUniversity": selectedUniversity,
                  "ageRange": ageRange,
                  "selectedGender": selectedGender,
                });
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent), // Peach color
              child: const Text("Save Preferences"),
            ),
          ],
        ),
      ),
    );
  }
}
