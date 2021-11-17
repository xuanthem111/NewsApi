import 'package:flutter/material.dart';
import 'package:webapi/config/value.dart';
import 'package:webapi/data/feathapi.dart';
import 'package:webapi/data/web_api_model.dart';
import 'package:webapi/screen/web.dart';

class WebApi extends StatelessWidget {
  const WebApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WebContent());
  }
}

class WebContent extends StatefulWidget {
  const WebContent({Key? key}) : super(key: key);

  @override
  _WebContentState createState() => _WebContentState();
}

class _WebContentState extends State<WebContent> {
  int count = 0;
  late Size size;
  int i = 0;
  var arr = [
    Service().getWebApi(Value().tesla),
    Service().getWebApi(Value().apple),
    Service().getWebApi(Value().domains)
  ];
  var image = [Value().imageTesla, Value().imageapple, Value().imagedomain];
  var str = ["Tesla", "Apple", "Domains"];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: buildBody()),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTest(),
          SizedBox(
            height: 10,
          ),
          buildContent(),
          SizedBox(
            height: 10,
          ),
          buildContentList()
        ],
      ),
    );
  }

  Widget buildTest() {
    return Container(
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "flutter",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "News",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.blue[300]),
          )
        ],
      ),
    );
  }

  Widget buildContent() {
    return Container(
      height: size.height * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: arr.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 7, left: 7),
                  width: size.width * 0.32,
                  height: size.height * 0.135,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(image[index])),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.redAccent,
                  ),
                ),
                Text(str[index],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19))
              ],
            ),
            onTap: () {
              setState(() {
                i = index;
              });
            },
          );
        },
      ),
    );
  }

  Widget buildContentList() {
    return Container(
      padding: EdgeInsets.all(10),
      height: size.height * 0.84,
      child: FutureBuilder(
          future: arr[i],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              WebApiModel t = snapshot.data;
              return buildList(t.articles);
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildList(List<Article> ls) {
    return ListView.builder(
      itemCount: ls.length,
      itemBuilder: (BuildContext context, int index) {
        Article p = ls[index];
        return GestureDetector(
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.network(p.urlToImage == null || p.urlToImage == ''
                          ? Value().imagenull
                          : p.urlToImage),
                      Text(
                        p.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        p.content,
                        maxLines: 2,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Web(content: p.content)));
          },
        );
      },
    );
  }
}
