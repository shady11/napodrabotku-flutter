import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ishapp/widgets/default_button.dart';
import 'package:ishapp/widgets/show_scaffold_msg.dart';
import 'package:ishapp/widgets/svg_icon.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Variables
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _jobController = TextEditingController();
  final _bioController = TextEditingController();
  String _birthday = "Select your Birthday";

  void _showDataPicker() {
    DatePicker.showDatePicker(context,
        theme: DatePickerTheme(
          headerColor: Theme.of(context).primaryColor,
          cancelStyle: const TextStyle(color: Colors.white, fontSize: 17),
          doneStyle: const TextStyle(color: Colors.white, fontSize: 17),
        ), onConfirm: (date) {
      print(date);
      // Change state
      setState(() {
        _birthday = date.toString().split(" ")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text("Create Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            /// Profile photo
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 50,
                child: SvgIcon("assets/icons/camera_icon.svg",
                    width: 40, height: 40, color: Colors.white),
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

            SizedBox(height: 22),

            /// Form
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  /// Fullname field
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "Full name",
                        hintText: "Enter your full name",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgIcon("assets/icons/user_icon.svg"),
                        )),
                    validator: (name) {
                      // Basic validation
                      if (name.isEmpty) {
                        return "Please enter your fullname";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  /// Birthday card
                  Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                          side: BorderSide(color: Colors.grey[350])),
                      child: ListTile(
                        leading: SvgIcon("assets/icons/calendar_icon.svg"),
                        title: Text(_birthday,
                            style: TextStyle(color: Colors.grey)),
                        trailing: Icon(Icons.arrow_drop_down),
                        onTap: () {
                          /// Select birthday
                          _showDataPicker();
                        },
                      )),
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

                  /// Sign Up button
                  SizedBox(
                    width: double.maxFinite,
                    child: DefaultButton(
                      child: Text("Sign Up", style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        /// Validate form
                        // if (_formKey.currentState.validate()) {}

                        /// Remove previous screens
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);

                        /// Go to home screen - for demo
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
