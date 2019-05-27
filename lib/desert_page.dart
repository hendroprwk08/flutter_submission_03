import 'package:flutter/material.dart';
import 'makanan.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'detil_makanan.dart';

class DesertPage extends StatefulWidget {
  @override
  _DesertPageState createState() => _DesertPageState();
}

class _DesertPageState extends State<DesertPage> {

  List<Makanan> makanans = [];


  loadData() async {
    String dataURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Desert";

    http.Response response = await http.get(dataURL);
    var responseJson = JSON.jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        makanans = (responseJson['meals'] as List)
            .map((p) => Makanan.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Gagal terhubung');
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  getBody() {
    if (makanans.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return getGridView();
    }
  }

  GridView getGridView() => GridView.count(
      crossAxisCount: 2,
      children: List.generate(makanans.length, (index){
        return getRow(index);
      },
      )
  );

  Widget getRow(int i) {
    return new GestureDetector(
        child: Column(
          children: <Widget>[
            Hero(
              tag: makanans[i].strMeal,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context)  =>
                                DetilMakanan(id: makanans[i].idMeal,)
                        )
                    );
                  },
                  child: Image.network(
                    makanans[i].strMealThumb,
                    width: 160.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(makanans[i].strMeal,),
            ),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody()
    );
  }
}