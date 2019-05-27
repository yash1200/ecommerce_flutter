import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class vegetables extends StatefulWidget {
  @override
  _vegetablesState createState() => _vegetablesState();
}

class _vegetablesState extends State<vegetables> {
  buildItem(BuildContext context, DocumentSnapshot document) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Container(
            height: 150,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            document['name'],
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 25),
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      document['mp'],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.red),
                                    ),
                                    Text(
                                      '/' + document['unit'],
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    document['cp'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    '/' + document['unit'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            document['name'],
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 16),
                          ),
                        ),
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
    return Container(
      child: FutureBuilder(
        future: Firestore.instance
            .collection('item')
            .document('vegetables')
            .collection('vegetables')
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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
    );
  }
}
