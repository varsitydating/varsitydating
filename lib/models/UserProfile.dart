/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the UserProfile type in your schema. */
class UserProfile extends amplify_core.Model {
  static const classType = const _UserProfileModelType();
  final String id;
  final String? _name;
  final String? _surname;
  final amplify_core.TemporalDate? _dob;
  final String? _gender;
  final String? _partnerDescription;
  final String? _country;
  final String? _city;
  final String? _university;
  final String? _campus;
  final String? _studyField;
  final String? _yearOfStudy;
  final String? _height;
  final String? _ethnicity;
  final String? _smokingPreference;
  final String? _drinkingPreference;
  final String? _personality;
  final String? _hobbies;
  final String? _musicPreference;
  final String? _loveLanguage;
  final String? _partnerPreference;
  final String? _profileImageURL;
  final String? _phoneNumber;
  final String? _email;
  final bool? _isProfileComplete;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserProfileModelIdentifier get modelIdentifier {
      return UserProfileModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get surname {
    try {
      return _surname!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDate? get dob {
    return _dob;
  }
  
  String get gender {
    try {
      return _gender!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get partnerDescription {
    return _partnerDescription;
  }
  
  String get country {
    try {
      return _country!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get city {
    return _city;
  }
  
  String? get university {
    return _university;
  }
  
  String? get campus {
    return _campus;
  }
  
  String? get studyField {
    return _studyField;
  }
  
  String? get yearOfStudy {
    return _yearOfStudy;
  }
  
  String? get height {
    return _height;
  }
  
  String? get ethnicity {
    return _ethnicity;
  }
  
  String? get smokingPreference {
    return _smokingPreference;
  }
  
  String? get drinkingPreference {
    return _drinkingPreference;
  }
  
  String? get personality {
    return _personality;
  }
  
  String? get hobbies {
    return _hobbies;
  }
  
  String? get musicPreference {
    return _musicPreference;
  }
  
  String? get loveLanguage {
    return _loveLanguage;
  }
  
  String? get partnerPreference {
    return _partnerPreference;
  }
  
  String? get profileImageURL {
    return _profileImageURL;
  }
  
  String get phoneNumber {
    try {
      return _phoneNumber!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get isProfileComplete {
    try {
      return _isProfileComplete!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserProfile._internal({required this.id, required name, required surname, dob, required gender, partnerDescription, required country, city, university, campus, studyField, yearOfStudy, height, ethnicity, smokingPreference, drinkingPreference, personality, hobbies, musicPreference, loveLanguage, partnerPreference, profileImageURL, required phoneNumber, required email, required isProfileComplete, createdAt, updatedAt}): _name = name, _surname = surname, _dob = dob, _gender = gender, _partnerDescription = partnerDescription, _country = country, _city = city, _university = university, _campus = campus, _studyField = studyField, _yearOfStudy = yearOfStudy, _height = height, _ethnicity = ethnicity, _smokingPreference = smokingPreference, _drinkingPreference = drinkingPreference, _personality = personality, _hobbies = hobbies, _musicPreference = musicPreference, _loveLanguage = loveLanguage, _partnerPreference = partnerPreference, _profileImageURL = profileImageURL, _phoneNumber = phoneNumber, _email = email, _isProfileComplete = isProfileComplete, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserProfile({String? id, required String name, required String surname, amplify_core.TemporalDate? dob, required String gender, String? partnerDescription, required String country, String? city, String? university, String? campus, String? studyField, String? yearOfStudy, String? height, String? ethnicity, String? smokingPreference, String? drinkingPreference, String? personality, String? hobbies, String? musicPreference, String? loveLanguage, String? partnerPreference, String? profileImageURL, required String phoneNumber, required String email, required bool isProfileComplete, required List<String> profileImageURLs}) {
    return UserProfile._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      surname: surname,
      dob: dob,
      gender: gender,
      partnerDescription: partnerDescription,
      country: country,
      city: city,
      university: university,
      campus: campus,
      studyField: studyField,
      yearOfStudy: yearOfStudy,
      height: height,
      ethnicity: ethnicity,
      smokingPreference: smokingPreference,
      drinkingPreference: drinkingPreference,
      personality: personality,
      hobbies: hobbies,
      musicPreference: musicPreference,
      loveLanguage: loveLanguage,
      partnerPreference: partnerPreference,
      profileImageURL: profileImageURL,
      phoneNumber: phoneNumber,
      email: email,
      isProfileComplete: isProfileComplete);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserProfile &&
      id == other.id &&
      _name == other._name &&
      _surname == other._surname &&
      _dob == other._dob &&
      _gender == other._gender &&
      _partnerDescription == other._partnerDescription &&
      _country == other._country &&
      _city == other._city &&
      _university == other._university &&
      _campus == other._campus &&
      _studyField == other._studyField &&
      _yearOfStudy == other._yearOfStudy &&
      _height == other._height &&
      _ethnicity == other._ethnicity &&
      _smokingPreference == other._smokingPreference &&
      _drinkingPreference == other._drinkingPreference &&
      _personality == other._personality &&
      _hobbies == other._hobbies &&
      _musicPreference == other._musicPreference &&
      _loveLanguage == other._loveLanguage &&
      _partnerPreference == other._partnerPreference &&
      _profileImageURL == other._profileImageURL &&
      _phoneNumber == other._phoneNumber &&
      _email == other._email &&
      _isProfileComplete == other._isProfileComplete;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserProfile {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("surname=" + "$_surname" + ", ");
    buffer.write("dob=" + (_dob != null ? _dob.format() : "null") + ", ");
    buffer.write("gender=" + "$_gender" + ", ");
    buffer.write("partnerDescription=" + "$_partnerDescription" + ", ");
    buffer.write("country=" + "$_country" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("university=" + "$_university" + ", ");
    buffer.write("campus=" + "$_campus" + ", ");
    buffer.write("studyField=" + "$_studyField" + ", ");
    buffer.write("yearOfStudy=" + "$_yearOfStudy" + ", ");
    buffer.write("height=" + "$_height" + ", ");
    buffer.write("ethnicity=" + "$_ethnicity" + ", ");
    buffer.write("smokingPreference=" + "$_smokingPreference" + ", ");
    buffer.write("drinkingPreference=" + "$_drinkingPreference" + ", ");
    buffer.write("personality=" + "$_personality" + ", ");
    buffer.write("hobbies=" + "$_hobbies" + ", ");
    buffer.write("musicPreference=" + "$_musicPreference" + ", ");
    buffer.write("loveLanguage=" + "$_loveLanguage" + ", ");
    buffer.write("partnerPreference=" + "$_partnerPreference" + ", ");
    buffer.write("profileImageURL=" + "$_profileImageURL" + ", ");
    buffer.write("phoneNumber=" + "$_phoneNumber" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("isProfileComplete=" + (_isProfileComplete != null ? _isProfileComplete.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserProfile copyWith({String? name, String? surname, amplify_core.TemporalDate? dob, String? gender, String? partnerDescription, String? country, String? city, String? university, String? campus, String? studyField, String? yearOfStudy, String? height, String? ethnicity, String? smokingPreference, String? drinkingPreference, String? personality, String? hobbies, String? musicPreference, String? loveLanguage, String? partnerPreference, String? profileImageURL, String? phoneNumber, String? email, bool? isProfileComplete}) {
    return UserProfile._internal(
      id: id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      partnerDescription: partnerDescription ?? this.partnerDescription,
      country: country ?? this.country,
      city: city ?? this.city,
      university: university ?? this.university,
      campus: campus ?? this.campus,
      studyField: studyField ?? this.studyField,
      yearOfStudy: yearOfStudy ?? this.yearOfStudy,
      height: height ?? this.height,
      ethnicity: ethnicity ?? this.ethnicity,
      smokingPreference: smokingPreference ?? this.smokingPreference,
      drinkingPreference: drinkingPreference ?? this.drinkingPreference,
      personality: personality ?? this.personality,
      hobbies: hobbies ?? this.hobbies,
      musicPreference: musicPreference ?? this.musicPreference,
      loveLanguage: loveLanguage ?? this.loveLanguage,
      partnerPreference: partnerPreference ?? this.partnerPreference,
      profileImageURL: profileImageURL ?? this.profileImageURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete);
  }
  
  UserProfile copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<String>? surname,
    ModelFieldValue<amplify_core.TemporalDate?>? dob,
    ModelFieldValue<String>? gender,
    ModelFieldValue<String?>? partnerDescription,
    ModelFieldValue<String>? country,
    ModelFieldValue<String?>? city,
    ModelFieldValue<String?>? university,
    ModelFieldValue<String?>? campus,
    ModelFieldValue<String?>? studyField,
    ModelFieldValue<String?>? yearOfStudy,
    ModelFieldValue<String?>? height,
    ModelFieldValue<String?>? ethnicity,
    ModelFieldValue<String?>? smokingPreference,
    ModelFieldValue<String?>? drinkingPreference,
    ModelFieldValue<String?>? personality,
    ModelFieldValue<String?>? hobbies,
    ModelFieldValue<String?>? musicPreference,
    ModelFieldValue<String?>? loveLanguage,
    ModelFieldValue<String?>? partnerPreference,
    ModelFieldValue<String?>? profileImageURL,
    ModelFieldValue<String>? phoneNumber,
    ModelFieldValue<String>? email,
    ModelFieldValue<bool>? isProfileComplete
  }) {
    return UserProfile._internal(
      id: id,
      name: name == null ? this.name : name.value,
      surname: surname == null ? this.surname : surname.value,
      dob: dob == null ? this.dob : dob.value,
      gender: gender == null ? this.gender : gender.value,
      partnerDescription: partnerDescription == null ? this.partnerDescription : partnerDescription.value,
      country: country == null ? this.country : country.value,
      city: city == null ? this.city : city.value,
      university: university == null ? this.university : university.value,
      campus: campus == null ? this.campus : campus.value,
      studyField: studyField == null ? this.studyField : studyField.value,
      yearOfStudy: yearOfStudy == null ? this.yearOfStudy : yearOfStudy.value,
      height: height == null ? this.height : height.value,
      ethnicity: ethnicity == null ? this.ethnicity : ethnicity.value,
      smokingPreference: smokingPreference == null ? this.smokingPreference : smokingPreference.value,
      drinkingPreference: drinkingPreference == null ? this.drinkingPreference : drinkingPreference.value,
      personality: personality == null ? this.personality : personality.value,
      hobbies: hobbies == null ? this.hobbies : hobbies.value,
      musicPreference: musicPreference == null ? this.musicPreference : musicPreference.value,
      loveLanguage: loveLanguage == null ? this.loveLanguage : loveLanguage.value,
      partnerPreference: partnerPreference == null ? this.partnerPreference : partnerPreference.value,
      profileImageURL: profileImageURL == null ? this.profileImageURL : profileImageURL.value,
      phoneNumber: phoneNumber == null ? this.phoneNumber : phoneNumber.value,
      email: email == null ? this.email : email.value,
      isProfileComplete: isProfileComplete == null ? this.isProfileComplete : isProfileComplete.value
    );
  }
  
  UserProfile.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _surname = json['surname'],
      _dob = json['dob'] != null ? amplify_core.TemporalDate.fromString(json['dob']) : null,
      _gender = json['gender'],
      _partnerDescription = json['partnerDescription'],
      _country = json['country'],
      _city = json['city'],
      _university = json['university'],
      _campus = json['campus'],
      _studyField = json['studyField'],
      _yearOfStudy = json['yearOfStudy'],
      _height = json['height'],
      _ethnicity = json['ethnicity'],
      _smokingPreference = json['smokingPreference'],
      _drinkingPreference = json['drinkingPreference'],
      _personality = json['personality'],
      _hobbies = json['hobbies'],
      _musicPreference = json['musicPreference'],
      _loveLanguage = json['loveLanguage'],
      _partnerPreference = json['partnerPreference'],
      _profileImageURL = json['profileImageURL'],
      _phoneNumber = json['phoneNumber'],
      _email = json['email'],
      _isProfileComplete = json['isProfileComplete'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'surname': _surname, 'dob': _dob?.format(), 'gender': _gender, 'partnerDescription': _partnerDescription, 'country': _country, 'city': _city, 'university': _university, 'campus': _campus, 'studyField': _studyField, 'yearOfStudy': _yearOfStudy, 'height': _height, 'ethnicity': _ethnicity, 'smokingPreference': _smokingPreference, 'drinkingPreference': _drinkingPreference, 'personality': _personality, 'hobbies': _hobbies, 'musicPreference': _musicPreference, 'loveLanguage': _loveLanguage, 'partnerPreference': _partnerPreference, 'profileImageURL': _profileImageURL, 'phoneNumber': _phoneNumber, 'email': _email, 'isProfileComplete': _isProfileComplete, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'surname': _surname,
    'dob': _dob,
    'gender': _gender,
    'partnerDescription': _partnerDescription,
    'country': _country,
    'city': _city,
    'university': _university,
    'campus': _campus,
    'studyField': _studyField,
    'yearOfStudy': _yearOfStudy,
    'height': _height,
    'ethnicity': _ethnicity,
    'smokingPreference': _smokingPreference,
    'drinkingPreference': _drinkingPreference,
    'personality': _personality,
    'hobbies': _hobbies,
    'musicPreference': _musicPreference,
    'loveLanguage': _loveLanguage,
    'partnerPreference': _partnerPreference,
    'profileImageURL': _profileImageURL,
    'phoneNumber': _phoneNumber,
    'email': _email,
    'isProfileComplete': _isProfileComplete,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<UserProfileModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<UserProfileModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final SURNAME = amplify_core.QueryField(fieldName: "surname");
  static final DOB = amplify_core.QueryField(fieldName: "dob");
  static final GENDER = amplify_core.QueryField(fieldName: "gender");
  static final PARTNERDESCRIPTION = amplify_core.QueryField(fieldName: "partnerDescription");
  static final COUNTRY = amplify_core.QueryField(fieldName: "country");
  static final CITY = amplify_core.QueryField(fieldName: "city");
  static final UNIVERSITY = amplify_core.QueryField(fieldName: "university");
  static final CAMPUS = amplify_core.QueryField(fieldName: "campus");
  static final STUDYFIELD = amplify_core.QueryField(fieldName: "studyField");
  static final YEAROFSTUDY = amplify_core.QueryField(fieldName: "yearOfStudy");
  static final HEIGHT = amplify_core.QueryField(fieldName: "height");
  static final ETHNICITY = amplify_core.QueryField(fieldName: "ethnicity");
  static final SMOKINGPREFERENCE = amplify_core.QueryField(fieldName: "smokingPreference");
  static final DRINKINGPREFERENCE = amplify_core.QueryField(fieldName: "drinkingPreference");
  static final PERSONALITY = amplify_core.QueryField(fieldName: "personality");
  static final HOBBIES = amplify_core.QueryField(fieldName: "hobbies");
  static final MUSICPREFERENCE = amplify_core.QueryField(fieldName: "musicPreference");
  static final LOVELANGUAGE = amplify_core.QueryField(fieldName: "loveLanguage");
  static final PARTNERPREFERENCE = amplify_core.QueryField(fieldName: "partnerPreference");
  static final PROFILEIMAGEURL = amplify_core.QueryField(fieldName: "profileImageURL");
  static final PHONENUMBER = amplify_core.QueryField(fieldName: "phoneNumber");
  static final EMAIL = amplify_core.QueryField(fieldName: "email");
  static final ISPROFILECOMPLETE = amplify_core.QueryField(fieldName: "isProfileComplete");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserProfile";
    modelSchemaDefinition.pluralName = "UserProfiles";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.SURNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.DOB,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.GENDER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.PARTNERDESCRIPTION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.COUNTRY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.CITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.UNIVERSITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.CAMPUS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.STUDYFIELD,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.YEAROFSTUDY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.HEIGHT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.ETHNICITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.SMOKINGPREFERENCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.DRINKINGPREFERENCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.PERSONALITY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.HOBBIES,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.MUSICPREFERENCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.LOVELANGUAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.PARTNERPREFERENCE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.PROFILEIMAGEURL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.PHONENUMBER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.EMAIL,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: UserProfile.ISPROFILECOMPLETE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });

  static fetchOtherProfiles() {}
}

class _UserProfileModelType extends amplify_core.ModelType<UserProfile> {
  const _UserProfileModelType();
  
  @override
  UserProfile fromJson(Map<String, dynamic> jsonData) {
    return UserProfile.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'UserProfile';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [UserProfile] in your schema.
 */
class UserProfileModelIdentifier implements amplify_core.ModelIdentifier<UserProfile> {
  final String id;

  /** Create an instance of UserProfileModelIdentifier using [id] the primary key. */
  const UserProfileModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UserProfileModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserProfileModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}