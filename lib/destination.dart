import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api.dart';

// ignore: must_be_immutable
class Destination extends StatefulWidget {
  dynamic number;
  late String feldname;
  Destination({super.key, required this.feldname, required this.number});

  @override
  State<Destination> createState() => _DestinationState();
}

class _DestinationState extends State<Destination> {
  late Future<List<api>> kpnn;

  @override
  void initState() {
    kpnn = getDest(widget.number);

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
                    Navigator.pop(context);
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
              future: kpnn,
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
                              Navigator.pop(
                                  context, snapshot.data![index].name);
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

Future<List<api>> getDest(int id) async {
  print(id);
  var respoce = await http.get(
      Uri.parse('http://testapi.kpntravels.in/v1/places/destinations/$id'),
      headers: {
        'accept': 'application/json',
        'Authorization':
            'Basic cEc0SENIeUtUZ1U2d21VVjp5YXZ6REFDeWhYUGQ3d3IyTUxuNlZKQzkzV0wyWXpRag=='
      });

  Map dta = jsonDecode(respoce.body);

  List<Map> gtda = List<Map>.from(dta['data']);

  List<api> fdta = gtda.map((e) => api.fromjson(e)).toList();

  return fdta;
}
