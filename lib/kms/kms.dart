import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class ChartPageKms extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartPageKms({Key? key}) : super(key: key);

  @override
  ChartPageKmsState createState() => ChartPageKmsState();
}

class ChartPageKmsState extends State<ChartPageKms> {
  List<_SalesData> data = [
    _SalesData('35', 35),
    _SalesData('28', 28),
    _SalesData('34', 34),
    _SalesData('32', 32),
    _SalesData('40', 40)
  ];
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