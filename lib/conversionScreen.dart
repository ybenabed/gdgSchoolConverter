import 'package:flutter/material.dart';
import 'unit.dart';

class ConversionScreen extends StatefulWidget {
  ConversionScreen({this.units, this.title,this.imgName});
  List<Unit> units;
  String title;
  String imgName;
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  int _inputV;double _conv;
  TextEditingController myController = new TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  void initState(){
    _inputV = 0;
    createElements(0, 1.0);
  }
  void createElements(int ind,double value){
    for(Unit unit in widget.units){
      if(unit.name != widget.units[ind].name) {
        double val = value * (widget.units[ind].wieght) / (unit.wieght) ;
        rows.add(
          TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 20.0),
                  child: Text(
                    unit.name,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0,top: 5.0,bottom: 5.0),
                  child: Text(
                    '$val',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]
          ),
        );
      }
    }
  }
  List<TableRow> rows = new List<TableRow>();

  Widget build(BuildContext context){
    Widget entryContainer = Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: EdgeInsets.only(right: 10.0,left: 10.0,bottom: 15.0,top: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Image.asset(widget.imgName,height: 40.0,width: 40.0,),
                    ),
                    Text(widget.title,style: Theme.of(context).textTheme.title),
                  ],
                ),
                Icon(Icons.settings),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    minWidth: 120.0,

                    alignedDropdown: true,
                    child: DropdownButton(
                      elevation: 1,
                      items: widget.units.map((Unit value) {
                        return DropdownMenuItem<String>(
                          value: value.name,
                          child: Text(value.name,
                            softWrap: true,
                            style: TextStyle(fontSize: 16.0,color: Colors.black),
                          ),
                        );
                      }).toList(), //items: dropdownMenuItems,
                      value: (_inputV==null) ? null : widget.units[_inputV].name,
                      style: Theme.of(context).textTheme.display1,
                      onChanged: (content) {
                        setState(() {
                          for(int ind=0;ind<widget.units.length;ind++)
                            if (widget.units[ind].name == content) {
                              _inputV = ind;
                            }
                          rows = new List<TableRow>();
                          createElements(_inputV, _conv);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: TextField(
                      onChanged: (text){
                        _conv = double.tryParse(text);
                        if(_conv!=Null) setState(() {
                          rows = new List<TableRow>();
                          createElements(_inputV, _conv);
                        });
                      },
                      keyboardType: TextInputType.number,
                      controller: myController,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).primaryColor,
                        labelText: 'Input',
                        labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
    Widget resultContainer = Table(
      border: TableBorder.all(),
      children: rows,
    );
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Column(
        children: <Widget>[
          entryContainer,
          resultContainer,
        ],
      ),
    );
  }
}

class cellResult extends StatelessWidget{
  final String outputUnit;
  final double outputResult;
  cellResult({this.outputResult,this.outputUnit});
  @override
  Widget build(BuildContext context) {
    return Table(

    );
  }
}