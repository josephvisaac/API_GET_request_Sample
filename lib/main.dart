import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'models/movie.dart';

/*INSTRUCTIONS
1.Install the http package into yaml.
2.import the file to the file you will use.
3.Make get request that includes url and authorization, authorization
looks differently depending on the type of authorization,
for Bearer, this is type Bearer in the example
4.Decode the .body of response
 */
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'API get() Request'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listSize = ['', ''];
  Map<dynamic, dynamic> apiData = {'docs': []};
  Map<String, String> headers = {
    'Authorization': 'Bearer 6DMnrpLiKW4BJK1_7X18'
  };
  String url = 'https://the-one-api.herokuapp.com/v1',
      movies = '/movie',
      character = '/character',
      quotes = '/quote';

  void getToken() async {
    get('$url$movies');
    var response =
        await get('$url$character', headers: headers); /*Same as .then()*/

    setState(() {
      apiData = json.decode(response.body);
    });
    // print('-----------------------');
    // apiData['docs'].forEach((item) {
    //   print(item['name']);
    // });
    // print('-----------------------');
    // print(apiData);
    // print(apiData['docs']['name']);
    print(apiData['docs'].length);
  }

  @override
  Widget build(BuildContext context) {
    // print(apiData['docs'].length);
    // print(apiData['docs']);
    // debugPrint('$url$movies');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'test API With Authentification Token',
              ),
              RaisedButton(onPressed: getToken, child: Text('get request')),
              Container(
                height: 475,
                // color: Colors.green,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'name:  ${apiData['docs'][index]['name']}, index $index'),
                    );
                  },
                  itemCount: apiData['docs'].length,
                ),
                // itemCount:  listSize.length,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
