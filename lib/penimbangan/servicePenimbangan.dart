// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:puskes/listusers/listusers.dart';
import 'package:puskes/login/view/login.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpServicePenimbangan {
  static final _client =http.Client() ;

  static final _updatePenimbangan = Uri.parse('${dotenv.env['url']}/updatepenimbangan');

  static penimbangan(bbLahir, tbLahir, id, context) async {
print(bbLahir);
print(id);
    EasyLoading.show(status: 'loading...');
    http.Response response = await _client
        .post(_updatePenimbangan, body: {"bb_lahir": bbLahir, "tb_lahir": tbLahir, "id": id});

    print(response.body);
    if (response.statusCode == 200) {
      // ignore: non_constant_identifier_names

      EasyLoading.dismiss();
      // print(Users);
     

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const ListUsers(),
        )
       
      );
    } else {
      print(response);
      EasyLoading.showError('Login Gagal');
      EasyLoading.dismiss();
    }
  }
}
