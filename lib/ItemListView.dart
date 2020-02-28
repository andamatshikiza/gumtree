import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;

class Item {
  final int itemId;
  final String title;
  final String price;
  final String condition;

  Item({this.itemId, this.title, this.price, this.condition});

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(itemId: json['itemId'],
        title: json['title'],
        price: json['price'],
        condition: json['condition']);
  }
}

class ItemListView extends StatefulWidget{
  @override

  Widget _build(BuildContext context){
    return FutureBuilder<List<Item>>(
      future: fetchData(), builder: (context,snapshot){
      if(snapshot.hasData){
        List<Item> data = snapshot.data;
        return itemsListView(data);
      }else if(snapshot.hasError){
        return Text("${snapshot.error}");
      }
      return CircularProgressIndicator();
    },
    );
  }

  Future<List<Item>> fetchData () async{

    final itemsListUrl = 'https://api.sandbox.ebay.com/buy/browse/v1/item_summary/search?q=dog';
    final response = await http.get(itemsListUrl);

    if(response.statusCode == 200){
      List jsonresponse = json.decode(response.body);
      return jsonresponse.map((item)=> new Item.fromJson(item)).toList();
    }else{
      throw Exception('Failed to load items');
    }
  }

  ListView itemsListView(data){
    return ListView.builder(itemCount: data.length,itemBuilder: (context,index){
      return _tile(data[index].title,data[index].price)
    });
  }

  ListTile _tile(String title,String price)=>ListTile(title: Text(title,style: TextStyle(fontSize: 20),),subtitle: Text(price),);
}