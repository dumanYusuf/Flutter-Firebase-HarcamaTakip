import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harcama_takip/base/auth_base.dart';

class AuthServis extends AuthBase{

  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  @override
  Future signInWithEmailAndPassword(String mail, String password)async {
    UserCredential userCredential=await _firebaseAuth.signInWithEmailAndPassword(email: mail, password: password);
   return userCredential;
  }

  @override
  Future<void> signOut()async {
     await _firebaseAuth.signOut();
  }

  @override
  Future signUpWithEmailAndPassword(String email, String password, String userName, String fullName)async {

    UserCredential userCredential=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    
    await _firestore.collection("Users").doc(userCredential.user!.uid)
    .set({
      "userId":userCredential.user!.uid,
      "mail":email,
      "fullName":fullName,
    });
  }
} 