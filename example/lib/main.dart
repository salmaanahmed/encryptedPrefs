import 'package:flutter/material.dart';
import 'package:encrypted_prefs/encrypted_prefs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final EncryptedPrefs prefs = EncryptedPrefs();
  String encryptionKey = "StrongEncryptionKeyFromKeystoreOrASecurePlace";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String message = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    /// You can generate encryption key using EncryptedPrefs
    encryptionKey = await prefs.generateRandomKey();
  }

  _signUpUser() async {
    User user = User(emailController.text, passwordController.text);

    /// Save data in local storage with your object against key and encryption key
    await prefs.set("User", user, encryptionKey);

    setState(() {
      message = "You signed up successfully!";
    });
  }

  _loginUser() async {
    User user = User(emailController.text, passwordController.text);

    /// Retrieve your data from local storage with your key, encryption key and the serialization technique you are using
    prefs.get("User", encryptionKey, (json) => User.fromJson(json)).then((value) {
        if (user == value) {
          setState(() {
            message = "You are now logged in :)";
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = SizedBox(
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 50.0,
      ),
    );

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.blue,
      elevation: 5,
      splashColor: Colors.blueGrey,
      onPressed: _loginUser,
      child: new Text("Login"),
    );

    final signupButton = RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.red,
      splashColor: Colors.redAccent,
      elevation: 5,
      highlightElevation: 2,
      onPressed: _signUpUser,
//      onPressed: addNumbers,
      child: new Text("Sign Up"),
    );

    final messageLabel = FlatButton(
      child: Text(
        message,
        style: TextStyle(color: Colors.black54),
      ),
    );

    return MaterialApp(
      title: 'Encrypted Prefrences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
              signupButton,
              messageLabel,
            ],
          ),
        ),
      ),
    );
  }
}

/// Sample class used for storing locally
class User {
  final String username;
  final String password;

  User(this.username, this.password);

  bool operator == (user) => user is User && user.username == username && user.password == password;

  /// Serializing technique
  User.fromJson(Map<String, dynamic> json)
      : username = json['Username'],
        password = json['Password'];

  /// And deserializing
  Map<String, dynamic> toJson() => {
        'Username': username,
        'Password': password,
      };
}
