import 'package:matrimonial_app/home.dart';
import 'package:matrimonial_app/login.dart';
import 'package:matrimonial_app/register/basic_details.dart';
import 'package:matrimonial_app/register/education_details.dart';
import 'package:matrimonial_app/register/family_details.dart';
import 'package:matrimonial_app/register/lifestyle_hobbies.dart';
import 'package:matrimonial_app/register/panter_preffrence.dart';
import 'package:matrimonial_app/register/profile_images.dart';
import 'package:matrimonial_app/register/register.dart';
import 'package:matrimonial_app/register/religiousDetails.dart';
import 'package:matrimonial_app/view/profile.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register'; // Add more as you go
  static const String basicdetails = '/basicdetails'; // Add more as you go
  static const String religiousDetails = '/religiousDetails'; // Add more as you go
  static const String education_details = '/education_details'; // Add more as you go
  static const String family_details = '/family_details'; // Add more as you go
  static const String panter_preffrence = '/panter_preffrence'; // Add more as you go
  static const String profile_images = '/profile_images'; // Add more as you go
  static const String lifestyle_hobbies = '/lifestyle_hobbies'; // Add more as you go

  static final routes = {
    login: (context) => LoginScreen(),
    home: (context) => HomeScreen(),
    register: (context) => RegistrationScreen(),
    basicdetails: (context) => RegistrationFlow(),
    religiousDetails: (context) => ReligiousCasteDetails(),
    education_details: (context) => EducationCareerScreen(),
    family_details: (context) => FamilyDetailsScreen(),
    panter_preffrence: (context) => PartnerPreferenceScreen(),
    profile_images: (context) => FinalStepProfilePicScreen(),
    lifestyle_hobbies: (context) => LifestyleDetailsScreen(),
  };
}
