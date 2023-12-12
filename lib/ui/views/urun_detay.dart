import 'package:delivery_app/data/entity/yemekler.dart';
import 'package:delivery_app/ui/cubit/urunDetay_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrunDetay extends StatefulWidget {
  Yemekler yemek;


  UrunDetay({required this.yemek});

  @override
  State<UrunDetay> createState() => _UrunDetayState();
}

class _UrunDetayState extends State<UrunDetay> {
  int _counter = 0;
  void arttir (){
    setState(() {
      _counter++;
    });}
  void azalt (){
    setState(() {
      _counter--;
    });}

  var tfKullaniciAdi = "mmyildirrim";

  @override
  Widget build(BuildContext context) {
    var url = "https://kasimadalan.pe.hu/yemekler/resimler/";
    return Scaffold(
      appBar: AppBar(title: Text("Ürün Detayı"),centerTitle: true,),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.yemek.yemek_adi}",style: const TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color: Colors.black ),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start,children: [IconButton(onPressed: (){}, icon: Icon(Icons.access_time),color: Colors.deepPurpleAccent,),
                  Text("30-40 dk"),],),
                Row(mainAxisAlignment: MainAxisAlignment.start,children: [IconButton(onPressed: (){}, icon: Icon(Icons.delivery_dining),color: Colors.deepPurpleAccent,),
                  Text("Ücretsiz Teslimat"),],),
                Row(mainAxisAlignment: MainAxisAlignment.start,children: [IconButton(onPressed: (){}, icon: Icon(Icons.attach_money),color: Colors.deepPurpleAccent,),
                  Text("İndirim %30 "),],),
              ],
            ),
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Text("₺${widget.yemek.yemek_fiyat}",style: const TextStyle(fontSize: 50,color: Colors.deepPurpleAccent),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Sipariş Adedi: ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.redAccent),),
                SizedBox(
                  width: 150,
                  height: 80,
                  child: Card(
                    color: Colors.white70,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(onPressed: azalt, icon: Icon(Icons.remove,color: Colors.red,size: 35,)),
                        Text("$_counter",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.deepPurpleAccent),),
                        IconButton(onPressed: arttir, icon: Icon(Icons.add,color: Colors.red,size: 35,)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  context.read<UrunDetayCubit>().sepetEkle(widget.yemek.yemek_adi,
                      widget.yemek.yemek_resim_adi,
                      int.parse(widget.yemek.yemek_fiyat),
                      int.parse(_counter.toString()),
                      tfKullaniciAdi,
                  );

                }, child: Text("SEPETE EKLE",style: TextStyle(fontSize: 25),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


