import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app_flutter/repository/ogrenciler_repository.dart';

import 'model/ogrenci.dart';

class OgrencilerSayfasi extends ConsumerWidget {
  const OgrencilerSayfasi( {super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
    return  Scaffold(
      appBar: AppBar(title:  Text("Öğrenciler")),
      body:
      Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 20,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
                child: Text(
                    '${ogrencilerRepository.ogrenciler.length} Öğrenci'
                ),
              ),
            ),
          ),
          
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) =>OgrenciSatiri(ogrencilerRepository.ogrenciler[index],

                ) ,
                separatorBuilder: (context, index) => Divider(),
                itemCount: ogrencilerRepository.ogrenciler.length,

            )
          ),
        ],
      ),
    );
  }


}

class OgrenciSatiri extends ConsumerWidget {

  Ogrenci ogrenci;
   OgrenciSatiri(this.ogrenci,  {
    super.key,
  });


  @override
  Widget build(BuildContext context ,WidgetRef ref) {

    final seviyorMuyum = ref.watch(ogrencilerProvider).seviyorMuyum(ogrenci);
    return ListTile(
      title: Text(ogrenci.ad + ' ' +ogrenci.soyad),
      leading:  Text(ogrenci.cinsiyet == 'Kadın' ? '👩‍🦰' : '👨‍🦰'),
      trailing: IconButton(onPressed: () {
   ref.read(ogrencilerProvider).sev(ogrenci, !seviyorMuyum);

      }, icon :Icon(seviyorMuyum ?  Icons.favorite : Icons.favorite_border),
      ));
  }
}
