import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ogrenci_app_flutter/repository/mesajlar_repository.dart';

class Mesajlar extends StatefulWidget {
  final MesajlarRepository mesajlarRepository;

  const Mesajlar( this.mesajlarRepository, {super.key});

  @override
  State<Mesajlar> createState() => _MesajlarState();
}

class _MesajlarState extends State<Mesajlar> {

  @override
  void initState() {
    widget.mesajlarRepository.yeniMesajSayisi = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mesajlar"),),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.mesajlarRepository.mesajlar.length,

              itemBuilder: (context, index) {

                return MesajGorunumu(
                  widget.mesajlarRepository.mesajlar[widget.mesajlarRepository.mesajlar.length - index - 1],


                );
              },
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print('Gönder');
                    },
                    child: const Text('Gönder'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MesajGorunumu extends StatelessWidget {
  final Mesaj mesaj;
  const MesajGorunumu(this.mesaj, {
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mesaj.gonderen == "Ali" ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            color: Colors.orange.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child:  Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(mesaj.yazi),
          ),
        ),
      ),
    );
  }
}
