import 'dart:convert';

import 'package:covid_tracker/Services/Utilites/app_urls.dart';
import 'package:http/http.dart'as http;

import '../Model/WorldStatesModel.dart';

class StateServices{

  Future<WorldStatesModel> fetchworldstatesRecords()async{
    final response=await http.get(Uri.parse(AppUrl.worldstatesApi));

    if(response.statusCode==200){
      var data=jsonDecode(response.body.toString());
      print(data);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error');
    }

  }

  Future<List<dynamic>> countrieslistApi()async{
    var data;
    final response=await http.get(Uri.parse(AppUrl.countrieslist));

    if(response.statusCode==200){
       data=jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }

  }
}