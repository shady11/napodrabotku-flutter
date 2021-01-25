
import 'package:ishapp/datas/user.dart';
import 'package:ishapp/datas/vacancy.dart';


 /// CURRENT SINGNED USER DEMO [currentUserDemo]
 User currentUserDemo = User(
  userFullname: "Deborah, 25",
  userPhotoLink: "assets/images/demo_users/woman_05.jpg",
  userSchool: "University of Oxford",
  jobTitle: "Computer programmer",
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
      userFullname: "Carolyn, 20",
      userPhotoLink: "assets/images/demo_users/woman_01.jpg",
      userSchool: "Harvard University",
      jobTitle: "Dentist",
      userDistance: "10km",
    ),
    User(
      userFullname: "Rachel, 25",
      userPhotoLink: "assets/images/demo_users/woman_02.jpg",
      userSchool: "Massachusetts Institute of Technology",
      jobTitle: "Management analyst",
      userDistance: "15km",
    ),

    User(
      userFullname: "Nicole, 27",
      userPhotoLink: "assets/images/demo_users/woman_03.jpg",
      userSchool: "Stanford University",
      jobTitle: "Psychologist",
      userDistance: "20km",
    ),

    User(
      userFullname: "Angela, 24",
      userPhotoLink: "assets/images/demo_users/woman_04.jpg",
      userSchool: "University of Cambridge",
      jobTitle: "Engineer",
      userDistance: "25km",
    ),

    User(
      userFullname: "Deborah, 25",
      userPhotoLink: "assets/images/demo_users/woman_05.jpg",
      userSchool: "University of Oxford",
      jobTitle: "Computer programmer",
      userDistance: "30km",
    ),

    User(
      userFullname: "Jennifer, 25",
      userPhotoLink: "assets/images/demo_users/woman_06.jpg",
      userSchool: "University of California",
      jobTitle: "Physical scientist",
      userDistance: "35km",
    ),
  ];
}
List<Vacancy> getDemoVacancies() {
  /// User list
  return [
    Vacancy(
      company_name: "Rachel, 25",
      company_logo_image: "assets/images/demo_users/woman_02.jpg",
      name: "Massachusetts Institute of Technology",
      description: "Management analyst",
    ),

    Vacancy(
      company_name: "Nicole, 27",
      company_logo_image: "assets/images/demo_users/woman_03.jpg",
      name: "Stanford University",
      description: "Psychologist",
    ),

    Vacancy(
      company_name: "Angela, 24",
      company_logo_image: "assets/images/demo_users/woman_04.jpg",
      name: "University of Cambridge",
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
