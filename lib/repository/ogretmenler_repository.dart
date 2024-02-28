import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/ogretmen.dart';
import '../service/data_services.dart';

class OgretmenlerRepository extends ChangeNotifier {

  List ogretmenler = [
    Ogretmen('Faruk', 'Yılmaz', 18, 'Erkek'),
    Ogretmen('Semiha', 'Çelik', 20, 'Kadın'),
  ];
  final DataService dataService;
  OgretmenlerRepository(this.dataService);

Future<void> download() async {
  const j = """{
      "ad": "Yeni",
      "soyad": "Yenioğlu",
      "yas": 22,
      "cinsiyet": "Erkek"
    }""";

 // final m = jsonDecode(j);

  //final ogretmen = Ogretmen.fromMap(m);

Ogretmen ogretmen = await dataService.ogretmenIndir() ;
  ogretmenler.add(ogretmen);
  notifyListeners();
}
}
final ogretmenlerProvider = ChangeNotifierProvider((ref) {
  return OgretmenlerRepository(ref.watch(dataServiceProvider));
});



