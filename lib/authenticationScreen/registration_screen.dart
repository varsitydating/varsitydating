import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:varsitydating/authenticationScreen/profile_setup_screen.dart';
import 'package:varsitydating/controllers/authentication_controller.dart';
import 'package:varsitydating/widgets/login_buttons_widget.dart';
// ignore: unused_import

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers for text fields
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController surnameEditingController = TextEditingController();
  TextEditingController birthdayEditingController = TextEditingController();
  TextEditingController genderEditingController = TextEditingController();
  TextEditingController countryEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController schoolEditingController = TextEditingController();
  TextEditingController campusEditingController = TextEditingController();

  final List<String> genderOptions = ['Male', 'Female', 'Non-Binary', 'Other'];
  final List<String> countries = ['South Africa', 'Nigeria', 'Kenya', 'Ghana'];
  Map<String, List<String>> cities = {
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
    ],
  };

  Map<String, Map<String, List<String>>> universities = {
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
    // Add other countries and cities
  };

  String? selectedCountry;
  String? selectedCity;
  String? selectedUniversity;
  String? selectedCountryCode = '+27'; // Default value for South Africa

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),

              //image cirlce avatar
              GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("images/Profile.png"),
                  backgroundColor: Colors.black,
                ),
              ),

              const SizedBox(height: 100),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 50),

              // Name
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: LoginButtonsWidget(
                  editingController: nameEditingController,
                  labelText: "NAME",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
              ),

              const SizedBox(height: 22),

              // Surname
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: LoginButtonsWidget(
                  editingController: surnameEditingController,
                  labelText: "SURNAME",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
              ),

              const SizedBox(height: 22),

              // Birthday with Date Picker
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: TextField(
                  controller: birthdayEditingController,
                  decoration: const InputDecoration(
                    labelText: "BIRTHDAY",
                    prefixIcon: Icon(Icons.cake),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy/MM/dd').format(pickedDate);
                      setState(() {
                        birthdayEditingController.text = formattedDate;
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Gender Dropdown
              SizedBox(
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
              ),

              const SizedBox(height: 22),

              // Country Dropdown
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: DropdownButtonFormField<String>(
                  value: selectedCountry,
                  items: countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCountry = newValue;
                      selectedCity = null;
                      selectedUniversity = null;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "COUNTRY",
                    prefixIcon: Icon(Icons.flag),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // City Dropdown (Dependent on Country)
              if (selectedCountry != null)
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: DropdownButtonFormField<String>(
                    value: selectedCity,
                    items: cities[selectedCountry!]!.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue;
                        selectedUniversity = null;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "CITY",
                      prefixIcon: Icon(Icons.location_city),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              const SizedBox(height: 22),

              // University/College Dropdown (Dependent on City)
              if (selectedCity != null)
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: DropdownButtonFormField<String>(
                    value: selectedUniversity,
                    items: universities[selectedCountry!]![selectedCity!]!
                        .map((String university) {
                      return DropdownMenuItem<String>(
                        value: university,
                        child: Text(university),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUniversity = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "UNIVERSITY/COLLEGE",
                      prefixIcon: Icon(Icons.school),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

              const SizedBox(height: 22),

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
                            value: country[
                                'code'], // Capture only the country code
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
                        controller: phoneEditingController,
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

              const SizedBox(height: 15),

              // Email with Validation
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: TextField(
                  controller: emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "EMAIL",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                        .hasMatch(value)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a valid email address."),
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height: 22),

              // Password
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: TextField(
                  controller: passwordEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "PASSWORD",
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Continue Button
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameEditingController.text.isEmpty ||
                        surnameEditingController.text.isEmpty ||
                        birthdayEditingController.text.isEmpty ||
                        genderEditingController.text.isEmpty ||
                        emailEditingController.text.isEmpty ||
                        passwordEditingController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all required fields."),
                        ),
                      );
                    } else {
                      // Show the rules agreement dialog
                      _showRulesAgreementDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: const Text("Create Account"),
                ),
              ),

              const SizedBox(height: 15),

              // Already Have an Account Button
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to login
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text("ALREADY HAVE AN ACCOUNT?"),
                ),
              ),

              const SizedBox(height: 50),

              // Terms and Conditions Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "By creating an account, you agree to our Terms and Conditions and Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showRulesAgreementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Community Rules"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("1. Be respectful to others."),
                SizedBox(height: 10),
                Text("2. No offensive or discriminatory language."),
                SizedBox(height: 10),
                Text("3. Profile information must be accurate."),
                SizedBox(height: 10),
                Text("4. Respect other users' privacy."),
                SizedBox(height: 10),
                Text("5. Do not share inappropriate content."),
                SizedBox(height: 10),
                Text("6. Any misuse will result in account suspension."),
                SizedBox(height: 10),
                Text(
                  "By clicking Agree, you confirm you will abide by these rules.",
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _navigateToProfileSetup(); // Proceed to profile setup
              },
              child: const Text("Agree"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToProfileSetup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
    );
  }
}
