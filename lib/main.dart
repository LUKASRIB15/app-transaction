import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/lista_transacoes.dart';
import 'package:flutter_complete_guide/widgets/nova_transacao.dart';
import './widgets/lista_transacoes.dart';
import './widgets/grafico.dart';
import 'models/transacoes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
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

  List<Transacao> get _recenteTransacao {
    return transacaoUsuario.where((tx) {
      return tx.data.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime selecionaData) {
    final newtx = Transacao(
      titulo: title,
      valor: amount,
      data: selecionaData,
      id: DateTime.now().toString(),
    );

    setState(
      () {
        transacaoUsuario.add(newtx);
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      transacaoUsuario.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  bool mostraGrafico = false;
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Colors.purple,
      title: Text("Aplicativo", style: TextStyle(fontFamily: 'Quicksand')),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Mostrar gráfico'),
                  Switch(
                      thumbColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.purple.withOpacity(.48);
                        } else {
                          return Colors.purple;
                        }
                      }),
                      value: mostraGrafico,
                      onChanged: (valor) {
                        setState(() => mostraGrafico = valor);
                      }),
                ],
              ),
            if (!isLandScape)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Grafico(_recenteTransacao)),
            if (!isLandScape)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  child: ListTransaction(transacaoUsuario, deleteTransaction)),
            if (isLandScape)
              mostraGrafico
                  ? Column(
                      children: [
                        Container(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.3,
                            child: Grafico(_recenteTransacao)),
                        Container(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.7,
                            child: ListTransaction(
                                transacaoUsuario, deleteTransaction))
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                            height: (MediaQuery.of(context).size.height -
                                    appBar.preferredSize.height -
                                    MediaQuery.of(context).padding.top) *
                                0.7,
                            child: ListTransaction(
                                transacaoUsuario, deleteTransaction))
                      ],
                    )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
    );
  }
}
