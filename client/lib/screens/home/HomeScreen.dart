import "package:flutter/material.dart";


class HomeScreen extends StatelessWidget{

  TextEditingController _joinCodeController;
  TextEditingController _makeCodeController;

  HomeScreen(){
    this._joinCodeController = new TextEditingController();
    this._makeCodeController = new TextEditingController();
  }



  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Name Off")
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text("Play the classic game Name Off!")
            ),
            Container(
              child: TextField(
                controller: _joinCodeController,
                decoration: InputDecoration(
                  hintText: "type code"
                ),
              )
            )
        ],)
      ),
    );
  }


}