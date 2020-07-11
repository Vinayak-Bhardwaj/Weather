import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/information.dart';

class list extends StatefulWidget {
  @override
  _listState createState() => _listState();
}

class _listState extends State<list> {
  @override
  Widget build(BuildContext context) {

    final information = Provider.of<Information>(context);

    return information == null ? CircularProgressIndicator() : Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10,bottom: 0),
      margin: EdgeInsets.only(top: 10,left: 20,right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[


          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'Name : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.name}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        )
                      ]
                  )
              )
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'Email Id : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.email}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        )
                      ]
                  )
              )
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'Phone Number : ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.phone}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        )
                      ]
                  )
              )
          ),

          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(
                      text: 'City: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${information.city}',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        )
                      ]
                  )
              )
          ),

        ],
      ),

    );
  }
}
