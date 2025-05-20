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
import 'package:matrimonial_app/view/home_screen_cards/like_profile.dart';
import 'package:matrimonial_app/view/home_screen_cards/viewed_profile.dart';
import 'package:matrimonial_app/view/profile.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String basicdetails = '/basicdetails';
  static const String religiousDetails = '/religiousDetails';
  static const String education_details = '/education_details';
  static const String family_details = '/family_details';
  static const String panter_preffrence = '/panter_preffrence';
  static const String profile_images = '/profile_images';
  static const String lifestyle_hobbies = '/lifestyle_hobbies';
  static const String viewed_by = '/viewed_by';
  static const String like_by = '/like_by';

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
    viewed_by: (context) => ViewedByScreen(),
    like_by: (context) => LikeByScreen(),
  };
}
