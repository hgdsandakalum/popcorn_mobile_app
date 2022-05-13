import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:popcorn_mobile_app/widgets/custom_app_bar_2.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //firebase user authneication state
  User? user = FirebaseAuth.instance.currentUser;
  user_model currentUser = user_model();

  //collection reference
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _users.doc(user!.uid).get().then((val) {
      setState(() {
        currentUser = user_model.fromMap(val.data());
      });
    });
  }

  //text editor controllers
  final f_name_editing_cntrlr = TextEditingController();
  final l_name_editing_cntrlr = TextEditingController();
  final email_editing_cntrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    f_name_editing_cntrlr.text = currentUser.f_name.toString();
    l_name_editing_cntrlr.text = currentUser.l_name.toString();
    email_editing_cntrlr.text = currentUser.email.toString();
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        child: CustomAppBar2(),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: "${currentUser.imagePath}",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: f_name_editing_cntrlr,
                  style: TextStyle(color: Colors.white60),
                  decoration: const InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Color.fromARGB(32, 255, 255, 255),
                      filled: true),
                ),
                SizedBox(height: 11.0),
                TextField(
                  controller: l_name_editing_cntrlr,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Color.fromARGB(32, 255, 255, 255),
                      filled: true),
                ),
                SizedBox(height: 11.0),
                TextField(
                  controller: email_editing_cntrlr,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Email / Username',
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Color.fromARGB(32, 255, 255, 255),
                      filled: true),
                ),
                const SizedBox(
                  height: 23,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Colors.amberAccent,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: () async {
                    final String? f_name = f_name_editing_cntrlr.text;
                    final String? l_name = l_name_editing_cntrlr.text;
                    final String? email = email_editing_cntrlr.text;

                    if (f_name != null) {
                      print('Fname : $f_name');
                      print('Lname : $l_name');
                      print('Email : $email');
                      print('UID: ${currentUser.uid}');
                      await _users.doc(currentUser.uid).update({
                        "f_name": f_name,
                        "l_name": l_name,
                        "email": email,
                      });

                      f_name_editing_cntrlr.text = '';
                      l_name_editing_cntrlr.text = '';
                      email_editing_cntrlr.text = '';
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
