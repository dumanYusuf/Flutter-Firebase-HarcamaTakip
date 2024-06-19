import 'package:harcama_takip/model/banka.dart';

abstract class DatabaseBase {
  Future<dynamic>kaydet(Banka banka);
  Stream<List<Banka>>getBanka();
  Future<void>silme(id);
  Future<dynamic>aramaYap(String aramaKelimesi);
  Future<dynamic>guncelle(id,String guncelBankName,int guncelBankFiyat);
}