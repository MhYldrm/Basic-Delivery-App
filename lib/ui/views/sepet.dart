import 'package:delivery_app/data/entity/sepet_yemekler.dart';
import 'package:delivery_app/ui/cubit/sepet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {
  SepetYemekler sepetYemekler;
  SepetSayfa({required this.sepetYemekler});
  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  final String kullanici_adi = "mmyildirrim";
  var toplamFiyat = 0;
  int? tumSepetToplamFiyat;

  int toplamSepetFiyat(String yemek_siparis_adet, String yemek_fiyat) {
    toplamFiyat = int.parse(yemek_siparis_adet) * int.parse(yemek_fiyat);
    return toplamFiyat;
  }

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekleriYukle(kullanici_adi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Sepetim",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color(0xFFF2F2F2)),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 700,
                width: 500,
                child: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
                  builder: (context, sepetYemekListesi) {
                    if (sepetYemekListesi.isNotEmpty) {
                      var toplam = 0;
                      for (var x in sepetYemekListesi) {
                        toplam += int.parse(x.yemek_siparis_adet) *
                            int.parse(x.yemek_fiyat);
                        tumSepetToplamFiyat = toplam;
                        print("$toplam ,,,, $tumSepetToplamFiyat");
                      }
                      return Container(
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: sepetYemekListesi.length,
                                itemBuilder: (context, indeks) {
                                  var yemekListesi = sepetYemekListesi[
                                      indeks]; //yemeklistesi.widget
                                  return Card(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.network(
                                          "http://kasimadalan.pe.hu/yemekler/resimler/${yemekListesi.yemek_resim_adi}",
                                          width: 120,
                                          height: 120,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "${yemekListesi.yemek_adi}",
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Fiyat: ",
                                                  style: TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  "₺${yemekListesi.yemek_fiyat}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Adet: ",
                                                  style: TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  "${yemekListesi.yemek_siparis_adet}",
                                                  style: TextStyle(fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                context
                                                    .read<SepetSayfaCubit>()
                                                    .sepettenCikart(
                                                        int.parse(yemekListesi
                                                            .sepet_yemek_id),
                                                        kullanici_adi);
                                                setState(() {
                                                  context
                                                      .read<SepetSayfaCubit>()
                                                      .sepetYemekleriYukle(
                                                          kullanici_adi);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete_rounded,
                                                color: Colors.deepPurpleAccent,
                                                size: 45,
                                              ),
                                            ),
                                            Text("${toplamSepetFiyat(yemekListesi.yemek_siparis_adet, yemekListesi.yemek_fiyat)}",
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Gönderim Ücreti",
                                          style: TextStyle(fontSize: 17),
                                          textAlign: TextAlign.start),
                                      Text(
                                        "Toplam:       ",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "₺ 0",
                                        style: TextStyle(fontSize: 17),
                                        textAlign: TextAlign.end,
                                      ),
                                      Text("₺$tumSepetToplamFiyat",
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("Sepetinizde ürün yoktur"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 350,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Sepeti Onayla",
                style: TextStyle(fontSize: 23, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  elevation: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
