
import 'package:ishapp/datas/user.dart';


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
