import 'package:flutter/material.dart';
import 'unit.dart';
import 'converterScreen.dart';
import 'conversionScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.blue[500],
        dividerColor: Colors.black,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //List<Category> categories =
    String _icon(String name){
      String str;
      switch(name){
        case "Lentgh":
          str = 'assets/icons/length.png';
          break;
        case "Volume":
          str = 'assets/icons/volume.png';
          break;
        case 'Mass':
          str = 'assets/icons/mass.png';
          break;
        case 'Area':
          str ='assets/icons/area.png';
          break;
        case 'Energy':
          str ='assets/icons/currency.png';
          break;
        case 'Time':
          str = 'assets/icons/time.png';
          break;  
      }
      return str;
    }
    final List<String> names = ["Lentgh", "Volume" , "Mass" , "Area" , "Energy" , "Time"];
    /*List<String> icons = [ 'assets/icons/length.png', 'assets/icons/volume.png', 'assets/icons/mass.png', 'assets/icons/area.png',
             'assets/icons/currency.png' , 'assets/icons/time.png'];*/
    List<Unit> _unitList(String name){
      List<Unit> units;
      switch(name){
        case "Lentgh":
          units = [Unit("Meter",100.0),Unit("Centimeter",1.0),Unit("Kilometer",100000.0)];
          break;
        case "Time":
          units = [Unit("Seconds",1.0),Unit("Minutes",60.0),Unit("Hours",3600.0)];
          break;
        case "Mass":
          units = [Unit("Gram",1.0),Unit("Kilogram",1000.0),Unit("Tonne",1000000.0)];
          break;
        default: units = [Unit("Unit1",1.0),Unit("Unit2",10.0)];
      }
      return units;
    }
    List<Category> categories = names.map((String name){
      return Category(name,_unitList(name),_icon(name));
    }).toList();
    Widget _buildCategorie(context){
      if(MediaQuery.of(context).orientation== Orientation.portrait)
        return ListView.builder(
          itemBuilder: (context, index) => new Category(names[index],_unitList(names[index]),_icon(names[index])),
          itemCount: names.length,
        );
      else return GridView.count(crossAxisCount: 2,childAspectRatio: 3.0,children: categories,);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Converter'),
        centerTitle: true,
      ),
      //body: Category(parameter: listOfParameter[0]),
      body: _buildCategorie(context),
    );
  }
}

class Category extends StatelessWidget {
  Category(this.name,this.units,this.icon);
  final String name;
  final List<Unit> units;
  final String icon;
  String _icon(String name){
    String str;
    switch(name){
      case "Lentgh":
        str = 'assets/icons/length.png';
        break;
      case "Volume":
        str = 'assets/icons/volume.png';
        break;
      case 'Mass':
        str = 'assets/icons/mass.png';
        break;
      case 'Area':
        str ='assets/icons/area.png';
        break;
      case 'Energy':
        str ='assets/icons/currency.png';
        break;
      case 'Time':
        str = 'assets/icons/time.png';
        break;
    }
    return str;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      height: 60.0,
      child: InkWell(
        highlightColor: Colors.yellow[200],
        splashColor: Colors.yellow[50],
        onTap: () {
          //Navigator.push(context, MaterialPageRoute(builder: (context) => ConverterScreen(units: units,title: name,)));
          Navigator.push(context, MaterialPageRoute(builder: (context) => ConversionScreen(units: units,title: name,imgName: _icon(name),)));
          /*
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Scaffold(
              appBar: AppBar(
                title: Text(parameter.text,style: Theme.of(context).textTheme.headline,),
                centerTitle: true,
              ),

            );
          }));
          */
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Image.asset(icon,width: 35.0,height: 42.0,),

            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Center(
                  child: Text(
                name,
                style: Theme.of(context).textTheme.headline,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.green,
    );
  }
}

class Parameter {
  Parameter({this.icon, this.text, this.wid});
  String text;
  IconData icon;
  Widget wid;
}

/*
List<Parameter> listOfParameter = [
  new Parameter(
      icon: Icons.contacts,
      text: 'Length',
      wid: ConverterScreen(
        units: ['cm', 'mm', 'km', 'dm'],
        title: 'Length',
      )),
  new Parameter(
      icon: Icons.star,
      text: 'Mass',
      wid: ConverterScreen(units: [
        'g',
        'kg',
        'dg',
        'tonne',
      ], title: 'Mass')),
  new Parameter(
      icon: Icons.image,
      text: 'Volume',
      wid: ConverterScreen(
          units: ['m²', 'm3', 'litre', 'centilitre'], title: 'Volume')),
  new Parameter(
      icon: Icons.more,
      text: 'Surface',
      wid:
          ConverterScreen(units: ['m²', 'km²', 'ar', 'hec'], title: 'Surface')),
  new Parameter(
      icon: Icons.timer,
      text: 'Time',
      wid: ConverterScreen(units: ['ms', 's', 'mn', 'heure'], title: 'Time')),
  new Parameter(
      icon: Icons.add,
      text: 'Energy',
      wid: ConverterScreen(units: ['Jul', 'Kj'], title: 'Energy')),
  new Parameter(icon: Icons.more, text: 'Area'),
];*/
