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
                                width: 60,
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
                                    Divider(
                                      height: 1,
                                      color: Colors.red,
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
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, top: 4, bottom: 4),
                                    child: Text(
                                      'Add to cart',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.blue),
                                    ),
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
    );
  }
}
