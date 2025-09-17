import 'package:attdart/view/busca_cep_page.dart';
import 'package:attdart/view/por_extenso_page.dart';
import 'package:attdart/view/tabela_fipe_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/invertexto.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.edit, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Por extenso",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PorExtensoPage()),
                );
              },
            ),
            SizedBox(height: 30),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.home, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Busca CEP",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuscaCepPage()),
                );
              },
            ),
            SizedBox(height: 30),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.car_rental, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Tabela Fipe",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabelaFipePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}