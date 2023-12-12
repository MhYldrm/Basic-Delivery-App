import 'package:delivery_app/data/entity/yemekler.dart';
import 'package:delivery_app/data/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{

  AnasayfaCubit():super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();


  Future<void> yemekleriYukle () async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }






}