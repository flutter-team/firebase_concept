import 'package:flutter/material.dart';
import 'resetpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;
  void _moveToRegister() {
    _formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void _moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  bool validateAndSave() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          FirebaseUser user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
       if(user.email==_email){return  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title:Text('Info') ,
         content:Text('signedin user: ${user.uid}') ,
         actions: <Widget>[
           FlatButton(child: Text('ok'),onPressed: (){
             Navigator.pop(context);
           },)
         ],);});  
           }
           else{
             return  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title:Text('Info') ,
         content:Text('enter valid email and password') ,
         actions: <Widget>[
           FlatButton(child: Text('ok'),onPressed: (){
             Navigator.pop(context);
           },)
         ],);});  
           }
        
        } else {
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
                 
                  if(user.email==_email){
                    return  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title:Text('Info') ,
         content:Text('user created successfully') ,
         actions: <Widget>[
           FlatButton(child: Text('ok'),onPressed: (){
             Navigator.pop(context);
           },)
         ],);});  
                  }
          print('Registered user: ${user.uid}');
        }
      } catch (e) {
         return  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title:Text('Info') ,
         content:Text('Error: $e') ,
         actions: <Widget>[
           FlatButton(child: Text('ok'),onPressed: (){
             Navigator.pop(context);
           },)
         ],);});  
           }
      }
    }
  

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: new ColorFilter.mode(
          Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage(
        'images/waterfall.jpg',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: _buildBackgroundImage(),
      ),
      padding: EdgeInsets.all(25.0),
      child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildInputs() + buildButtons())),
    ));
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
          decoration: InputDecoration(hintText: 'Email'),
          validator: (value) {
            if (value.isEmpty ||
                !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
              return 'Please enter a valid email';
            }
          },
          onSaved: (value) {
            setState(() {
              _email = value;
            });
          }),
      SizedBox(height: 15.0),
      TextFormField(
        decoration: InputDecoration(hintText: 'Password'),
        validator: (val) {
          if (val.isEmpty && val.length < 6) {
            return 'Password must contain 6 characters';
          }
        },
        onSaved: (value) {
          setState(() {
            _password = value;
          });
        },
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text('Login'),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 7.0,
          onPressed: () {
            validateAndSubmit();
          },
        ),
        FlatButton(
          child: Text("Create an account"),
          onPressed: () {
            _moveToRegister();
          },
        ),
        FlatButton(
          child: Text(
            "forget Password?",
            style: TextStyle(color: Colors.grey[800]),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResetPassword()),
            );
          },
        )
      ];
    } else {
      return [
        RaisedButton(
            child: Text('Create an accoun'),
            color: Colors.blue,
            textColor: Colors.white,
            elevation: 7.0,
            onPressed: () {
              validateAndSubmit();
            }),
        FlatButton(
          child: Text("have an account? Login"),
          onPressed: () {
            _moveToLogin();
          },
        )
      ];
    }
  }
}
