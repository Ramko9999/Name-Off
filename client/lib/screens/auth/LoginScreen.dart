import "package:flutter/material.dart";
import '../../util/Config.dart';
import '../../util/RelativeDimension.dart';
import '../../services/Storage.dart';
import "../../models/User.dart";
import "../../services/User.dart";
import "../../util/widgets/LoadingBar.dart";



class LoginScreen extends StatefulWidget{

  State<LoginScreen> createState(){
    return _LoginScreenState();
  }
}


class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginCodeController = TextEditingController();
  bool _isLoading = false;

  void _onSubmit(BuildContext context, String name) async {
    try {
      if (name == "") {
        throw Exception("Please enter non-empty name");
      }
      if (name.length < 8) {
        throw Exception("Your name has to have at least 8 characters");
      }

      this.setState((){
        this._isLoading = true;
      });

      final storage = await Storage.getStorage();

      User user = await UserApi.createUser(name);
      String id = user.getId();
      await storage.setId(id);
      
      
      this.setState(() {
        this._isLoading = false;
      });

      Navigator.of(context).pushNamed("/home", arguments:user);

    } catch (e) {
      this.setState(() {
        this._isLoading = false;
      });

      String errorMessage = e.toString();
      final snackBar = SnackBar(
        content: Text(errorMessage),
        duration: Duration(milliseconds: 1000),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
   
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.bgColor,
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: RelativeDimension.getHeight(context, 0.06)),
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
                    Builder(builder: (BuildContext context) {
                      return TextField(
                        controller: _loginCodeController,
                        onSubmitted: (String text) {
                          _onSubmit(context, text.trim());
                        },
                        decoration: InputDecoration(
                          hintText: "Your name",
                          filled: true,
                          fillColor: Config.textInputColor,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      );
                    }),
                    this._isLoading ? 
                    Container(
                      padding: EdgeInsets.only(top: RelativeDimension.getHeight(context, 0.02)),
                      child: LoadingBar("Loading...")
                      ) : Container()
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
