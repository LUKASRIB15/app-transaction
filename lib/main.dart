import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/lista_transacoes.dart';
import 'package:flutter_complete_guide/widgets/nova_transacao.dart';
import './widgets/lista_transacoes.dart';
import './widgets/grafico.dart';
import 'models/transacoes.dart';


void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build (BuildContext context){
    return MaterialApp(
      title: "Aplicativo",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.yellow,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white,
            ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Quicksand',
               fontSize: 20,
               fontWeight: FontWeight.bold,
               )),
        ),
      ),
      home:MyHomePage(),
    );
}
}
class MyHomePage extends StatefulWidget{
    
    MyHomePageState createState()=> MyHomePageState();
}
class MyHomePageState extends State<MyHomePage>{
  final List<Transacao> transacaoUsuario = [
    /*Transacao(id: '1',
    titulo: 'Fone de ouvido',
    valor: 160.00,
    data: DateTime.now()
    ),
    Transacao(id: '2',
    titulo: 'Celular', 
    valor: 2900.90, 
    data: DateTime.now()
    ),*/
  ];

  List<Transacao> get _recenteTransacao{
    return transacaoUsuario.where((tx){
      return tx.data.isAfter(DateTime.now().subtract(Duration(days:7)));
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime selecionaData){
    final newtx = Transacao(
      titulo: title,
      valor: amount,
      data: selecionaData,
      id: DateTime.now().toString(),
      );

    setState((){
      transacaoUsuario.add(newtx);
    } ,);
  }

  void deleteTransaction(String id){
    setState((){
      transacaoUsuario.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: (){},
        child:NewTransaction(addNewTransaction),
        behavior: HitTestBehavior.opaque,
        );
    },);

  }
  Widget build (BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Aplicativo", style: TextStyle(fontFamily: 'Quicksand')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: ()=>startAddNewTransaction(context),
            ),
          ],
          ),
        body: SingleChildScrollView(
          child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
              Grafico(_recenteTransacao),
              ListTransaction(transacaoUsuario, deleteTransaction)
          ],),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed:()=>startAddNewTransaction(context),
          ),
        );
        
      
    
  }
}
