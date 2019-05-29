import 'package:ecommerce_app/about.dart';
import 'package:ecommerce_app/cart.dart';
import 'package:ecommerce_app/fruits.dart';
import 'package:ecommerce_app/vegitables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      id = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("VeggFarm"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return cart(id: id);
                      }));
                    },
                    child: Icon(Icons.shopping_cart)),
              )
            ],
            bottom: TabBar(tabs: [
              Tab(
                child: Text(
                  "VEGETABLES",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  "FRUITS",
                  style: TextStyle(fontSize: 15),
                ),
              )
            ]),
          ),
          drawer: Drawer(
            child: about(),
          ),
          body: TabBarView(
            children: [vegetables(), fruits()],
          ),
        ),
      ),
    );
  }
}
