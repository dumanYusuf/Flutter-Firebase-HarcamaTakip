import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harcama_takip/viewModel/auth_view_model.dart';
import 'package:harcama_takip/viewModel/home_page_view_model.dart';
import 'package:provider/provider.dart';
import '../model/banka.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    HomePageViewModel viewModel = Provider.of<HomePageViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title:  Consumer<HomePageViewModel>(builder: (context,viewModel,child){
          return CupertinoSearchTextField(
            controller: viewModel.aramaController,
            onChanged: (arama){
               viewModel.aramaYap(arama);
              print(arama);
            },
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthViewModel>(context, listen: false).signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomePageViewModel>().bankaKaydet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          StreamBuilder<List<Banka>>(
            stream: viewModel.bankaGet(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Hata: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Veri yok'));
              } else {
                var bankaList = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: bankaList.length,
                    itemBuilder: (context, index) {
                      var oankiBanka = bankaList[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          title: Text(oankiBanka.bankaName),
                          subtitle: Text(oankiBanka.harmaMiktari.toString() + " tl harcama yapıldı"),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: (){
                                      viewModel.silme(oankiBanka.bankaId);
                                    },
                                    icon:const  Icon(Icons.delete)),
                                IconButton(
                                    onPressed: (){
                                      viewModel.guncelle(context, oankiBanka.bankaId);
                                    },
                                    icon:const  Icon(Icons.edit))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
