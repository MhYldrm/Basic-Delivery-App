import 'package:delivery_app/data/entity/yemekler.dart';
import 'package:delivery_app/data/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrunDetayCubit extends Cubit<List<Yemekler>> {

  UrunDetayCubit():super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> sepetEkle (String yemek_adi,String yemek_resim_adi,int yemek_fiyati,int yemek_siparis_adet, String kullanici_adi) async {
    await yrepo.sepeteEkle(yemek_adi,yemek_resim_adi,yemek_fiyati,yemek_siparis_adet,kullanici_adi);
  }





}