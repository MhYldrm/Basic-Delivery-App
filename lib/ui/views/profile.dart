import 'package:delivery_app/data/entity/sepet_yemekler.dart';
import 'package:delivery_app/ui/cubit/sepet_cubit.dart';
import 'package:delivery_app/ui/views/anasayfa.dart';
import 'package:delivery_app/ui/views/sepet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.deepOrange,
              backgroundImage: AssetImage("images/person.png",),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Image.asset("images/fast.webp"),
            SizedBox(height: 10,),
            Text("Hızlı ve Guvenilir ",style: TextStyle(fontSize: 23),),
            Text("Bir Alışveriş için vakit",style: TextStyle(fontSize: 23),),
            Text("Kaybetmeyin",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,fontFamily: "Permanent",color: Colors.deepOrange),),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(80.0),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Anasayfa()));
                  },
                style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Simdi Baslayin",style: TextStyle(color: Colors.white,fontSize: 22,fontFamily: "Permanent"),),
                      Icon(Icons.shopping_bag_rounded,color: Colors.greenAccent),
                    ],
                  ),
              ),
            ),
          ],
        ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Anasayfa()));
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.deepPurpleAccent ),
                        Text("Anasayfa",style: TextStyle(color: Colors.deepPurpleAccent ), ),
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
                            Icons.home,
                            color: Colors.deepPurpleAccent ),
                        Text("Hesabım",style: TextStyle(color: Colors.deepPurpleAccent ), ),
                      ],
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(sepetYemekler: sepetYemekler)));
        },
        child: Icon(Icons.shopping_cart_rounded),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
