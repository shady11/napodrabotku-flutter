
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/datas/vacancy.dart';

 /// CURRENT SINGNED USER DEMO [currentUserDemo]
 User currentUserDemo = User(
  userFullname: "UlutSoft",
  userPhotoLink: "assets/images/demo_users/logo_new2.png",
  userSchool: "Бишкек Чехова 28",
  jobTitle: "Software for your business",
  userDistance: "0km",
);

const DEMO_PROFILE_BIO =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas semper\n'
    '😍👜👢👗🌷🍔🧁️🍟🍕❤️️ convallis nulla in cursus. '
    'Proin id accumsan felis. Aenean malesuada vitae ligula ac bibendum.';


/// DEMO PROFILES - [getDemoUsers] ///
///
List<User> getDemoUsers() {
  /// User list
  return [
     User(
      userFullname: "UlutSoft",
      userPhotoLink: "assets/images/demo_users/logo_new2.png",
      userSchool: "Harvard University",
      jobTitle: "Dentist",
      userDistance: "10km",
    ),
    User(
      userFullname: "MadDevs",
      userPhotoLink: "assets/images/demo_users/maddevs.png",
      userSchool: "Massachusetts Institute of Technology",
      jobTitle: "Management analyst",
      userDistance: "15km",
    ),

    User(
      userFullname: "ZenSoft",
      userPhotoLink: "assets/images/demo_users/zensoft_logo.png",
      userSchool: "Stanford University",
      jobTitle: "Psychologist",
      userDistance: "20km",
    ),


  ];
}
List<Vacancy> getDemoVacancies() {
  /// User list
  return [
    Vacancy(
      company_name: "UlutSoft",
      company_logo_image: "assets/images/demo_users/logo_new2.png",
      name: "Swift разраотчик",
      description: "Management analyst",
    ),

    Vacancy(
      company_name: "UlutSoft",
      company_logo_image: "assets/images/demo_users/logo_new2.png",
      name: "Python разраотчик",
      description: "Psychologist",
    ),

    Vacancy(
      company_name: "UlutSoft",
      company_logo_image: "assets/images/demo_users/logo_new2.png",
      name: "Php разраотчик",
      description: "Engineer",
    ),

    Vacancy(
      company_name: "ZenSoft",
      company_logo_image: "assets/images/demo_users/zensoft_logo.png",
      name: "Java разработчик",
      description: "- Spring Boot",
      experience: "2-5"
    ),

    Vacancy(
      company_name: "MadDevs",
      company_logo_image: "assets/images/demo_users/maddevs.png",
      name: "Python developer",
      description: "- Flask framework",
      experience: "2-5"
    ),
    Vacancy(
      company_name: "UlutSoft",
      company_logo_image: "assets/images/demo_users/logo_new2.png",
      name: "Django разработчик",
      description: " - Django framework",
      experience: "2-5"
    ),
  ];
}
