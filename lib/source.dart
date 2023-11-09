import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

// ignore: must_be_immutable
class Source extends StatefulWidget {
  late String feldname;

  Source({super.key, required this.feldname});

  @override
  State<Source> createState() => _SourceState();
}

class _SourceState extends State<Source> {
  late Future<List<api>> kpn;

  @override
  void initState() {
    kpn = getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 40,
              bottom: 20,
            ),
            color: const Color(0xff054CDC),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, {'name': 'Enter Source'});
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      style:
                          const TextStyle(fontSize: 20, fontFamily: 'poppinsm'),
                      decoration: InputDecoration(
                        hintText: widget.feldname,
                        hintStyle: const TextStyle(
                          fontFamily: 'poppinsm',
                          fontSize: 20,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: const Text(
              'All Cities',
              style: TextStyle(
                fontFamily: 'poppinsm',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: FutureBuilder(
              future: kpn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      top: 3,
                      left: 10,
                      right: 20,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pop(context, {
                                'id': snapshot.data![index].id,
                                'name': snapshot.data![index].name,
                              });
                            },
                            title: Text(snapshot.data![index].name),
                          ),
                          const Divider(
                            height: 1,
                            indent: 15,
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<api>> getData() async {
  var respoce = await http.get(
      Uri.parse('http://testapi.kpntravels.in/v1/places/sources'),
      headers: {
        'accept': 'application/json',
        'Authorization':
            'Basic cEc0SENIeUtUZ1U2d21VVjp5YXZ6REFDeWhYUGQ3d3IyTUxuNlZKQzkzV0wyWXpRag=='
      });

  var data = jsonDecode(respoce.body);

  List<Map> gtda = List<Map>.from(data['data']);

  List<api> fdta = gtda.map((e) => api.fromjson(e)).toList();

  return fdta;
}
