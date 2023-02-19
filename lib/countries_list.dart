import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  TextEditingController searchcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices=StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcontroller,
              onChanged: (Value){
                setState(() {

                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(70.0),
                )
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: stateServices.countrieslistApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index){
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(height: 10,width: 89,color: Colors.white),
                                    subtitle: Container(height: 10,width: 89,color: Colors.white),

                                    leading: Container(height: 50,width: 60,color: Colors.white,),
                                  )
                                ],
                              ),
                          );
                        }
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                        String name=snapshot.data![index]['country'];
                        if(searchcontroller.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                    name: snapshot.data![index]["country"],
                                    image: snapshot.data![index]["countryInfo"]['flag'],
                                    totalCases: snapshot.data![index]['todayCases'],
                                    totalDeaths: snapshot.data![index]['totalDeaths'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    test: snapshot.data![index]['test'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                  )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country'],),
                                  subtitle: Text(snapshot.data![index]['cases'].toString(),),

                                  leading: Image(
                                    height:50,
                                    width:50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    ),),
                                ),
                              )
                            ],
                          );
                        }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                    name: snapshot.data![index]["country"],
                                    image: snapshot.data![index]["countryInfo"]['flag'],
                                    totalCases: snapshot.data![index]['todayCases'],
                                    totalDeaths: snapshot.data![index]['totalDeaths'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    test: snapshot.data![index]['test'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],

                                  )));
                                } ,
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country'],),
                                  subtitle: Text(snapshot.data![index]['cases'].toString(),),

                                  leading: Image(
                                    height:50,
                                    width:50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    ),),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Container();

                        }

                        }
                    );
                  }
                }
              )
          )
        ],
      ),
    );
  }
}
