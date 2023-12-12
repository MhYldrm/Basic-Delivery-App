import 'package:delivery_app/data/entity/sepet_yemekler.dart';
import 'package:delivery_app/data/entity/yemekler.dart';
import 'package:delivery_app/ui/cubit/anasayfa_cubit.dart';
import 'package:delivery_app/ui/cubit/sepet_cubit.dart';
import 'package:delivery_app/ui/cubit/urunDetay_cubit.dart';
import 'package:delivery_app/ui/views/profile.dart';
import 'package:delivery_app/ui/views/sepet.dart';
import 'package:delivery_app/ui/views/urun_detay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }
  var currentindex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Anasayfa();
  var selected = 0;
  var kullanici_adi = "mmyildirrim";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
        title: Text("TadıBaska",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28,fontFamily:"Permanent",fontStyle: FontStyle.italic),
      ),centerTitle: true,backgroundColor: Colors.deepPurpleAccent,
        leading: Image.asset("images/logoo.png",color: Colors.black,height: 300 ,width: 100,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: GestureDetector(
              onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage())),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.deepOrange,
                backgroundImage: AssetImage("images/person.png",),
              ),
            ),
          ),
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Column(mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 715,
                    child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
                        builder: (context,yemeklerListesi){
                          if(yemeklerListesi.isNotEmpty){
                            return GridView.builder(
                              itemCount: yemeklerListesi.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1 / 1.5),
                              itemBuilder: (context,indeks){
                                var yemek = yemeklerListesi[indeks];
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => UrunDetay(yemek: yemek)))
                                        .then((value) {
                                      print("Anasayfaya dönüldü"); // sepete ekle kodunu yazacağız buraya
                                    });
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    shadowColor: Colors.black,
                                    elevation: 5,
                                    margin: EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                        Text("${yemek.yemek_adi}",style: const TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black ),),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 10),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("₺${yemek.yemek_fiyat}",style: const TextStyle(fontSize: 23,color: Colors.deepPurpleAccent),),
                                              IconButton(onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> UrunDetay(yemek: yemek)));
                                              }, icon: Icon(Icons.shopping_cart_rounded,size: 30,color:Colors.blueGrey ,)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }else{
                            return const Center();
                          }
                        }
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          var sepetYemekler = SepetYemekler(sepet_yemek_id: "1", yemek_adi: "yemek_adi", yemek_resim_adi: "yemek_resim_adi", yemek_fiyat: "yemek_fiyat", yemek_siparis_adet: "yemek_siparis_adet", kullanici_adi: "kullanici_adi");
          Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(sepetYemekler: sepetYemekler))).then((value) {
            context.read<SepetSayfaCubit>().sepetYemekleriYukle(kullanici_adi);
          }
          );
        },
        child: Icon(Icons.shopping_cart_rounded),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 68,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.grey.shade200,
        elevation: 25,
        child: Container(
          height: 40,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                      minWidth: 20,
                      onPressed: (){
                        setState(() {
                          currentScreen = Anasayfa();
                          currentindex = 0;
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: currentindex == 0 ? Colors.deepPurpleAccent : Colors.grey.withOpacity(0.5),),
                      Text("Anasayfa",style: TextStyle(color:currentindex == 0 ? Colors.deepPurpleAccent : Colors.grey.withOpacity(10.0), ),),
                    ],
                  ),
                  ),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentindex == 0 ? Colors.deepPurpleAccent : Colors.grey.withOpacity(0.5),),
                        Text("Hesabım",style: TextStyle(color:currentindex == 0 ? Colors.deepPurpleAccent : Colors.grey.withOpacity(0.5), ),),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
