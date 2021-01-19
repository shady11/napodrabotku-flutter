import 'package:flutter/material.dart';
import 'package:ishapp/datas/demo_users.dart';
import 'package:ishapp/screens/profile_screen.dart';
import 'package:ishapp/widgets/gallery_image_card.dart';
import 'package:ishapp/widgets/show_scaffold_msg.dart';
import 'package:ishapp/widgets/svg_icon.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _schoolController = TextEditingController(text: "University of Oxford"); // Demo initial text
  final _jobController = TextEditingController(text: "Computer programmer"); // Demo initial text
  final _bioController = TextEditingController(text: DEMO_PROFILE_BIO); // Demo initial text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile photo
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      backgroundImage: AssetImage(
                        "assets/images/demo_users/woman_05.jpg"),
                      radius: 50,
                    ),
                    onTap: () {
                        /// Handle image selection here
                        ///
                        /// Demo - Show Scaffold message
                        showScaffoldMessage(
                            context: context,
                            scaffoldkey: _scaffoldKey,
                            message: "Image picker not handled!\nThis is a Demo App UI"
                        );
                    },
                  ),
                  SizedBox(height: 10),
                  Text("Profile photo", textAlign: TextAlign.center),
                ],
              ),
            ),

            SizedBox(height: 10),

            /// Profile gallery
            Text("Gallery",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.left),
            SizedBox(height: 5),

            GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  /// Show image
                  return GestureDetector(
                    child: GalleryImageCard(),
                    onTap: () {
                      /// Handle image selection here
                      ///
                      /// Demo - Show Scaffold message
                      showScaffoldMessage(
                          context: context,
                          scaffoldkey: _scaffoldKey,
                          message: "Image picker not handled!\nThis is a Demo App UI"
                      );
                    },
                  );
              }),

            SizedBox(height: 20),

            /// Bio field
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Bio",
                hintText: "Write about you",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgIcon("assets/icons/info_icon.svg"),
                ),
              ),
              validator: (bio) {
                if (bio.isEmpty) {
                  return "Please write your bio";
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            /// School field
            TextFormField(
              controller: _schoolController,
              decoration: InputDecoration(
                  labelText: "School",
                  hintText: "Enter your school name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: SvgIcon("assets/icons/university_icon.svg"),
                  )),
              validator: (school) {
                if (school.isEmpty) {
                  return "Please enter your school name";
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            /// Job title field
            TextFormField(
              controller: _jobController,
              decoration: InputDecoration(
                  labelText: "Job Title",
                  hintText: "Enter your job title",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgIcon("assets/icons/job_bag_icon.svg"),
                  )),
              validator: (job) {
                if (job.isEmpty) {
                  return "Please enter your job title";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.check),
        onPressed: () {
          /// Save changes and go to profile screen
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProfileScreen(
              user: currentUserDemo
            )));
        },
      ),
    );
  }
}
