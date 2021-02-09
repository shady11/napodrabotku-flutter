
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
    'UlutSoft is a company that can solve your business problems. We really love our Kyrgyz language, prove of this is our AI that can have a conversation in our mother language. It is not complete yet, but we are moving towards it with confidence!';


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
  ];
}
