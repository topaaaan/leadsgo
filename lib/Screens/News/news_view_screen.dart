import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailNews extends StatefulWidget {
  String title;
  String path;
  String content;
  String createdAt;

  DetailNews(this.title, this.path, this.content, this.createdAt);
  @override
  _DetailNews createState() => _DetailNews();
}

class _DetailNews extends State<DetailNews> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black54, //change your color here
          ),
          elevation: 0,
          title: Text(
            '',
            style: TextStyle(
              fontFamily: 'LeadsGo-Font',
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Column(
                children: [
                  Image(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://tetranabasainovasi.com/marsit/' + widget.path,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      widget.content,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
