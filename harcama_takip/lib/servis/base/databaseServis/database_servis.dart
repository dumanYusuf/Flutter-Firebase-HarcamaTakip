import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:harcama_takip/base/darabase_base.dart';
import 'package:harcama_takip/model/banka.dart';

class DatabaseServis extends DatabaseBase {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Banka>> getBanka() async* {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      yield* Stream.empty();
    } else {
      yield* _firestore
          .collection('Users')
          .doc(currentUser.uid)
          .collection('Banks')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return Banka.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    }
  }

  Future<void> kaydet(Banka banka) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      CollectionReference banksRef = _firestore
          .collection('Users')
          .doc(currentUser.uid)
          .collection('Banks');
      DocumentReference docRef = banksRef.doc();
      banka.bankaId = docRef.id;
      await docRef.set(banka.toMap());
    }
  }

  @override
  Future<void> silme(id) async{
    User? curentUserId=FirebaseAuth.instance.currentUser;
    await _firestore.collection("Users").doc(curentUserId!.uid)
    .collection("Banks").doc(id).delete();
  }

  @override
  Future aramaYap(String aramaKelimesi) async{
    List<Banka> _arananBanka = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("Users")
          .doc(currentUser!.uid)
          .collection("Banks")
          .get();

      List<Banka> aramaSonucu = snapshot.docs.map((doc) =>
          Banka.fromMap(doc.data() as Map<String, dynamic>,key: doc.id)
      ).toList();

      for (var element in aramaSonucu) {
        if (element.bankaName.toLowerCase().contains(aramaKelimesi.toLowerCase())) {
          _arananBanka.add(element);
        }
      }
      return _arananBanka;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future guncelle(id, String guncelBankName, int guncelBankFiyat)async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await _firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("Banks")
        .doc(id)
        .update({
      'bankaName': guncelBankName,
      'harmaMiktari': guncelBankFiyat,
    });
  }
}
