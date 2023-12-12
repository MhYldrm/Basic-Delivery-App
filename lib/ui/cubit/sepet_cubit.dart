import 'package:delivery_app/data/entity/sepet_yemekler.dart';
import 'package:delivery_app/data/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{

  SepetSayfaCubit():super(<SepetYemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepetYemekleriYukle (String kullanici_adi) async {
    var liste = await yrepo.sepetYemekleriYukle(kullanici_adi);
    emit(liste);
  }

  Future<void> sepettenCikart(int sepet_yemek_id,String kullanici_adi) async{
    await yrepo.sepettenCikart(sepet_yemek_id, kullanici_adi);
  }

  Future<void>toplamFiyat(String yemek_fiyat,String yemek_siparis_adet ) async{
    int cevap = await yrepo.toplamFiyat(yemek_fiyat, yemek_siparis_adet);
  }
}