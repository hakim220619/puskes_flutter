import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puskes/imunisasi/serviceImunisasi.dart';
import 'package:puskes/login/service/servicePage.dart';
import 'package:intl/intl.dart';
import 'package:puskes/penimbangan/servicePenimbangan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImunisasiUsersAdminById extends StatefulWidget {
  const ImunisasiUsersAdminById(
      {Key? key,
      required this.id,
      required this.name,
      required this.jenis_vaksin,
      required this.tanggal_vaksin,
      required this.anak_ke,
      required this.jadwal_mendatang})
      : super(key: key);

      final String id;
      final String name;
      final String jenis_vaksin;
      final String tanggal_vaksin;
      final String anak_ke;
      final String jadwal_mendatang;

  @override
  _ImunisasiUsersAdminByIdState createState() =>
      _ImunisasiUsersAdminByIdState();
}

class _ImunisasiUsersAdminByIdState extends State<ImunisasiUsersAdminById> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  late SharedPreferences profileData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  TextEditingController tanggal_lahir = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Imunisasi'),
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
                      initialValue: widget.name.toString(),
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
                          labelText: 'Nama',
                          hintText: 'Nama'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      obscureText: false,
                      initialValue: widget.jenis_vaksin.toString(),
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
                      initialValue: widget.tanggal_vaksin.toString(),
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
                      initialValue: widget.anak_ke.toString(),
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
                      initialValue: widget.jadwal_mendatang.toString(),
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
                    InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await HttpServiceImunisasi.delete(
                                widget.id.toString(),
                                context);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 10),
                          child: const Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                        ))
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
