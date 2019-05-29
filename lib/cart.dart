import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class cart extends StatefulWidget {
  String id;

  cart({Key key, @required this.id}) : super(key: key);

  @override
  _cartState createState() => _cartState(id: id);
}

// ignore: camel_case_types
class _cartState extends State<cart> {
  int count=1;
  String id;

  _cartState({Key key, @required this.id});

  buildItem(BuildContext context, DocumentSnapshot document) {
    var percent = ((int.parse(document['mp']) - int.parse(document['cp'])) /
            int.parse(document['mp'])) *
        100;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            height: 145,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child:
                        Container(child: Image.network(document['imageUrl'])),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            document['name'],
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            children: <Widget>[
                              Container(
                                child: Stack(
                                  overflow: Overflow.clip,
                                  alignment: Alignment.centerLeft,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Text(
                                        document['mp'] + '/' + document['unit'],
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Divider(
                                        height: 1,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            'Rs ' +
                                                document['cp'] +
                                                '/' +
                                                document['unit'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '$percent% Off',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 200),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: "1",
                              decoration: InputDecoration(hintText: 'Quantity',),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.blue,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(
        child: FutureBuilder(
          future: Firestore.instance
              .collection('users')
              .document(id)
              .collection(id)
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return buildItem(context, snapshot.data.documents[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
