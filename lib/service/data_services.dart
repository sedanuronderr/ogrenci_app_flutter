import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/ogretmen.dart';
import 'package:http/http.dart' as http;

class DataService {

  final String baseUrl= "https://615d80a012571a0017207680.mockapi.io/";


  Future<Ogretmen> ogretmenIndir() async {



    final response = await http.get(Uri.parse("$baseUrl/ogretmen/1"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Ogretmen.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }





  }

}

final dataServiceProvider = Provider((ref) {
  return DataService();
});