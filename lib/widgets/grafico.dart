import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transacoes.dart';
import './grafico_barra.dart';

class Grafico extends StatelessWidget {
  final List<Transacao> transacaoRecente;

  Grafico(this.transacaoRecente);

  List<Map<String, Object>> get grupoValoresTransacao{
    return List.generate(7, (index) {
      final diaSemana = DateTime.now().subtract(Duration(days: index));
      var totalSoma = 0.0;

      for(int i=0; i<transacaoRecente.length; i++){
        if(transacaoRecente[i].data.day == diaSemana.day &&
            transacaoRecente[i].data.month == diaSemana.month &&
            transacaoRecente[i].data.year == diaSemana.year){
              totalSoma = totalSoma + transacaoRecente[i].valor;
        }
      }

      print(DateFormat.E().format(diaSemana));
      print(totalSoma);
      
      return {'day': DateFormat.E().format(diaSemana).substring(0,1), 'amount': totalSoma};
    }).reversed.toList();
  }

  double get totalPassando{
    return grupoValoresTransacao.fold(0.0, (sum, item){
      return sum + (item['amount'] as double);
    });
  }
  @override
  Widget build(BuildContext context) {
    print(grupoValoresTransacao);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grupoValoresTransacao.map((data){
            return Flexible(
            fit: FlexFit.tight,
            child:GraficoBar(
              data['day'] as String,
              data['amount'] as double, 
              totalPassando == 0 ? 0.0 : (data['amount'] as double)/totalPassando
            ),);
        }).toList(),),),
    );
  }
}