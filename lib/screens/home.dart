import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_loader_app/screens/pdfview_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String assetPDFPath = "";
  String urlPDFPath = "";

  @override
  void initState() {
    super.initState();

    getFileFormAsset("assets/html_tutorial.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });

    getFileFormUrl("http://www.pdf995.com/samples/pdf.pdf").then((f) {
      setState(() {
        urlPDFPath = f.path;
        print(urlPDFPath);
      });
    });
  }

  Future<File> getFileFormAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/html_tutorial.pdf");
      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening file");
    }
  }

  Future<File> getFileFormUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/html_tutorial.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening file");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: Container(
        child: Center(
          child: Builder(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text(
                    "Open from URL",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if(urlPDFPath != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return PdfViewScreen(path: urlPDFPath,);
                      }));
                    }
                  },
                ),
                SizedBox(height: 5.0),
                RaisedButton(
                  color: Colors.teal,
                  child: Text(
                    "Open from Asset",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if(assetPDFPath != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (_){
                        return PdfViewScreen(path: assetPDFPath,);
                      }));
                    }
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
