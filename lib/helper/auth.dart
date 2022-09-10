import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl_standalone.dart';
import '../helper/helper.dart';
import '../models/User.dart';
import '../models/ex.dart';
class Auth_provider extends ChangeNotifier {
  UserMdoel? userMdoel;
 User? user;

  sign_in(String e ,String pass) async{

try {
 final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: e, password: pass);

   FireStoreHelper.fireStoreHelper..updatetoken(cred.user!);
 
}on FirebaseAuthException catch(e){
 if (e.code == 'user-not-found'){
   throw MyEx("User Not found\n Enter correct email");
 }if (e.code == 'wrong-password'){

   throw MyEx("Wrong password provided for that user");
 }else if(e.message!.contains("A network error")) {
  print(e.message);
  throw SocketException;
 }
 
}
catch (e) {
  throw e;
}

  }
sign_up(UserMdoel usermdoel)async{

try {
 final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: usermdoel.email!, password: usermdoel.password!);
user = cred.user;
//userMdoel = usermdoel;

//userMdoel!.id = cred.user!.uid;
return cred;

 
}on FirebaseAuthException catch(e){
 if (e.code == 'email-already-in-use'){
   throw MyEx("The account already exists for that email");
 }else if(e.message!.contains("network error")) {
  throw SocketException;
 }
 
}
catch (e) {
  throw e;
}

  }
  logOut(){
    FirebaseAuth.instance.signOut();
  }
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
print(googleUser!.email);
  print(googleUser.displayName);
  print("hghkghkghghjghjghjghjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  print(credential);
  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
curruntuser() async {
final uid =    FirebaseAuth.instance.currentUser!.uid;
 DocumentSnapshot<Object?> doc = await   FirebaseFirestore.instance.collection('use').doc(uid).get() ;
final data = doc.data() as Map<String,dynamic>;

  userMdoel = UserMdoel( 
    
    imgurl: data['img'],
    birth:DateTime.parse(data['birth']), email: data['email'], gender: data['gender'], name: data['name']);
print(userMdoel!.name);



}
deletacount()async{
 await FirebaseAuth.instance.currentUser!.delete();
 await FirebaseFirestore.instance.collection('use').doc(FirebaseAuth.instance.currentUser!.uid).delete();
}
update(UserMdoel? user , File? b, String?  imgurl)async{
   try {
     final imgpath  =  FirebaseStorage.instance.ref().child("imgs").child(FirebaseAuth.instance.currentUser!.uid+'.jpg');

if(b!=null){
  
  await imgpath.putFile(b).whenComplete(() {
   
   });
 
}
  imgurl =  await  imgpath.getDownloadURL();
  await FirebaseAuth.instance.currentUser!.updateEmail(user!.email!);
 await FirebaseFirestore.instance.collection('use').doc(FirebaseAuth.instance.currentUser!.uid).update({

 'email':user.email,
 'gender':user.gender,
 'birth': user.birth.toString(),
 'name': user.name,
 'img': imgurl,
    });

notifyListeners();
   }
   
   catch (e) {
    throw e;
   }
  }
}
