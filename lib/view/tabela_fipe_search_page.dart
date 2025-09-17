import 'package:flutter/material.dart';
import 'package:attdart/service/invertexto_service.dart';

class TabelaFipeSearchPage extends StatefulWidget {
  final int vehicleType;
  final String title;

  const TabelaFipeSearchPage(
      {super.key, required this.vehicleType, required this.title});

  @override
  State<TabelaFipeSearchPage> createState() => _TabelaFipeSearchPageState();
}

class _TabelaFipeSearchPageState extends State<TabelaFipeSearchPage> {
  final apiService = InvertextoService();
  List<dynamic> _brands = [];
  List<dynamic> _models = [];
  List<dynamic> _years = [];
  Map<String, dynamic>? _price;

  String? _selectedBrandId;
  String? _selectedModelCode;
  String? _selectedYearId;

  String? _selectedBrandName;
  String? _selectedModelName;
  String? _selectedYearName;

  @override
  void initState() {
    super.initState();
    _fetchBrands();
  }

  Future<void> _fetchBrands() async {
    try {
      final brands = await apiService.getFipeBrands(widget.vehicleType);
      setState(() {
        _brands = brands;
        _models = [];
        _years = [];
        _price = null;
        _selectedBrandId = null;
        _selectedModelCode = null;
        _selectedYearId = null;
      });
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _fetchModels(int brandId) async {
    try {
      final models = await apiService.getFipeModels(brandId);
      setState(() {
        _models = models;
        _years = [];
        _price = null;
        _selectedModelCode = null;
        _selectedYearId = null;
      });
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _fetchYears(String fipeCode) async {
    try {
      final years = await apiService.getFipeYears(fipeCode);
      setState(() {
        _years = years;
        _price = null;
        _selectedYearId = null;
      });
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _fetchPrice(String fipeCode, String yearId) async {
    try {
      final price = await apiService.getFipePrice(fipeCode, yearId);
      setState(() {
        _price = price;
      });
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erro"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Tabela Fipe - ${widget.title}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              "Selecione a Marca",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            DropdownButton<String>(
              value: _selectedBrandId,
              dropdownColor: Colors.grey[850],
              style: TextStyle(color: Colors.white),
              items: _brands.map<DropdownMenuItem<String>>((brand) {
                return DropdownMenuItem<String>(
                  value: brand['id'].toString(),
                  child: Text(brand['brand']),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBrandId = newValue;
                  _selectedBrandName = _brands.firstWhere((brand) => brand['id'].toString() == newValue)['brand'];
                  _fetchModels(int.parse(newValue!));
                });
              },
            ),
            if (_selectedBrandId != null) ...[
              SizedBox(height: 20),
              Text(
                "Selecione o Modelo",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              DropdownButton<String>(
                value: _selectedModelCode,
                dropdownColor: Colors.grey[850],
                style: TextStyle(color: Colors.white),
                items: _models.map<DropdownMenuItem<String>>((model) {
                  return DropdownMenuItem<String>(
                    value: model['fipe_code'],
                    child: Text(model['model']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedModelCode = newValue;
                    _selectedModelName = _models.firstWhere((model) => model['fipe_code'] == newValue)['model'];
                    _fetchYears(newValue!);
                  });
                },
              ),
            ],
            if (_selectedModelCode != null) ...[
              SizedBox(height: 20),
              Text(
                "Selecione o Ano",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              DropdownButton<String>(
                value: _selectedYearId,
                dropdownColor: Colors.grey[850],
                style: TextStyle(color: Colors.white),
                items: _years.map<DropdownMenuItem<String>>((year) {
                  return DropdownMenuItem<String>(
                    value: year['id'],
                    child: Text(year['year']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedYearId = newValue;
                    _selectedYearName = _years.firstWhere((year) => year['id'] == newValue)['year'];
                    _fetchPrice(_selectedModelCode!, newValue!);
                  });
                },
              ),
            ],
            if (_price != null) ...[
              SizedBox(height: 20),
              Text(
                "Preço na Tabela Fipe",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "${_price!['price']}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ],
        ),
      ),
    );
  }
}