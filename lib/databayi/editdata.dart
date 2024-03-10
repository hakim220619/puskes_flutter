import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puskes/databayi/serviceDataBayi.dart';
import 'package:puskes/imunisasi/serviceImunisasi.dart';
import 'package:puskes/keluhan/apiKeluhan.dart';
import 'package:puskes/login/service/servicePage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditDataBayi extends StatefulWidget {
  const EditDataBayi({
    Key? key,
    required this.id,
    required this.nik,
    required this.nama,
    required this.email,
    required this.address,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.bbLahir,
    required this.tbLahir,
    required this.namaOrtu,
  }) : super(key: key);
  final String id;
  final String nik;
  final String nama;
  final String email;
  final String address;
  final String jenisKelamin;
  final String tanggalLahir;
  final String bbLahir;
  final String tbLahir;
  final String namaOrtu;

  @override
  _EditDataBayiState createState() => _EditDataBayiState();
}

class _EditDataBayiState extends State<EditDataBayi> {
  late String nik;
  late String nama;
  late String email;
  late String password;
  late String address;
  var jenis_kelamin;

  late String bb_lahir;
  late String tb_lahir;
  late String nama_ortu;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  // ignore: override_on_non_overriding_member
  List getuserOrtuTerima = [];
  Future getuserOrtu() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var baseUrl = '${dotenv.env['url']}/listUsers';
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print(jsonData);
      setState(() {
        getuserOrtuTerima = jsonData['data'];
        // print(getuserOrtuTerima);
      });
    }
  }

  bool _passwordVisible = false;

  void initState() {
    super.initState();
    getuserOrtu();
    _passwordVisible = false;
// print(widget.tanggalLahir);
    // getagentTo();
  }
  TextEditingController tanggal_lahir = TextEditingController();
  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

final List<String> nameList = <String>[
      "Laki-Laki",
      "Perempuan",
    ];

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Users'),
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
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.nik,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Nik';
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
                          labelText: 'Masukan Nik',
                          hintText: 'Masukan Nik'),
                      onChanged: (value) {
                        setState(() {
                          nik = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.nama,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Nama Lengkap';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'Masukan Nama',
                          hintText: 'Masukan Nama'),
                      onChanged: (value) {
                        setState(() {
                          nama = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.email,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Email';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'Masukan Email',
                          hintText: 'Masukan Email'),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Password';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible =
                                    _passwordVisible ? false : true;
                              });
                            },
                            child: Icon(_passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          prefixIcon: const Icon(Icons.key),
                          labelText: 'Masukan Password',
                          hintText: 'Masukan Password'),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.address,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Address';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.home),
                          labelText: 'Masukan Adrress',
                          hintText: 'Masukan Adrress'),
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.man_2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Jenis Kelamin'),
                      isExpanded: true,
                      items: nameList.map(
                        (item) {
                          return DropdownMenuItem(
                            
                            value: item,
                            child: Text(item),
                          );
                        },
                      ).toList(),
                      validator: (value) {
                        if (value == null) return 'Silahkan Masukan Data';
                        return null;
                      },
                      value: widget.jenisKelamin,
                      onChanged: (vale) {
                        setState(() {
                          jenis_kelamin = vale;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
              //  initialValue: widget.tanggalLahir.toString(),
                      readOnly: true,
                      controller: tanggal_lahir,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.date_range),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Pilih Tanggal'),
                      validator: (value) {
                        if (value == false) return 'Silahkan Pilih Tanggal';
                        return null;
                      },
                      onTap: () async {
                        DateFormat('dd/mm/yyyy').format(DateTime.now());
                        var date = await showDatePicker(
                            context: context,
                            
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1999),
                            lastDate: DateTime.now());
                        if (date == null) {
                    //  print(date);
                          tanggal_lahir.text = widget.tanggalLahir;
                        } else {
                          tanggal_lahir.text = date.toString().substring(0, 10);
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.namaOrtu,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Nama Ortu';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.person_2_sharp),
                          labelText: 'Masukan Nama Orang Tua',
                          hintText: 'Masukan Nama Orang Tua'),
                      onChanged: (value) {
                        setState(() {
                          nama_ortu = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.bbLahir,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Berat Badan';
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
                          labelText: 'Masukan Berat badan',
                          hintText: 'Masukan Berat badan'),
                      onChanged: (value) {
                        setState(() {
                          bb_lahir = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.tbLahir,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan Nik';
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
                          labelText: 'Masukan Tinggi Badan',
                          hintText: 'Masukan Tinggi Badan'),
                      onChanged: (value) {
                        setState(() {
                          tb_lahir = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await HttpServiceDataBayi.editData(
                              widget.id,
                                 nik,
                                nama,
                                email,
                                password,
                                address,
                                jenis_kelamin,
                                tanggal_lahir,
                                nama_ortu,
                                bb_lahir,
                                tb_lahir,
                                context);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 10),
                          child: const Center(
                            child: Text(
                              "Simpan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(9, 107, 199, 1),
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
