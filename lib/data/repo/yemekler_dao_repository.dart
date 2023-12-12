import 'dart:convert';
import 'package:delivery_app/data/entity/sepet_yemekler.dart';
import 'package:delivery_app/data/entity/sepet_yemekler_cevap.dart';
import 'package:delivery_app/data/entity/yemekler.dart';
import 'package:delivery_app/data/entity/yemekler_cevap.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepository {


  List<Yemekler> parseYemeklerCevap (String cevap) {
    try{
      return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
    }
    catch (e){
      print("JSON Ayrıştırma Hatası: $e");
      return [];
    }
  }

  List<SepetYemekler> parseSepetYemeklerCevap (String cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemeklerCevap(cevap.data.toString());
  }


  Future<List<SepetYemekler>> sepetYemekleriYukle(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    return parseSepetYemeklerCevap(cevap.data.toString());
  }



  Future<List<SepetYemekler>> sepettenCikart(int sepet_yemek_id,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    return parseSepetYemeklerCevap(cevap.data.toString());
  }



  Future<void> sepeteEkle (String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet,String kullanici_adi) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi":yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
    var cevap=  await Dio().post(url,data: FormData.fromMap(veri));
    print("Sepete eklendi: ${cevap.data.toString()}");
  }

  Future<int>toplamFiyat(String yemek_fiyat,String yemek_siparis_adet ) async{
    int toplamFiyat = int.parse(yemek_fiyat) * int.parse(yemek_siparis_adet);
    return toplamFiyat;
  }



}


