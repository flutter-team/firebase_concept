import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);}}
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Form(key: _formKey, child: Column(
      children: <Widget>[
      TextFormField(
                  decoration: InputDecoration(hintText: 'Email'), 
                  validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
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
