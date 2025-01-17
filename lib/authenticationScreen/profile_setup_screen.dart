import 'package:varsitydating/authenticationScreen/profile_image_screen.dart';
// ignore: unused_import
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:varsitydating/controllers/authentication_controller.dart';
import 'package:intl/intl.dart';

import 'package:amplify_flutter/amplify_flutter.dart'; // Keep this for Amplify functionality.
import 'package:varsitydating/models/UserProfile.dart'
    as custom_model; // Prefix this import.

import 'package:shared_preferences/shared_preferences.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  

  // Dropdown variables
  String? selectedCountry;
  String? selectedCity;
  String? selectedUniversity;
  String? selectedCampus;
  String? selectedGender;
  String? selectedHeight;
  String? selectedEthnicity;
  String? selectedSmoke;
  String? selectedDrink;
  String? selectedPersonality;
  String? selectedGenderPreference;

  String? selectedYearofstudy;
  String? selectedCountryCode = '+27'; // Default value for South Africa

  // Controllers for manual entry
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController hobbiesController = TextEditingController();
  final TextEditingController musicController = TextEditingController();
  final TextEditingController lovelanguageController = TextEditingController();
  final TextEditingController lookingforController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController manualUniversityController = TextEditingController();
  final TextEditingController manualCampusController = TextEditingController();

  final TextEditingController studyfieldController = TextEditingController();

  // Error messages
  Map<String, String?> errors = {};

  bool termsAccepted = false;

  bool _validateAll() {
    errors.clear();
    bool isValid = true;

    // Personal Information
    if (nameController.text.isEmpty) {
      errors['name'] = 'Name is required';
      isValid = false;
    }
    if (surnameController.text.isEmpty) {
      errors['surname'] = 'Surname is required';
      isValid = false;
    }
    if (dobController.text.isEmpty) {
      errors['dob'] = 'Date of Birth is required';
      isValid = false;
    } else {
      final DateTime dob = DateFormat('yyyy-MM-dd').parse(dobController.text);
      final int age = DateTime.now().difference(dob).inDays ~/ 365;
      if (age < 18) {
        errors['dob'] = 'You must be 18 years or older';
        isValid = false;
      }
    }
    if (selectedGender == null || selectedGender!.isEmpty) {
      errors['gender'] = 'Gender is required';
      isValid = false;
    }

    // Study Information
    if (selectedCountry == null || selectedCountry!.isEmpty) {
      errors['country'] = 'Country is required';
      isValid = false;
    }
    if (selectedCity == null || selectedCity!.isEmpty) {
      errors['city'] = 'City is required';
      isValid = false;
    }
    if (selectedUniversity == null || selectedUniversity!.isEmpty) {
      errors['university'] = 'University is required';
      isValid = false;
    }
    if (selectedCampus == null || selectedCampus!.isEmpty) {
      errors['campus'] = 'Campus is required';
      isValid = false;
    }
    if (studyfieldController.text.isEmpty) {
      errors['studt field'] = 'Study field is required';
      isValid = false;
    }
    if (selectedYearofstudy == null || selectedYearofstudy!.isEmpty) {
      errors['Year of Study'] = 'Year of study is required';
      isValid = false;
    }

    // Appearance
    if (selectedHeight == null || selectedHeight!.isEmpty) {
      errors['height'] = 'Height is required';
      isValid = false;
    }
    if (selectedEthnicity == null || selectedEthnicity!.isEmpty) {
      errors['ethnicity'] = 'Ethnicity is required';
      isValid = false;
    }

    // Lifestyle
    if (selectedSmoke == null || selectedSmoke!.isEmpty) {
      errors['smoke'] = 'Smoking preference is required';
      isValid = false;
    }
    if (selectedDrink == null || selectedDrink!.isEmpty) {
      errors['drink'] = 'Drinking preference is required';
      isValid = false;
    }
    if (selectedPersonality == null || selectedPersonality!.isEmpty) {
      errors['personality'] = 'Personality is required';
      isValid = false;
    }
    if (hobbiesController.text.isEmpty) {
      errors['hobbies'] = 'Please enter 1 or 2 hobbies';
      isValid = false;
    }
    if (musicController.text.isEmpty) {
      errors['Music'] = 'Please enter a song or genre';
      isValid = false;
    }
    if (lovelanguageController.text.isEmpty) {
      errors['love language'] = 'Love language is required';
      isValid = false;
    }

    // Partner Preference
    if (selectedGenderPreference == null || selectedGenderPreference!.isEmpty) {
      errors['genderPreference'] = 'Gender preference is required';
      isValid = false;
    }
    if (lookingforController.text.isEmpty) {
      errors['lookingFor'] = 'Partner preference is required';
      isValid = false;
    }

    // Contact Details
    if (selectedCountryCode == null || selectedCountryCode!.isEmpty) {
      errors['ountry code'] = 'Country code is required';
      isValid = false;
    }
    if (phoneController.text.isEmpty) {
      errors['phone'] = 'Phone number is required';
      isValid = false;
    }
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+")
        .hasMatch(emailController.text)) {
      errors['email'] = 'A valid email is required';
      isValid = false;
    }

    if (passwordController.text.length < 8) {
      errors['password'] = 'Password must be at least 8 characters long';
      isValid = false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      errors['confirmPassword'] = 'Passwords do not match';
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  // Dropdown options
  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> genderPreference = [
    'Male',
    'Female',
    'Both Male and Female'
  ];
  final List<String> countries = ['South Africa', 'Ghana', 'Nigeria', 'Kenya'];
  final Map<String, List<String>> citiesByCountry = {
    'South Africa': [
      'Johannesburg',
      'Cape Town',
      'Durban',
      'Pretoria',
      'Bloemfontein',
      'Port Elizabeth',
      'Gqeberha',
      'Stellenbosch',
      'Potchefstroom',
      'Polokwane',
      'Mahikeng',
      'Grahamstown',
      'Nelspruit',
      'Mthatha',
      'Alice',
      'Kimberley',
      'Pietermaritzburg'
    ],
    'Ghana': [
      'Accra',
      'Kumasi',
      'Cape Coast',
      'Tamale',
      'Takoradi',
      'Winneba',
      'Ho',
      'Sunyani',
      'Koforidua',
      'Bolgatanga'
    ],
    'Nigeria': [
      'Lagos',
      'Abuja',
      'Ibadan',
      'Zaria',
      'Nsukka',
      'Ife',
      'Maiduguri',
      'Benin City',
      'Ilorin',
      'Port Harcourt',
      'Yola',
      'Abeokuta',
      'Calabar',
      'Ekiti',
      'Jos',
      'Akure',
      'Awka',
      'Uyo',
      'Kano',
      'Kaduna',
      'Owerri',
      'Bauchi',
      'Minna',
      'Makurdi',
      'Ado-Ekiti'
    ],
    'Kenya': [
      'Nairobi',
      'Mombasa',
      'Kisumu',
      'Eldoret',
      'Nakuru',
      'Thika',
      'Meru',
      'Nyeri',
      'Kitale',
      'Machakos'
    ]
  };

  final Map<String, Map<String, List<String>>> universitiesByCity = {
    'South Africa': {
      'Johannesburg': ['University of Johannesburg', 'Wits University'],
      'Cape Town': [
        'University of Cape Town',
        'Cape Peninsula University of Technology'
      ],
      'Durban': [
        'University of KwaZulu-Natal',
        'Durban University of Technology'
      ],
      'Pretoria': [
        'University of Pretoria',
        'Tshwane University of Technology'
      ],
      'Bloemfontein': [
        'University of the Free State',
        'Central University of Technology'
      ],
      'Port Elizabeth': ['Nelson Mandela University'],
      'Gqeberha': ['Nelson Mandela University'],
      'Stellenbosch': ['Stellenbosch University'],
      'Potchefstroom': ['North-West University'],
      'Polokwane': ['University of Limpopo'],
      'Mahikeng': ['North-West University (Mahikeng Campus)'],
      'Grahamstown': ['Rhodes University'],
      'Nelspruit': ['University of Mpumalanga'],
      'Mthatha': ['Walter Sisulu University'],
      'Alice': ['University of Fort Hare'],
      'Kimberley': ['Sol Plaatje University'],
      'Pietermaritzburg': [
        'University of KwaZulu-Natal (Pietermaritzburg Campus)'
      ],
    },
    'Nigeria': {
      'Lagos': ['University of Lagos', 'Lagos State University'],
      'Abuja': ['University of Abuja', 'Nile University of Nigeria'],
      'Ibadan': ['University of Ibadan', 'Lead City University'],
      'Zaria': ['Ahmadu Bello University'],
      'Nsukka': ['University of Nigeria Nsukka'],
      'Ife': ['Obafemi Awolowo University'],
      'Maiduguri': ['University of Maiduguri'],
      'Benin City': ['University of Benin', 'Benson Idahosa University'],
      'Ilorin': ['University of Ilorin', 'Kwara State University'],
      'Port Harcourt': [
        'University of Port Harcourt',
        'Rivers State University'
      ],
      'Yola': [
        'American University of Nigeria',
        'Modibbo Adama University of Technology'
      ],
      'Abeokuta': ['Federal University of Agriculture, Abeokuta'],
      'Calabar': ['University of Calabar'],
      'Ekiti': ['Ekiti State University'],
      'Jos': ['University of Jos'],
      'Akure': ['Federal University of Technology, Akure'],
      'Awka': ['Nnamdi Azikiwe University'],
      'Uyo': ['University of Uyo'],
      'Kano': ['Bayero University Kano'],
      'Kaduna': ['Kaduna State University'],
      'Owerri': ['Federal University of Technology, Owerri'],
      'Bauchi': ['Abubakar Tafawa Balewa University'],
      'Minna': ['Federal University of Technology, Minna'],
      'Makurdi': [
        'Benue State University',
        'Federal University of Agriculture, Makurdi'
      ],
      'Ado-Ekiti': ['Ekiti State University'],
    },
    'Kenya': {
      'Nairobi': [
        'University of Nairobi',
        'Strathmore University',
        'Kenyatta University',
        'United States International University Africa'
      ],
      'Mombasa': ['Technical University of Mombasa'],
      'Kisumu': ['Maseno University'],
      'Eldoret': ['Moi University'],
      'Nakuru': ['Egerton University'],
      'Thika': ['Mount Kenya University'],
      'Meru': ['Meru University of Science and Technology'],
      'Nyeri': ['Dedan Kimathi University of Technology'],
      'Kitale': ['University of Eldoret (Kitale Campus)'],
      'Machakos': ['Machakos University'],
    },
    'Ghana': {
      'Accra': [
        'University of Ghana',
        'Ashesi University',
        'Accra Technical University'
      ],
      'Kumasi': [
        'Kwame Nkrumah University of Science and Technology',
        'Christian Service University College'
      ],
      'Cape Coast': ['University of Cape Coast'],
      'Tamale': ['University for Development Studies'],
      'Takoradi': ['Takoradi Technical University'],
      'Winneba': ['University of Education, Winneba'],
      'Ho': ['Ho Technical University'],
      'Sunyani': ['Sunyani Technical University'],
      'Koforidua': ['Koforidua Technical University'],
      'Bolgatanga': ['Bolgatanga Technical University'],
    },
  };

  final Map<String, List<String>> campusesByUniversity = {
    'University of Johannesburg': [
      'APK Campus',
      'DFC Campus',
      'Soweto Campus',
      'Doornfontein Campus'
    ],
    'Wits University': [
      'East Campus',
      'West Campus',
      'Education Campus',
      'Medical School'
    ],
    'University of Cape Town': [
      'Upper Campus',
      'Middle Campus',
      'Lower Campus',
      'Hiddingh Campus'
    ],
    'Cape Peninsula University of Technology': [
      'District Six Campus',
      'Bellville Campus',
      'Granger Bay Campus',
      'Mowbray Campus'
    ],
    'University of KwaZulu-Natal': [
      'Howard College',
      'Westville Campus',
      'Pietermaritzburg Campus',
      'Nelson R. Mandela School of Medicine'
    ],
    'Durban University of Technology': [
      'Steve Biko Campus',
      'Ritson Campus',
      'Indumiso Campus',
      'Riverside Campus'
    ],
    'University of Pretoria': [
      'Hatfield Campus',
      'Groenkloof Campus',
      'Mamelodi Campus',
      'Prinshof Campus'
    ],
    'Tshwane University of Technology': [
      'Arcadia Campus',
      'Pretoria Campus',
      'Polokwane Campus',
      'Mbombela Campus'
    ],
    'University of the Free State': [
      'Bloemfontein Campus',
      'Qwaqwa Campus',
      'South Campus'
    ],
    'Central University of Technology': [
      'Bloemfontein Campus',
      'Welkom Campus'
    ],
    'Nelson Mandela University': [
      'South Campus',
      'North Campus',
      'Second Avenue Campus',
      'Missionvale Campus'
    ],
    'Stellenbosch University': [
      'Stellenbosch Campus',
      'Tygerberg Campus',
      'Bellville Park Campus'
    ],
    'North-West University': [
      'Potchefstroom Campus',
      'Mahikeng Campus',
      'Vaal Triangle Campus'
    ],
    'University of Limpopo': ['Turfloop Campus', 'Medunsa Campus'],
    'Rhodes University': ['Main Campus (Grahamstown)'],
    'University of Mpumalanga': ['Mbombela Campus', 'Siyabuswa Campus'],
    'Walter Sisulu University': [
      'Mthatha Campus',
      'Buffalo City Campus',
      'Butterworth Campus'
    ],
    'University of Fort Hare': ['Alice Campus', 'East London Campus'],
    'Sol Plaatje University': ['Kimberley Campus'],
    'University of Lagos': ['Akoka Campus', 'Idi-Araba Campus'],
    'Lagos State University': ['Ojo Campus', 'Ikeja Campus', 'Epe Campus'],
    'University of Abuja': ['Main Campus', 'Mini Campus'],
    'Nile University of Nigeria': ['Main Campus (Jabi)'],
    'University of Ibadan': ['Main Campus (Ibadan)'],
    'Lead City University': ['Main Campus (Ibadan)'],
    'Ahmadu Bello University': ['Samaru Campus', 'Kongo Campus'],
    'University of Nigeria Nsukka': ['Nsukka Campus', 'Enugu Campus'],
    'Obafemi Awolowo University': ['Main Campus (Ile-Ife)'],
    'University of Maiduguri': ['Main Campus (Maiduguri)'],
    'University of Benin': ['Ugbowo Campus', 'Ekehuan Campus'],
    'Benson Idahosa University': ['Main Campus (Benin City)'],
    'University of Ilorin': ['Main Campus (Ilorin)'],
    'Kwara State University': ['Malete Campus'],
    'University of Port Harcourt': ['Choba Campus', 'Delta Campus'],
    'Rivers State University': ['Nkpolu Campus'],
    'American University of Nigeria': ['Main Campus (Yola)'],
    'Modibbo Adama University of Technology': ['Girei Campus'],
    'Federal University of Agriculture, Abeokuta': ['Alabata Campus'],
    'University of Calabar': ['Main Campus (Calabar)'],
    'Ekiti State University': ['Ado-Ekiti Campus'],
    'University of Jos': ['Permanent Site Campus', 'Naraguta Campus'],
    'Federal University of Technology, Akure': [
      'Obanla Campus',
      'Akure Campus'
    ],
    'Nnamdi Azikiwe University': ['Awka Campus', 'Nnewi Campus'],
    'University of Uyo': ['Town Campus', 'Annex Campus'],
    'Bayero University Kano': ['Old Campus', 'New Campus'],
    'Kaduna State University': ['Main Campus (Kaduna)', 'Kafanchan Campus'],
    'Federal University of Technology, Owerri': ['Main Campus (Owerri)'],
    'Abubakar Tafawa Balewa University': ['Yelwa Campus', 'Gubi Campus'],
    'Benue State University': ['Main Campus (Makurdi)'],
    'University of Nairobi': [
      'Main Campus',
      'Chiromo Campus',
      'Kikuyu Campus',
      'Lower Kabete Campus'
    ],
    'Strathmore University': ['Madaraka Campus'],
    'Kenyatta University': ['Main Campus (Nairobi)', 'Ruiru Campus'],
    'United States International University Africa': ['Main Campus (Nairobi)'],
    'Technical University of Mombasa': ['Main Campus (Mombasa)'],
    'Maseno University': ['Maseno Campus', 'Kisumu Campus'],
    'Moi University': ['Main Campus (Eldoret)', 'Annex Campus'],
    'Egerton University': ['Njoro Campus', 'Nakuru Town Campus'],
    'Mount Kenya University': ['Thika Main Campus'],
    'Meru University of Science and Technology': ['Main Campus (Meru)'],
    'Dedan Kimathi University of Technology': ['Main Campus (Nyeri)'],
    'University of Eldoret': ['Chepkoilel Campus'],
    'Machakos University': ['Main Campus (Machakos)'],
    'University of Ghana': ['Legon Campus', 'Korle Bu Campus'],
    'Ashesi University': ['Berekuso Campus'],
    'Accra Technical University': ['Main Campus (Accra)'],
    'Kwame Nkrumah University of Science and Technology': ['Kumasi Campus'],
    'Christian Service University College': ['Main Campus (Kumasi)'],
    'University of Cape Coast': ['Cape Coast Campus'],
    'University for Development Studies': ['Tamale Campus'],
    'Takoradi Technical University': ['Takoradi Campus'],
    'University of Education, Winneba': ['Winneba Campus'],
    'Ho Technical University': ['Ho Campus'],
    'Sunyani Technical University': ['Sunyani Campus'],
    'Koforidua Technical University': ['Koforidua Campus'],
    'Bolgatanga Technical University': ['Bolgatanga Campus'],
    // Add similar entries for Ghana, Nigeria, and Kenya
  };

  final authenticationController = AuthenticationController.authController;

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    hobbiesController.dispose();
    musicController.dispose();
    lovelanguageController.dispose();
    lookingforController.dispose();
    manualUniversityController.dispose();
    manualCampusController.dispose();
    studyfieldController.dispose();
    super.dispose();
  }

  // Add the `saveUserProfile` function here
  Future<void> saveUserProfile() async {
    final userProfile = custom_model.UserProfile(
      id: await authenticationController.getCurrentUserId(),
      name: nameController.text.trim(),
      surname: surnameController.text.trim(),
      dob: TemporalDate(DateTime.parse(dobController.text.trim())),
      gender: selectedGender!,
      country: selectedCountry!,
      city: selectedCity,
      university: selectedUniversity,
      campus: selectedCampus,
      studyField: studyfieldController.text.trim(),
      yearOfStudy: selectedYearofstudy,
      height: selectedHeight,
      ethnicity: selectedEthnicity,
      smokingPreference: selectedSmoke,
      drinkingPreference: selectedDrink,
      personality: selectedPersonality,
      hobbies: hobbiesController.text.trim(),
      musicPreference: musicController.text.trim(),
      loveLanguage: lovelanguageController.text.trim(),
      partnerPreference: selectedGenderPreference,
      phoneNumber: phoneController.text.trim(),
      email: emailController.text.trim(),
      isProfileComplete: true, profileImageURLs: [],
    );

    try {
      // Save the user profile to Amplify
      await Amplify.DataStore.save(userProfile);

      // Mark profile setup as complete in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isProfileSetupComplete', true);

      // Upload profile data to S3 bucket
      final profileData = userProfile.toJson().toString();
      await Amplify.Storage.uploadString(
        key: 'profiles/${userProfile.id}.json',
        body: profileData,

      );

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile saved successfully!")),
      );
    } catch (e) {
      // Handle errors during the save process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save profile: $e")),
      );
    }
  }

  Future<void> markProfileSetupComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isProfileSetupComplete', true);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),

            const Text(
              "Create A Profile",
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16.0),

            //Personal Information
            const Text(
              "PERSONAL INFORMATION",
              style: TextStyle(
                color: Color.fromARGB(255, 241, 141, 47),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            // Name
            const Text(
              'NAME',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name *',
                errorText: errors['Enter valid name'],
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 22),

            // Surname
            const Text(
              'SURNAME',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(
                labelText: 'Surname *',
                errorText: errors['Enter valid surname'],
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 22),

            // Birthday with Date Picker
            TextField(
              controller: dobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date of Birth *',
                errorText: errors['Student must be 18 years or older'],
                border: const OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    dobController.text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
            ),

            const SizedBox(height: 22),

            // Gender Dropdown
            /*SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: DropdownButtonFormField<String>(
                value: genderEditingController.text.isEmpty
                    ? null
                    : genderEditingController.text,
                items: genderOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    genderEditingController.text = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "GENDER",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
            ),*/
            DropdownButtonFormField<String>(
              value: selectedGender,
              items: ['Male', 'Female'].map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Gender *',
                errorText: errors['Enter valid gender'],
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 22),

            //Study Information
            const Text(
              "STUDY INFORMATION",
              style: TextStyle(
                color: Color.fromARGB(255, 241, 141, 47),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16.0),

            const Text(
              'Select Your Country *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCountry,
              isExpanded: true,
              items: countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCountry = value;
                  selectedCity = null;
                  selectedUniversity = null;
                  selectedCampus = null;
                });
              },
            ),
            const SizedBox(height: 16.0),

            if (selectedCountry != null) ...[
              const Text(
                'Select Your City *',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedCity,
                isExpanded: true,
                items: citiesByCountry[selectedCountry]!.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCity = value;
                    selectedUniversity = null;
                    selectedCampus = null;
                  });
                },
              ),
              const SizedBox(height: 16.0),
            ],

            if (selectedCity != null) ...[
              const Text(
                'Select Your University/College *',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedUniversity,
                isExpanded: true,
                items: universitiesByCity[selectedCountry!]![selectedCity]!
                    .map((String university) {
                  return DropdownMenuItem<String>(
                    value: university,
                    child: Text(university),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedUniversity = value;
                    selectedCampus = null;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              if (selectedUniversity == null) ...[
                TextField(
                  controller: manualUniversityController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your University/College *',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ],

            if (selectedUniversity != null ||
                manualUniversityController.text.isNotEmpty) ...[
              const Text(
                'Select Your Campus *',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedCampus,
                isExpanded: true,
                items: campusesByUniversity[selectedUniversity]!
                    .map((String campus) {
                  return DropdownMenuItem<String>(
                    value: campus,
                    child: Text(campus),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCampus = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              if (selectedCampus == null) ...[
                TextField(
                  controller: manualCampusController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your Campus *',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ],

            // Study Field
            const Text(
              'Study Field *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: studyfieldController,
              decoration: const InputDecoration(
                labelText: 'Enter Field of Study *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20.0),

            // Year of Study
            const Text(
              'Year of Study *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedYearofstudy,
              isExpanded: true,
              items: ['1', '2', '3', '4', '5', '6'].map((String yearofstudy) {
                return DropdownMenuItem<String>(
                  value: yearofstudy,
                  child: Text(yearofstudy),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedYearofstudy = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            //Appearance
            const Text(
              "APPEARANCE",
              style: TextStyle(
                color: Color.fromARGB(255, 241, 141, 47),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16.0),

            // Height
            const Text(
              'Height *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedHeight,
              isExpanded: true,
              items: ['Tall', 'Short', 'Average'].map((String height) {
                return DropdownMenuItem<String>(
                  value: height,
                  child: Text(height),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedHeight = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Ethnicity
            const Text(
              'Ethnicity *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedEthnicity,
              isExpanded: true,
              items: ['African', 'White', 'Coloured', 'Indian']
                  .map((String ethnicity) {
                return DropdownMenuItem<String>(
                  value: ethnicity,
                  child: Text(ethnicity),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedEthnicity = value;
                });
              },
            ),
            const SizedBox(height: 20.0),

            //Life Stle
            const Text(
              "LIFE STYLE",
              style: TextStyle(
                color: Color.fromARGB(255, 241, 141, 47),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16.0),

            // Smoke
            const Text(
              'Smoke *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedSmoke,
              isExpanded: true,
              items: ['Yes', 'No', 'Occasionally'].map((String smoke) {
                return DropdownMenuItem<String>(
                  value: smoke,
                  child: Text(smoke),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedSmoke = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Drink
            const Text(
              'Drink *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedDrink,
              isExpanded: true,
              items: ['Yes', 'No', 'Ocassionally'].map((String drink) {
                return DropdownMenuItem<String>(
                  value: drink,
                  child: Text(drink),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedDrink = value;
                });
              },
            ),
            const SizedBox(height: 16.0),

            // Personality
            const Text(
              'Pesonality *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedPersonality,
              isExpanded: true,
              items: ['Introvert', 'Extrovert', 'Ambivert']
                  .map((String personality) {
                return DropdownMenuItem<String>(
                  value: personality,
                  child: Text(personality),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedPersonality = value;
                });
              },
            ),
            const SizedBox(height: 20.0),

            // Hobbies
            const Text(
              'Hobbies *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: hobbiesController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Hobbies *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),

            // music
            const Text(
              'Music *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: musicController,
              decoration: const InputDecoration(
                labelText: 'What kind of music do you listen to *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),

            // Love Language
            const Text(
              'Love Language *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: lovelanguageController,
              decoration: const InputDecoration(
                labelText: 'What is your love language *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20.0),

            //Partner preferences
            const Text(
              "PARTNER PREFERENCES",
              style: TextStyle(
                color: Color.fromARGB(255, 241, 141, 47),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16.0),

            // Gender Preference
            DropdownButtonFormField<String>(
              value: selectedGenderPreference,
              items: ['Male', 'Female', 'Both Male and Female']
                  .map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGenderPreference = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Gender Preference *',
                errorText: errors['Enter valid gender'],
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16.0),

            // What are you look for in a partner
            const Text(
              'Partner *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: lookingforController,
              decoration: const InputDecoration(
                labelText: 'What are you looking for in a partner *',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20.0),

            // Profile Picture Upload Section

            /*const Text(
              'UPLOAD PROFILE IMAGE',
              style: TextStyle(
                color: Color.fromARGB(255, 241, 141, 47),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await authenticationController.pickImageFileFromGallery();

                setState(() {
                  authenticationController.imageFile;
                });

                // Add image picker logic here
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _profileImage != null
                    ? FileImage(
                        File(
                          authenticationController.imageFile!.path,
                        ),
                      )
                    : AssetImage('assets/default_profile.png') as ImageProvider,
              ),
            ),

            // Add this variable to track the uploaded profile image URL

// Inside your build method, replace the Profile Picture section:
            const Text(
              "PROFILE PICTURE",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 241, 141, 47),
              ),
            ),
            const SizedBox(height: 16.0),

// Use the ProfileImageUploader widget and display the uploaded image
            Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    const Text(
      "PROFILE PICTURE",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 241, 141, 47),
      ),
    ),
    const SizedBox(height: 16.0),
    GestureDetector(
      onTap: () => _pickImage(ImageSource.gallery), // Pick image from gallery
      child: CircleAvatar(
        radius: 60,
        backgroundImage: _selectedImage != null
            ? FileImage(_selectedImage!)
            : const AssetImage('images/default_profile_image.png'),
      ),
    ),
    const SizedBox(height: 16.0),
    ElevatedButton.icon(
      onPressed: () => _pickImage(ImageSource.camera), // Capture image with camera
      icon: const Icon(Icons.camera),
      label: const Text("Take a Picture"),
    ),
    ElevatedButton.icon(
      onPressed: () => _pickImage(ImageSource.gallery), // Select from gallery
      icon: const Icon(Icons.photo_library),
      label: const Text("Choose from Gallery"),
    ),
  ],
),*/

            const SizedBox(height: 20.0),

            //Confirm Details
            const Text(
              "CONFIRM DETAILS",
              style: TextStyle(
                color: Color.fromARGB(255, 241, 141, 47),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16.0),

            // Phone Number with Country Code Dropdown
            SizedBox(
              width: screenWidth - 30,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: selectedCountryCode,
                      items: [
                        {'name': 'South Africa', 'code': '+27'},
                        {'name': 'Nigeria', 'code': '+234'},
                        {'name': 'Kenya', 'code': '+254'},
                        {'name': 'Ghana', 'code': '+233'},
                      ].map((country) {
                        return DropdownMenuItem<String>(
                          value:
                              country['code'], // Capture only the country code
                          child: Text(
                            screenWidth > 400
                                ? '${country['code']} ${country['name']}' // Show both if there's enough space
                                : country[
                                    'code']!, // Show only the code if space is limited
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountryCode = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: "CODE",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "PHONE NUMBER",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ), //might need to use ; instead of ,

            const SizedBox(height: 16.0),

            // Email Address
            const Text(
              'Email Address *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Email Address *',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),

            // Password
            const Text(
              'Password *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Password *',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),

            // Confirm Password
            const Text(
              'Confirm Password *',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Your Password *',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),

            // Terms & Conditions
            Row(
              children: [
                Checkbox(
                  value: termsAccepted,
                  onChanged: (bool? value) {
                    setState(() {
                      termsAccepted = value!;
                    });
                  },
                ),
                const Text(
                  'I accept the Terms and Conditions *',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Terms and Conditions Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "By pressing Submit and Continue, you agree to our Terms and Conditions and Privacy Policy.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Submit & Continue Button
            ElevatedButton(
              onPressed: () async {
                if (_validateAll()) {
                  try {
                    await saveUserProfile();
                    await markProfileSetupComplete();

                    // Show a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        bool rulesAcknowledged = false;

                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: const Text("Please Read the Rules"),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "By proceeding, you agree to follow these rules:\n\n"
                                      "1. Provide accurate and truthful information.\n"
                                      "2. Ensure your profile adheres to community guidelines.\n"
                                      "3. Respect privacy and avoid sharing sensitive data.\n"
                                      "\nFailure to follow these rules may result in account suspension.",
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: rulesAcknowledged,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              rulesAcknowledged =
                                                  value ?? false;
                                            });
                                          },
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "I acknowledge and accept the rules.",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: rulesAcknowledged
                                      ? () {
                                          Navigator.of(context).pop();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileImageScreen(),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: const Text("Proceed"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  } catch (e) {
                    // Handle errors during saving
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error saving profile: $e")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Please fill in all required fields")),
                  );
                }
              },
              child: const Text("Submit & Continue"),
            ),
          ],
        ),
      ),
    );
  }
}

extension on StorageCategory {
  uploadString({required String key, required String body}) {}
}
