import 'package:flutter/material.dart';
import 'package:varsitydating/controllers/authentication_controller.dart';
import 'package:amplify_flutter/amplify_flutter.dart'; // For Amplify functionality.
import 'package:intl/intl.dart';
import 'package:varsitydating/models/UserProfile.dart' as custom_model;

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({super.key});

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  // Controllers for editable fields
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController studyFieldController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController musicController = TextEditingController();
  TextEditingController loveLanguageController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();

  // Dropdown values
  String? selectedCountry;
  String? selectedCity;
  String? selectedUniversity;
  String? selectedCampus;
  String? selectedYearOfStudy;
  String? selectedHeight;
  String? selectedEthnicity;
  String? selectedSmoke;
  String? selectedDrink;
  String? selectedPersonality;
  String? selectedGenderPreference;

  // Static values for non-editable fields
  String dateOfBirth = "";
  String gender = "";

  // Fetch user data from AWS
  Future<void> fetchUserData() async {
    try {
      final userId = await AuthenticationController.authController.getCurrentUserId();
      final userProfile = await Amplify.DataStore.query(
        custom_model.UserProfile.classType,
        where: custom_model.UserProfile.ID.eq(userId),
      );

      if (userProfile.isNotEmpty) {
        final profile = userProfile.first;
        setState(() {
          nameController.text = profile.name;
          surnameController.text = profile.surname;
          dateOfBirth = DateFormat('yyyy-MM-dd').format(profile.dob!.getDateTime());
          gender = profile.gender;
          selectedCountry = profile.country;
          selectedCity = profile.city;
          selectedUniversity = profile.university;
          selectedCampus = profile.campus;
          studyFieldController.text = profile.studyField ?? "";
          selectedYearOfStudy = profile.yearOfStudy;
          selectedHeight = profile.height;
          selectedEthnicity = profile.ethnicity;
          selectedSmoke = profile.smokingPreference;
          selectedDrink = profile.drinkingPreference;
          selectedPersonality = profile.personality;
          hobbiesController.text = profile.hobbies ?? "";
          musicController.text = profile.musicPreference ?? "";
          loveLanguageController.text = profile.loveLanguage ?? "";
          selectedGenderPreference = profile.partnerPreference;
          lookingForController.text = profile.partnerDescription ?? "";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching user data: $e")),
      );
    }
  }

  // Save updated user data to AWS
  Future<void> saveUserData() async {
    try {
      final userId = await AuthenticationController.authController.getCurrentUserId();

      final updatedProfile = custom_model.UserProfile(
        id: userId,
        name: nameController.text.trim(),
        surname: surnameController.text.trim(),
        dob: TemporalDate(DateTime.parse(dateOfBirth)),
        gender: gender,
        country: selectedCountry ?? "Unknown",
        city: selectedCity ?? "",
        university: selectedUniversity ?? "",
        campus: selectedCampus ?? "",
        studyField: studyFieldController.text.trim(),
        yearOfStudy: selectedYearOfStudy ?? "",
        height: selectedHeight ?? "",
        ethnicity: selectedEthnicity ?? "",
        smokingPreference: selectedSmoke ?? "",
        drinkingPreference: selectedDrink ?? "",
        personality: selectedPersonality ?? "",
        hobbies: hobbiesController.text.trim(),
        musicPreference: musicController.text.trim(),
        loveLanguage: loveLanguageController.text.trim(),
        partnerPreference: selectedGenderPreference ?? "",
        partnerDescription: lookingForController.text.trim(),
        phoneNumber: "PlaceholderPhoneNumber",
        email: "PlaceholderEmail",
        isProfileComplete: true, profileImageURLs: [],
      );

      await Amplify.DataStore.save(updatedProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving profile data: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "PERSONAL INFORMATION",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // Name
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Surname
            TextField(
              controller: surnameController,
              decoration: const InputDecoration(
                labelText: 'Surname',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Date of Birth
            TextField(
              controller: TextEditingController(text: dateOfBirth),
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                border: const OutlineInputBorder(),
                helperText: gender == "Male"
                    ? "Unfortunately you can’t be born twice, Loverboy."
                    : "Unfortunately you can’t be born twice, Lovergirl.",
              ),
            ),
            const SizedBox(height: 16.0),

            // Study Information
            const Text(
              "STUDY INFORMATION",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            // Country
            DropdownButtonFormField<String>(
              value: selectedCountry,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
              items: ["South Africa", "Nigeria", "Kenya", "Ghana"]
                  .map((country) => DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // University
DropdownButtonFormField<String>(
  value: selectedUniversity,
  decoration: const InputDecoration(
    labelText: 'University',
    border: OutlineInputBorder(),
  ),
  items: [
    'University of Johannesburg',
    'Wits University',
    'University of Cape Town'
  ].map((university) => DropdownMenuItem(
        value: university,
        child: Text(university),
      ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedUniversity = value;
    });
  },
),
const SizedBox(height: 16.0),

// Year of Study
DropdownButtonFormField<String>(
  value: selectedYearOfStudy,
  decoration: const InputDecoration(
    labelText: 'Year of Study',
    border: OutlineInputBorder(),
  ),
  items: ['1', '2', '3', '4', '5', '6']
      .map((year) => DropdownMenuItem(
            value: year,
            child: Text(year),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedYearOfStudy = value;
    });
  },
),
const SizedBox(height: 16.0),

// Appearance
const Text(
  "APPEARANCE",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
const SizedBox(height: 16.0),

// Height
DropdownButtonFormField<String>(
  value: selectedHeight,
  decoration: const InputDecoration(
    labelText: 'Height',
    border: OutlineInputBorder(),
  ),
  items: ['Tall', 'Short', 'Average']
      .map((height) => DropdownMenuItem(
            value: height,
            child: Text(height),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedHeight = value;
    });
  },
),
const SizedBox(height: 16.0),

// Ethnicity
DropdownButtonFormField<String>(
  value: selectedEthnicity,
  decoration: const InputDecoration(
    labelText: 'Ethnicity',
    border: OutlineInputBorder(),
  ),
  items: ['African', 'White', 'Coloured', 'Indian']
      .map((ethnicity) => DropdownMenuItem(
            value: ethnicity,
            child: Text(ethnicity),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedEthnicity = value;
    });
  },
),
const SizedBox(height: 16.0),

// Lifestyle
const Text(
  "LIFESTYLE",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
const SizedBox(height: 16.0),

// Smoke
DropdownButtonFormField<String>(
  value: selectedSmoke,
  decoration: const InputDecoration(
    labelText: 'Do you smoke?',
    border: OutlineInputBorder(),
  ),
  items: ['Yes', 'No', 'Occasionally']
      .map((smoke) => DropdownMenuItem(
            value: smoke,
            child: Text(smoke),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedSmoke = value;
    });
  },
),
const SizedBox(height: 16.0),

// Drink
DropdownButtonFormField<String>(
  value: selectedDrink,
  decoration: const InputDecoration(
    labelText: 'Do you drink?',
    border: OutlineInputBorder(),
  ),
  items: ['Yes', 'No', 'Occasionally']
      .map((drink) => DropdownMenuItem(
            value: drink,
            child: Text(drink),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedDrink = value;
    });
  },
),
const SizedBox(height: 16.0),

// Personality
DropdownButtonFormField<String>(
  value: selectedPersonality,
  decoration: const InputDecoration(
    labelText: 'Personality',
    border: OutlineInputBorder(),
  ),
  items: ['Introvert', 'Extrovert', 'Ambivert']
      .map((personality) => DropdownMenuItem(
            value: personality,
            child: Text(personality),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedPersonality = value;
    });
  },
),
const SizedBox(height: 16.0),

// Hobbies
TextField(
  controller: hobbiesController,
  decoration: const InputDecoration(
    labelText: 'Hobbies',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 16.0),

// Music
TextField(
  controller: musicController,
  decoration: const InputDecoration(
    labelText: 'Music Preference',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 16.0),

// Love Language
TextField(
  controller: loveLanguageController,
  decoration: const InputDecoration(
    labelText: 'Love Language',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 16.0),

// Partner Preferences
const Text(
  "PARTNER PREFERENCES",
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
const SizedBox(height: 16.0),

// Gender Preference
DropdownButtonFormField<String>(
  value: selectedGenderPreference,
  decoration: const InputDecoration(
    labelText: 'Gender Preference',
    border: OutlineInputBorder(),
  ),
  items: ['Male', 'Female', 'Both']
      .map((genderPreference) => DropdownMenuItem(
            value: genderPreference,
            child: Text(genderPreference),
          ))
      .toList(),
  onChanged: (value) {
    setState(() {
      selectedGenderPreference = value;
    });
  },
),
const SizedBox(height: 16.0),

// Looking For
TextField(
  controller: lookingForController,
  decoration: const InputDecoration(
    labelText: 'What are you looking for in a partner?',
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 16.0),

ElevatedButton(
  onPressed: () {
    saveUserData();
  },
  child: const Text("Save Changes"),
),
          ],
        ),
      ),
    );
  }
}
