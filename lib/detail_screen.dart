import 'package:covid_tracker/word_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;

  int ? totalCases, totalDeaths,   active, critical, test,todayRecovered;
   DetailScreen({
    required this.name,
    required this.image,
     required this.todayRecovered,
     required this.critical,
     required this.active,
     required this.test,
     required this.totalCases,
     required this.totalDeaths,


});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                child: Card(
                
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*.06,),
                        ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReuseableRow(title: 'TodayRecovered', value: widget.todayRecovered.toString()),
                        ReuseableRow(title: 'TotalDeaths', value: widget.totalDeaths.toString()),
                        ReuseableRow(title: 'Tests', value: widget.test.toString()),
                        ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                        ReuseableRow(title: 'active', value: widget.active.toString()),


                      ],
                    ),
                  ),
              ),
              
              CircleAvatar(
                radius: 50,
                child: Image(image: NetworkImage(widget.image),),
              )
            ],
          )
        ],
      ),
    );
  }
}
