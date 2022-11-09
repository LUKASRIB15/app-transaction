import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class NewTransaction extends StatefulWidget {
  final Function addTransacao;

  NewTransaction(this.addTransacao);

  NewTransactionState createState()=> NewTransactionState();
}
class NewTransactionState extends State <NewTransaction>{

  final controllerTitulo=TextEditingController();
  final controllerValor=TextEditingController();
  DateTime? _selecionaData;
  

  
  void dataPresent(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
      ).then((datePicker){
        if(datePicker == null){
          return;
        }
        setState((){
          _selecionaData = datePicker;
        });
      });
  }
  void submitDados(){
    if(controllerValor.text.isEmpty){
      return;
    }
    final inserirTitulo = controllerTitulo.text;
    final inserirValor = double.parse(controllerValor.text);
    
    if (inserirTitulo.isEmpty || inserirValor<=0 || _selecionaData == null){
      return;
    }
    
    widget.addTransacao(
      inserirTitulo,
      inserirValor,
      _selecionaData,
    );

    Navigator.of(context).pop();
      
  }
  @override
  Widget build(BuildContext context) {
    return Card(
                elevation:5,
                child:Container(
                  padding: EdgeInsets.all(10),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:<Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Título'),
                        style: Theme.of(context).textTheme.headline6,
                        controller: controllerTitulo,
                        onSubmitted: (_)=>submitDados,
                      ),  
                      TextField(
                        decoration: InputDecoration(labelText: 'Valor'),
                        style: Theme.of(context).textTheme.headline6,
                        controller: controllerValor,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_)=>submitDados,
                        ),
                      Container(
                        height: 70,
                        child:Row(
                          children: <Widget>[
                            Expanded(
                            child:Text(
                            _selecionaData == null ? 
                          
                              "Nenhuma data escolhida"
                              
                            
                            :
                            
                              DateFormat('dd/MM/yyyy').format(_selecionaData!),                              
                              ),),
                            
                            TextButton(
                              child: Text("Escolha uma data"),
                              onPressed: dataPresent,
                            ),
                          ]
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.purple),
                        child: Text("Adicionar transação"),
                        onPressed: submitDados,                        
                      ),
              ]),),);
  }
}