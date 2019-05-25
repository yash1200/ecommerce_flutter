import 'package:flutter/material.dart';

class addItem extends StatefulWidget {
  @override
  _addItemState createState() => _addItemState();
}

class _addItemState extends State<addItem> {
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController MPcontroller = TextEditingController();
  TextEditingController CPcontroller = TextEditingController();
  TextEditingController unitcontroller = TextEditingController();
  var fkey = GlobalKey<FormState>();
  var filter = ['Vegetables', 'Fruits'];
  var selectedItem;

  int type = 0;

  void dropdownfun(String newValueSelected) {
    setState(() {
      this.selectedItem = newValueSelected;
      if (newValueSelected == 'Vegetables') {
        type = 0;
      } else {
        type = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Items"),
      ),
      body: Form(
        key: fkey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 240,
                  constraints: BoxConstraints(maxHeight: 40),
                  child: DropdownButton<String>(
                    hint: Text('Please Pick one Category'),
                    items: filter.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text((value)),
                      );
                    }).toList(),
                    value: selectedItem,
                    onChanged: (String newValueSelected) {
                      dropdownfun(newValueSelected);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    controller: namecontroller,
                    validator: (String valye) {
                      if (valye.isEmpty) {
                        return 'Please Enter Address';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Name Of the Product',
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    controller: MPcontroller,
                    validator: (String valye) {
                      if (valye.isEmpty) {
                        return 'Please Enter Address';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Market Price',
                        labelText: 'MP',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    controller: CPcontroller,
                    validator: (String valye) {
                      if (valye.isEmpty) {
                        return 'Please Enter Address';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Cost Price',
                        labelText: 'CP',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    controller: imagecontroller,
                    validator: (String valye) {
                      if (valye.isEmpty) {
                        return 'Please Enter Address';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Image Of Product',
                        labelText: 'Image',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    controller: unitcontroller,
                    validator: (String valye) {
                      if (valye.isEmpty) {
                        return 'Please Enter Address';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Unit of Quantity',
                        labelText: 'Unit',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        if (fkey.currentState.validate()) {}
                      });
                    },
                    color: Colors.blue,
                    elevation: 5,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
