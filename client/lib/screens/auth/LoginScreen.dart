import "package:flutter/material.dart";
import '../../util/Config.dart';
import '../../util/RelativeDimension.dart';
import '../../services/Storage.dart';
import "../../models/User.dart";
import "../../services/User.dart";

class LoginScreen extends StatelessWidget {

  final TextEditingController _loginCodeController = new TextEditingController();

  void _handleNameSubmit(String name){
    if(name == ""){
      throw Exception("Input name is empty");
    }
    if(name.length < 8){
      throw Exception("Name needs to be atleast 8 characters");
    }

    Storage.getStorage().then((final storage) async {
      User user = await UserApi.createUser(name);
      String id = user.getId();
      await storage.setId(id);
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(  
      backgroundColor: Config.bgColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only( top: RelativeDimension.getHeight(context, 0.06)),
              child: Image.asset(
                'assets/logo.png',
                width: RelativeDimension.getWidth(context, 1),
              ),
            ),
            Container(
                width: RelativeDimension.getWidth(context, 0.9),
                padding: EdgeInsets.only(
                    top: RelativeDimension.getHeight(context, 0.001)),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text("Name Off!",
                      style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Config.secondaryColor,
                          fontSize: 36,
                          fontFamily: Config.fontFamily,
                          fontWeight: FontWeight.bold)),
                )),
            Container(
                width: RelativeDimension.getWidth(context, 0.9),
                padding: EdgeInsets.only(
                    top: RelativeDimension.getHeight(context, 0.02)),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text('Name',
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor: Config.secondaryColor,
                              fontSize: 24,
                              fontFamily: Config.fontFamily,
                              fontWeight: FontWeight.bold)),
                    ),
                    TextField(
                      controller: _loginCodeController,
                      onSubmitted: _handleNameSubmit,
                      decoration: InputDecoration(
                        hintText: "Your name",
                        filled: true,
                        fillColor: Config.textInputColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
