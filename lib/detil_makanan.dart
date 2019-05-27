import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_submission_03/makanan_detil.dart';

class DetilMakanan extends StatefulWidget {
  DetilMakanan({Key key, this.id}): super(key: key);
  String id;

  @override
  _DetilMakananState createState() => _DetilMakananState(id);
}

class _DetilMakananState extends State<DetilMakanan> {
  String id;
  _DetilMakananState(this.id);

  String gambar, nama, kategori, instruksi;

  List<Makanan_Detil> makanans = [];

  loadDataDetail() async {
    String dataURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="+ id;

    http.Response response = await http.get(dataURL);
    var responseJson = JSON.jsonDecode(response.body);

    print (dataURL);
    print (responseJson);

    if (response.statusCode == 200) {
      setState(() {
        makanans = (responseJson['meals'] as List)
            .map((p) => Makanan_Detil.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Gagal terhubung');
    }
  }

  getBody() {
    print ("ukuran" + makanans.length.toString());

    if (makanans.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {

      gambar = makanans[0].strMealThumb;
      nama = makanans[0].strMeal;
      kategori = makanans[0].strCategory;
      instruksi = makanans[0].strInstructions;

      return ListView(
        shrinkWrap: true,
          children: <Widget>[
            Center(
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: nama,
                      child: Material(
                        child: InkWell(
                          child: Image.network(gambar, width: 1000, height: 300, fit: BoxFit.cover,),
                        ),
                      ),
                    ),

                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(nama, style: Theme.of(context).textTheme.headline),

                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                              child: Text("Kategori " + kategori),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                              child: Text(instruksi),
                            ),
                          ],
                        )
                    ),
                  ],
                )
            )
          ],
      );
    }
  }

  @override
  void initState() {
    loadDataDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Detil Makanan"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false)
        ),
      ),
      body: getBody(),
      );
  }
}