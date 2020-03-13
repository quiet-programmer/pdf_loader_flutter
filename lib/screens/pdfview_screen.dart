import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewScreen extends StatefulWidget {
  final String path;

  const PdfViewScreen({Key key, this.path}) : super(key: key);
  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  int _totalPage = 0;
  int _currentPage = 0;
  bool _pdfReady = false;
  PDFViewController _pdfViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Document"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            swipeHorizontal: true,
            enableSwipe: true,
            pageSnap: true,
            onError: (e){
              print(e);
            },
            onRender: (_pages){
              setState(() {
                _totalPage = _pages;
                _pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController view){
              _pdfViewController = view;
            },
            onPageChanged: (int page, int total){
              setState(() {
                
              });
            },
            onPageError: (page, e){
              print("error on page");
            },
          ),
          !_pdfReady ? Center(
            child: CircularProgressIndicator(),
          ) : Offstage(),
        ],
      ),
    );
  }
}