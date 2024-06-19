import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harcama_takip/base/auth_base.dart';
import 'package:harcama_takip/base/darabase_base.dart';
import 'package:harcama_takip/model/banka.dart';
import 'package:harcama_takip/servis/base/authServis/auth_servis.dart';
import 'package:harcama_takip/servis/base/databaseServis/database_servis.dart';
import 'package:harcama_takip/tools/locator.dart';

class DatabaseRepository implements AuthBase,DatabaseBase{

  AuthBase _authBase=locator<AuthServis>();
  DatabaseServis _servis=locator<DatabaseServis>();

  @override
  Future signInWithEmailAndPassword(String mail, String password)async {
    await _authBase.signInWithEmailAndPassword(mail, password);
  }

  @override
  Future<void> signOut() async{
    return await _authBase.signOut();
  }

  @override
  Future signUpWithEmailAndPassword(String email, String password, String userName, String fullName) async{
    return await _authBase.signUpWithEmailAndPassword(email, password, userName, fullName);
  }

  @override
  Future kaydet(Banka banka) async{
    await _servis.kaydet(banka);
  }

  @override
  Stream<List<Banka>> getBanka() async*{
    yield* await _servis.getBanka();
  }

  @override
  Future<void> silme(id) async{
    return await _servis.silme(id);
  }

  @override
  Future aramaYap(String aramaKelimesi)async {
    return await _servis.aramaYap(aramaKelimesi);
  }

  @override
  Future guncelle(id, String guncelBankName, int guncelBankFiyat)async {
    return await _servis.guncelle(id, guncelBankName, guncelBankFiyat);
  }
}