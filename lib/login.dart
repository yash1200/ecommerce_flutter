import 'package:ecommerce_app/homePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<login> {
  var fkey = GlobalKey<FormState>();
  String phoneNumber, address, pinCode;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController pinCodecontroller = TextEditingController();

  Future<FirebaseUser> getUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((_firebaseUser) {
      if (_firebaseUser != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return homePage();
            }));
      }
    });
  }

  Future<FirebaseUser> _signIn(BuildContext context, String phoneNumber,
      String address, String pinCode) async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    final FirebaseUser firebaseUser =
        await _auth.signInWithCredential(credential);
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance
            .collection('users')
            .document(firebaseUser.uid)
            .setData({
          'name': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'id': firebaseUser.uid,
          'email': firebaseUser.email,
          'number': phoneNumber,
          'address': address,
          'pin': pinCode
        });
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return homePage();
      }));
    }
    print("User Name : ${firebaseUser.email}");
    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Form(
          key: fkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: phonecontroller,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter Phone Number';
                    } else if (value.length != 10) {
                      return 'Enter valid Number';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFormField(
                  controller: addresscontroller,
                  validator: (String valye) {
                    if (valye.isEmpty) {
                      return 'Please Enter Address';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Address',
                      labelText: 'Address',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: pinCodecontroller,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter PinCode';
                    } else if (value.length != 6) {
                      return 'Enter Valid Code';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Pin Code',
                      labelText: 'Pin Code',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      phoneNumber = phonecontroller.text;
                      pinCode = pinCodecontroller.text;
                      address = addresscontroller.text;
                      if (fkey.currentState.validate()) {
                        _signIn(context, phoneNumber, address, pinCode)
                            .then(
                                (FirebaseUser user) => print(user.displayName))
                            .catchError((e) => print(e));
                      }
                    });
                  },
                  color: Colors.blue,
                  elevation: 5,
                  child: Text(
                    "Google Sign-In",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
