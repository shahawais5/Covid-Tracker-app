import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list.dart';
//import 'package:http/http.dart'as http;

class WordStateScreen extends StatefulWidget {
  const WordStateScreen({Key? key}) : super(key: key);

  @override
  State<WordStateScreen> createState() => _WordStateScreenState();
}

class _WordStateScreenState extends State<WordStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246),
  ];


  // Map<String, double> dataMap = {
  //   "Total": 6,
  //   "Recover": 3,
  //   "Deaths": 2,
  // };
  @override
  Widget build(BuildContext context) {
    StateServices stateServices=StateServices();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            FutureBuilder(
                future: stateServices.fetchworldstatesRecords(),
                builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){

                  if(!snapshot.hasData){
                    return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        )
                    );
                  }else
                    {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Totals": double.parse(snapshot.data!.cases.toString()),
                              "Recover": double.parse(snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString()),

                            },
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorlist,
                          ),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height * .06),
                              child: Column(
                                children: [
                                  ReuseableRow(title: 'Totals', value: snapshot.data!.cases.toString()),
                                  ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                  ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                  ReuseableRow(title: 'Today deaths', value: snapshot.data!.todayDeaths.toString()),
                                  ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
            }
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>CountriesListScreen())
                );
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xff1aa268),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text('Track Countries')),
              ),
            )

          ],
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
