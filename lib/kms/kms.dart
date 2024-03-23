import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;

class ChartPageKms extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartPageKms({Key? key}) : super(key: key);

  @override
  ChartPageKmsState createState() => ChartPageKmsState();
}

List<_SalesData> data = [];

class ChartPageKmsState extends State<ChartPageKms> {
  Future<dynamic> listKeluhan() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      var url = Uri.parse('${dotenv.env['url']}/getGravikSiswa');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      // print(response.body);
      if (response.statusCode == 200) {
        final dataAll = jsonDecode(response.body);
        setState(() {
          for (var da in dataAll['data']) {
            print(da['bb_lahir']);
            data.add(_SalesData(
                '${da['name']}', double.parse('${(da['bb_lahir'])}')));
          }
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

  @override
  void dispose() {
    data = [];
    // ignore: avoid_print
    print('Dispose used');
    super.dispose();
  }

  //  List<_SalesData> data = [ _SalesData('asd', 40)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kms'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Kms analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Berat Badan',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     //Initialize the spark charts widget
          //     child: SfSparkLineChart.custom(
          //       //Enable the trackball
          //       trackball: SparkChartTrackball(
          //           activationMode: SparkChartActivationMode.tap),
          //       //Enable marker
          //       marker: SparkChartMarker(
          //           displayMode: SparkChartMarkerDisplayMode.all),
          //       //Enable data label
          //       labelDisplayMode: SparkChartLabelDisplayMode.all,
          //       xValueMapper: (int index) => data[index].year,
          //       yValueMapper: (int index) => data[index].sales,
          //       dataCount: 5,
          //     ),
          //   ),
          // )
        ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
