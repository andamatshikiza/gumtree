import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;

import 'ItemListView.dart';

void main() => runApp(new MaterialApp(home: new Search(),));



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GumTree',
      home: Scaffold(
        appBar: AppBar(
          title: Text('GumTree'),
        ),
        body: Center(
          child: ItemListView(),
        ),
      ),
    );
  }


}

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> new SearchState();


}
class SearchState extends State<Search>{
  List<String> items;
  TextEditingController controller = new TextEditingController();
  String fil;

  get itemCount => null;

 @override
initState(){controller.addListener((){
  setState((){
    fil = controller.text;
  });
});

 @override
 void dispose(){
 controller.dispose();
 super.dispose();}





 }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget build(BuildContext context){
      return new Material(child: new Column(children: <Widget>[new Padding(padding: new EdgeInsets.only(top: 20.0)),new TextField(decoration: new InputDecoration(labelText: "Search Item"),controller: controller,),
        new Expanded(child: new ListView.builder(itemCount:items.length ,itemBuilder: (BuildContext context,int index){
          return new Card(child:new Text(items[index]));
        }))],),);


    } new ListView.builder(itemBuilder: itemCount: items.length,itemBuilder: (BuilderContext context,int index){
      return fil == null || fil == ""?new Card(child: new Text(items[index])):items[index].contains(fil)? new Card(child: Text(items[index])):new Container();
    };);
    return null;
  }

}


