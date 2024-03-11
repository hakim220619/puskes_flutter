import 'package:flutter/material.dart';
import 'package:puskes/home/HomePage.dart';
import 'package:puskes/keluhan/addkeluhanPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class KeluhanPage extends StatefulWidget {
  const KeluhanPage({
    Key? key,
  }) : super(key: key);

  @override
  State<KeluhanPage> createState() => _KeluhanPageState();
}

List _listsData = [];

class _KeluhanPageState extends State<KeluhanPage> {
  Future<dynamic> listKeluhan() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      var id = preferences.getString('id');
      var url = Uri.parse('${dotenv.env['url']}/keluhan/$id');
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
          print(_listsData);
        });
      }
    } catch (e) {
      // print(e);
    }
  }

  // Sample data for three lists
  @override
  void initState() {
    super.initState();
    listKeluhan();
  }

  Future refresh() async {
    setState(() {
      listKeluhan();
    });
  }
  void addKeluhan(){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const AddKeluhanPage(),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keluhan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
              onTap: () {
                Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Homepage()));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(253, 255, 252, 252),
              ),
            ),
        backgroundColor: Colors.blue[300],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView.builder(
          itemCount: _listsData.length,
          itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                      'Pertanyaan'),
                ),
                const Divider(),
                ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text('${_listsData[index]["pertanyaan"]}'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addKeluhan,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // Th
    );
  }
}
