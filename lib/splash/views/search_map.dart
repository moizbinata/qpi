import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlacesApi extends StatefulWidget {
  @override
  _GoogleSearchPlacesApiState createState() => _GoogleSearchPlacesApiState();
}

class _GoogleSearchPlacesApiState extends State<GoogleSearchPlacesApi> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  GetStorage box = GetStorage();
  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "your api";
    String type = '(regions)';

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=AIzaSyDuVgdpLJJDl1H-irTSFsg9OsrNoJnpjRM';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      // toastMessage('success');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              color: Constants.primaryColor,
              size: SizeConfig.textMultiplier * 4,
            )),
        title: regularText(
            "Search Location", 2.1, Constants.primaryColor, FontWeight.bold, 1),
        actions: [
          Container(
            margin: EdgeInsets.all(SizeConfig.heightMultiplier * 1),
            child: ElevatedButton(
              onPressed: () {
                box.write('address2', _controller.text.toString());
                Navigator.pop(context);
              },
              child:
                  regularText("Done", 1.9, Colors.white, FontWeight.normal, 1),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search location",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    _controller.text =
                        _placeList[index]["description"].toString();
                  },
                  child: ListTile(
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
