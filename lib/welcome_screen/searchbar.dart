
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({Key? key}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {

  List<String> searchResults = [];
  bool isLoading = false;

 /* Future<void> fetchSearchResults(String query) async {
    setState(() {
      isLoading = true;
    });

   // final response = await http.get(Uri.parse("${AppUrl.baseurl}/search"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = List<String>.from(data['results']);

      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } else {
      setState(() {
        searchResults = [];
        isLoading = false;
      });
    }
  }*/


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical:20,horizontal: 10),
            child: TextFormField(
              onChanged: (value) {
                 //   onChanged:(value) => fetchSearchResults(value);
                // fetchSearchResults(value);
              },

              style: TextStyle(
                  color: Colors.green,
                  //   HexColor('#B1B1B1'),
                  fontFamily: 'Aboshi',
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
              textAlign: TextAlign.start,
              //  controller: search,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 16),
                filled: true,
                fillColor: Colors.green.withOpacity(0.15),
                prefixIcon: Icon(
                    Icons.search, color: HexColor('#B1B1B1')),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: HexColor("#CCCBCB")),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#CCCBCB")),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white10),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                hintStyle: TextStyle(color: HexColor('#B1B1B1'),
                ),
                hintText: "Search for fruits, vegetables...",),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(searchResults[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
