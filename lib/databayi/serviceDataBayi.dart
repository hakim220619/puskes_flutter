// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puskes/imunisasi/imunisasiPage.dart';

class HttpServiceDataBayi {
  static final _client = http.Client();

  static final _keluhanUrl = Uri.parse('${dotenv.env['url']}/addImunisasi');
  static editData(id, nik, name, email, password, address, jenis_kelamin, tanggal_lahir, nama_ortu, bb_lahir, tb_lahir, context) async {
    EasyLoading.show(status: 'loading...');
    http.Response response = await _client.post(_keluhanUrl, body: {
      "nik": nik,
      "name": name,
      "email": email,
      "password": password,
      "address": address,
      "jenis_kelamin": jenis_kelamin,
      "tanggal_lahir": tanggal_lahir.text,
      "nama_ortu": nama_ortu,
      "bb_lahir": bb_lahir,
      "tb_lahir": tb_lahir,
    });
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
