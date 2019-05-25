import 'package:ecommerce_app/addItem.dart';
import 'package:ecommerce_app/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            } else {
              return UserAccountsDrawerHeader(
                accountEmail: Text(
                  snapshot.data.email,
                ),
                accountName: Text(
                  snapshot.data.displayName,
                  style: TextStyle(fontSize: 20),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 100,
                  child: ClipOval(
                    child: Image.network(
                      snapshot.data.photoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
          },
        ),
        ListTile(
          title: Text("Home"),
          leading: Icon(Icons.home),
        ),
        ListTile(
          title: Text("Cart"),
          leading: Icon(Icons.shopping_cart),
        ),
        ListTile(
          title: Text("Orders"),
          leading: Icon(Icons.add_shopping_cart),
        ),
        ListTile(
          title: Text("Say hi"),
          leading: Icon(Icons.mode_comment),
        ),
        ListTile(
          title: Text("Account"),
          leading: Icon(Icons.account_box),
        ),
        ListTile(
          title: Text("Help"),
          leading: Icon(Icons.help),
        ),
        ListTile(
          title: Text("Visit Us"),
          leading: Icon(Icons.computer),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return addItem();
            }));
          },
        ),
        ListTile(
          title: Text("Sign Out"),
          leading: Icon(Icons.input),
          onTap: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return login();
                }));
          },
        ),
      ],
    );
  }
}
