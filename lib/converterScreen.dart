import 'package:flutter/material.dart';
import 'unit.dart';

class ConverterScreen extends StatefulWidget {
  ConverterScreen({this.units, this.title});
  List<Unit> units;
  String title;
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String _outputValue;
  String _fromValue;int _inputV;
  int _outputV;
  TextEditingController myController = new TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  void initState(){
    _inputV = 0;
    _outputV = 1;
  }

  void _convert() {
    setState(() {
      _fromValue = myController.text;
      _outputValue = '30M';
    });
  }

  void _exchange(){
    setState(() {
      int inter = _inputV;
      _inputV=_outputV;
      _outputV=inter;
      String str = _outputValue;
      _outputValue = myController.text;
      myController.text = str;
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget inputContainer = Container(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: TextField(
                onChanged: (text){
                  double converted = double.tryParse(text);
                  print('Value is $text\nThe value in integer is: $converted ');
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
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.grey[500],
                ),
              ),
              child: DropdownButtonHideUnderline(
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
                            break;
                          }
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    Widget buttonsContainer = Container(
      //color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: Container(
                height: 50.0,
                width: 120.0,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'Convert',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: (){
                if(_outputV == null || _inputV==null) print('select unit');
                else{
                  double val = double.parse(myController.text);
                  val = val * (widget.units[_inputV].wieght / widget.units[_outputV].wieght);
                  setState(() {
                    _outputValue = '$val';
                  });
                }
                //Scaffold.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Select units')));
              },
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: IconButton(
                color: Colors.white,
                iconSize: 35.0,
                icon: Icon(
                  Icons.compare_arrows,
                ),
                onPressed: _exchange,
              ),
            ),
          ),

        ],
      ),
    );
    Widget outputContainer = Container(
      child: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey[500],
                    )
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    minWidth: 120.0,
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      items: widget.units.map((Unit value) {
                        return DropdownMenuItem<String>(
                          value: value.name,
                          child: Text(value.name,
                            softWrap: true,
                            style: TextStyle(fontSize: 16.0,color: Colors.black),),
                        );
                      }).toList(), //items: dropdownMenuItems,
                      value: (_outputV==null) ? null : widget.units[_outputV].name,
                      style: Theme.of(context).textTheme.display1,
                      onChanged: (content) {
                        setState(() {
                          for(int ind=0;ind<widget.units.length;ind++)
                            if (widget.units[ind].name == content) {
                              _outputV = ind;
                              break;
                            }
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 300.0,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  (_outputValue==null) ? '' : '$_outputValue',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,),

              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 80.0, bottom: 40.0),
            child: Listener(
              child: Column(
                children: <Widget>[
                  inputContainer,
                  buttonsContainer,
                  outputContainer,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
