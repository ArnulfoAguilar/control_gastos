import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'graph_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Control de Gastos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController _controller;
  int paginaActual=1;
  void initState(){
    super.initState();
        _controller= PageController(
          initialPage: 1,
            viewportFraction: 0.4,
        );
  }
    Widget _buttonAction(IconData icon){
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ),
        onTap: (){},
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4.0,
          shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buttonAction(FontAwesomeIcons.history),
            _buttonAction(FontAwesomeIcons.chartPie),
            SizedBox(width: 48.0),
            _buttonAction(FontAwesomeIcons.wallet),
            _buttonAction(Icons.settings),
          ],
        ),
      ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: null) ,
      body: _body()
    );
  }
    Widget _body(){
      return SafeArea(
        child: Column(
          children: <Widget>[
            _selector(),
            _gastos(),
            _grafico(),
            _lista()
          ],
        ),
      );
    }
Widget _pageItem(String name, int position){
    var _alignment;
    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey
    );
    final unselected = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: Colors.blueGrey.withOpacity(0.4)
    );
    if(position == paginaActual){
      _alignment = Alignment.center;

    }else if(position > paginaActual){
      _alignment = Alignment.centerRight;
    }
    else{
      _alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: _alignment,
      child: Text(name,
      style: position == paginaActual ? selected:unselected,
      )
    );
}
    Widget _selector(){
      return  SizedBox.fromSize(
        size: Size.fromHeight(70.0),
       child: PageView(
         onPageChanged: (newPage){
           setState(() {
             paginaActual = newPage;
           });
         },
         controller: _controller,
       children: <Widget>[
         _pageItem("Enero",0),
         _pageItem("Febrero",1),
         _pageItem("Marzo",2),
       ],
      )
      );
    }
    Widget _gastos(){
      return Column(
        children: <Widget>[
          Text('\$2341.58',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35.0,
          ),
          ),
          Text("Total Gastado",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.blueGrey
            ),
          )
        ],
      );
    }
    Widget _grafico(){
      return Container(
        child: GraphWidget(),
        height: 230.0,
      );

    }
    Widget _items(IconData icon,String nombre, int porcentaje, double value){
      return ListTile(
        leading: Icon(icon),
        title: Text(nombre,
        style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0
        ),
        ),
        subtitle: Text("$porcentaje% Porcentaje de gasto: "),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(0.5)
          ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("\$$value",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold
              ),
              ),
            )
        ),
      );
    }
Widget _divider(){
      return Divider(
        color: Colors.lightBlueAccent,
        height: 1.0,
        indent: 5.0,
        endIndent: 5.0,
      );
}
    Widget _lista(){
      return Expanded(
        child: ListView(
          children: <Widget>[
            _items(FontAwesomeIcons.shoppingCart,'Compras',14, 145.12),
            _divider(),
            _items(FontAwesomeIcons.cocktail,'Diversion',20, 200.54),
            _divider(),
            _items(FontAwesomeIcons.hamburger,'Comida Rapida',20, 224.10),
            _divider(),
            _items(FontAwesomeIcons.piggyBank,'Ahorro',10, 346.00),
            _divider(),
            _items(FontAwesomeIcons.university,'Deudas',36, 75.50),
          ],
        ),
      );
    }
}
