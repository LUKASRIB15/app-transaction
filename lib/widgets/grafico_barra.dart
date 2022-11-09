import 'package:flutter/material.dart';

class GraficoBar extends StatelessWidget {

final String label;
final double passarValor;
final double passarPorcentagemTotal;

GraficoBar(this.label, this.passarValor, this.passarPorcentagemTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
       return Column(
          children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child:FittedBox(
              child:Text('\$${passarValor.toStringAsFixed(0)}'),
          ),),

          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            width: 10,
            height: constraints.maxHeight * 0.6,
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
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child:Text(label))
            ),
        ],
      ); 
        });
  }
}