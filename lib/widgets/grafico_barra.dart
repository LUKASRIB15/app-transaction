import 'package:flutter/material.dart';

class GraficoBar extends StatelessWidget {

final String label;
final double passarValor;
final double passarPorcentagemTotal;

GraficoBar(this.label, this.passarValor, this.passarPorcentagemTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          child:Text('\$${passarValor.toStringAsFixed(0)}'),
        ),

        SizedBox(height: 4,),
        Container(
          width: 10,
          height: 60,
          child:Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width:1.0),
                color:Color.fromRGBO(220,220,220,1),
                borderRadius: BorderRadius.circular(10),
                ),
            ),
            FractionallySizedBox(
              heightFactor: passarPorcentagemTotal,
              child: Container(decoration: BoxDecoration(
                color:Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)),
                )
              ),
          ]),
        ),
        SizedBox(height: 4,),
        Text(label),
      ],
    );
  }
}