import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcama_takip/model/banka.dart';
import 'package:harcama_takip/repo/database_repository.dart';
import 'package:harcama_takip/tools/locator.dart';

class HomePageViewModel with ChangeNotifier{

  final _servis = locator<DatabaseRepository>();

  TextEditingController _bankaAdiController = TextEditingController();
  TextEditingController _fiyatController = TextEditingController();
  TextEditingController _aramaController=TextEditingController();

  TextEditingController get aramaController => _aramaController;
  List<Banka>_banka=[];

  List<Banka> get banka => _banka;

  Stream<List<Banka>> bankaGet(){
     return _servis.getBanka();
  }

  void bankaKaydet(BuildContext context) async {
    List<dynamic>? sonuc = await showDialogAc(context);
    if (sonuc != null && sonuc.length > 1) {
      String bankaAdi = sonuc[0];
      int bankaFiyat;

      try {
        bankaFiyat = int.parse(sonuc[1]);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
           const  SnackBar(content: Text('Lütfen geçerli bir sayı girin'))
        );
        return;
      }

      Banka yeniBanka = Banka(bankaName: bankaAdi, harmaMiktari: bankaFiyat);
      await _servis.kaydet(yeniBanka);
      notifyListeners();
    }
  }

  void silme(id)async{
     await _servis.silme(id);

  }

  Future<void> aramaYap(String aramaKelimesi)async{
   try{
     _banka= await _servis.aramaYap(aramaKelimesi);
     notifyListeners();
   }
   catch(e){
     print(e.toString());
   }
  }

  void guncelle(BuildContext context, String id) async {
    List<dynamic>? guncelleSonuc = await showDialogGuncelle(context);
    if (guncelleSonuc != null && guncelleSonuc.length > 1) {
      String guncelName = guncelleSonuc[0];
      String guncelFiyatStr = guncelleSonuc[1];

      // Fiyatı int'e dönüştürmeden önce kontrol edelim
      int? guncelFiyat;
      try {
        guncelFiyat = int.parse(guncelFiyatStr);
      } catch (e) {
        // Hata durumunda kullanıcıya bildirim gösterelim ve fonksiyonu burada sonlandıralım
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen geçerli bir sayı girin')),
        );
        return;
      }

      // Güncelleme işlemi
      await _servis.guncelle(id, guncelName, guncelFiyat);
      notifyListeners();
    }
  }


  Future<List<dynamic>?> showDialogGuncelle(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Harcama Takip",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _bankaAdiController,
                decoration: InputDecoration(
                  labelText: 'Banka Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _fiyatController,
                decoration: InputDecoration(
                  labelText: 'Fiyat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, [_bankaAdiController.text, _fiyatController.text]);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Güncelle',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Vazgeç',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Future<List<dynamic>?> showDialogAc(BuildContext context) {
    _bankaAdiController.clear();
    _fiyatController.clear();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Harcama Takip",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _bankaAdiController,
                decoration: InputDecoration(
                  labelText: 'Banka Adı',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _fiyatController,
                decoration: InputDecoration(
                  labelText: 'Fiyat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, [_bankaAdiController.text, _fiyatController.text]);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Kaydet',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Vazgeç',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
