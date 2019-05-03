import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
class ResetPassword extends StatefulWidget {
  
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
 final _formKey=new GlobalKey<FormState>();
  String _email; 
  bool validateAndSave(){
if(_formKey.currentState.validate()){
  _formKey.currentState.save();
  return true;
}
return false;
}
void validateAndSubmit()async{
  if(validateAndSave()){
  
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title:Text('Info') ,
         content:Text('open ur gmail and change password') ,
         actions: <Widget>[
           FlatButton(child: Text('ok'),onPressed: (){
             Navigator.pop(context);
           },)
         ],);});
    
    }catch(e){
     return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(title:Text('Info') ,
         content:Text('erroe $e') ,
         actions: <Widget>[
           FlatButton(child: Text('ok'),onPressed: (){
             Navigator.pop(context);
           },)
         ],);});  
    }
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: Text('Reset Password'),),
      body: Form(key: _formKey, child: Column(
      children: <Widget>[
      TextFormField(
                  decoration: InputDecoration(hintText: 'Email',), 
                   validator: (value) {
        if (value.isEmpty ||
            !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
                  onSaved: (value) {
                    setState(() {
                      _email = value;
                    });
                    
                  }),
        RaisedButton( child:Text('send Email'),  onPressed: (){
         validateAndSubmit();
        },)
      ],
    ),),
      
    );
  }
}
