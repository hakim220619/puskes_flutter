import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puskes/login/service/servicePage.dart';
import 'package:intl/intl.dart';
import 'package:puskes/penimbangan/servicePenimbangan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImunisasiUsersById extends StatefulWidget {
  const ImunisasiUsersById({Key? key}) : super(key: key);

  @override
  _ImunisasiUsersByIdState createState() => _ImunisasiUsersByIdState();
}

class _ImunisasiUsersByIdState extends State<ImunisasiUsersById> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _listsData = [];
  String jenis_vaksin = '';
  String tanggal_vaksin = '';
  String anak_ke = '';
  String jadwal_mendatang = '';
  Future<dynamic> ListUsersById() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      var url = Uri.parse('${dotenv.env['url']}/liestImunisasiById');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      // print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print(data);
        setState(() {
          _listsData = data['data'];
          jenis_vaksin = data['data'][0]['jenis_vaksin'];
          tanggal_vaksin = data['data'][0]['tanggal_vaksin'];
          anak_ke = data['data'][0]['anak_ke'];
          jadwal_mendatang = data['data'][0]['jadwal_mendatang'];
        });
      }
    } catch (e) {
      // print(e);
    }
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  late SharedPreferences profileData;
  String? bb_lahir;
  String? tb_lahir;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ListUsersById();
  }

  TextEditingController tanggal_lahir = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Imunisasi'),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      obscureText: false,
                      initialValue: jenis_vaksin,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis Vaksin';
                        }
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.scale),
                          labelText: 'Jenis Vaksin',
                          hintText: 'Jenis Vaksin'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: tanggal_vaksin,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal Vaksin';
                        }
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.person_3_outlined),
                          labelText: 'Tanggal Vaksin',
                          hintText: 'Tanggal Vaksin'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue: anak_ke,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Anak Ke';
                        }
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.person_3_outlined),
                          labelText: 'Anak Ke',
                          hintText: 'Anak Ke'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      initialValue:
                          jadwal_mendatang,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jadwal Mendatang';
                        }
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.person_3_outlined),
                          labelText: 'Jadwal Mendatang',
                          hintText: 'Jadwal Mendatang'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
