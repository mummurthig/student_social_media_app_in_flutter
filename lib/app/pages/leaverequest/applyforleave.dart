import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplyForLeave extends StatefulWidget {


  @override
  _ApplyForLeaveState createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForLeave> {
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Form(
              child:
              ListView(padding: EdgeInsets.all(8.0), children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Student Name",
                        hintText: "Enter Your Name !",
                      ),
                    )),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "ID CARD ",
                        hintText: "Enter Your ID CARD",
                      ),
                    )),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8, top: 8), // Set new height here
                      border: OutlineInputBorder(),
                      labelText: "Leave Days",
                      hintText: "How Many Days You Want ?",
                    ),
                  ),
                ),

                Text("From Date"),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(currentDate.toString()),
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ],
                ),

                Text("Last Date"),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(currentDate.toString()),
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ],
                ),

              ]),
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.save),
        label: Text("Apply"),
      ),
    );
  }
}
