import 'package:flutter/material.dart';
import '../models/transacoes.dart';
import 'package:intl/intl.dart';

class ListTransaction extends StatelessWidget {
  final List<Transacao> transacao;
  final Function funcaoDeletar;

  ListTransaction(this.transacao, this.funcaoDeletar);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //Calculando tamanhos dinamicamente
      height: MediaQuery.of(context).size.height * 0.6,
      child: transacao.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Nenhuma transação adicionada!",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Image.asset('assets/images/esperando.jpg',
                      fit: BoxFit.cover),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (contexto, indice) {
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                                child: Text(
                                    '\$${transacao[indice].valor.toStringAsFixed(2)}')))),
                    title: Text(
                      transacao[indice].titulo,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transacao[indice].data),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? TextButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            //textColor: Theme.of(context).errorColor,
                            onPressed: () {
                              funcaoDeletar(transacao[indice].id);
                            })
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              funcaoDeletar(transacao[indice].id);
                            },
                          ),
                  ),
                );
              },
              itemCount: transacao.length,
            ),
    );
  }
}
