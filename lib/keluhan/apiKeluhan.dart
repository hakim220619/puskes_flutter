// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:puskes/keluhan/keluhanPage.dart';
import 'package:puskes/keluhan/listKeluhanUsers.dart';

class HttpServiceKeluhan {
  static final _client =http.Client() ;

  static final _keluhanUrl = Uri.parse('${dotenv.env['url']}/addKeluhan');
  static addKeluhan(pertanyaan, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     var id_ortu = preferences.getString('id');
    EasyLoading.show(status: 'loading...');
    http.Response response = await _client
        .post(_keluhanUrl, body: {"pertanyaan": pertanyaan, "id_ortu": id_ortu, "id_admin": '1'});
    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names

      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const KeluhanPage(),
        ),
       
      );
      // var Users = jsonDecode(response.body);
      // print(Users);
     
    } else {
      EasyLoading.showError('Insert Gagal');
      EasyLoading.dismiss();
    }
  }
    static final _jawabanUrl = Uri.parse('${dotenv.env['url']}/addJawaban');
  static addJawaban(jawaban, id_ortu, id, context) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    //  var id_ortu = preferences.getString('id');
    EasyLoading.show(status: 'loading...');
    http.Response response = await _client
        .post(_jawabanUrl, body: {"jawaban": jawaban, "id_ortu": id_ortu, "id_admin": '1', "id": id});

        print(response.body);
    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names

      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const ListKeluhanUsers(),
        ),
      );
      // var Users = jsonDecode(response.body);
      // print(Users);
     
    } else {
      EasyLoading.showError('Insert Gagal');
      EasyLoading.dismiss();
    }
  }

  
}
