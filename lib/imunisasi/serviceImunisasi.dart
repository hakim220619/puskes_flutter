// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puskes/imunisasi/imunisasiPage.dart';


class HttpServiceImunisasi {
  static final _client =http.Client() ;

  static final _keluhanUrl = Uri.parse('${dotenv.env['url']}/addImunisasi');
  static addimunisasi(getIdOrtu, tanggalVaksin, anakke, jenisVaksin, jadwalMendatang, context) async {

    EasyLoading.show(status: 'loading...');
    http.Response response = await _client
        .post(_keluhanUrl, body: {"id_user": getIdOrtu.toString(), "tanggal_vaksin": tanggalVaksin, "anak_ke": anakke.toString(), "jenis_vaksin": jenisVaksin, "jadwal_mendatang": jadwalMendatang});
        print(response.body);
    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names

      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const ListImunisasi(),
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