import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

// ignore: must_be_immutable
class places extends StatefulWidget {
  late placeType placee;

  int id;

  places({super.key, required this.placee, this.id = 0});

  @override
  State<places> createState() => _placesState();
}

class _placesState extends State<places> {
  late Future<List<api>> kpn;

  @override
  void initState() {
    kpn = widget.placee == placeType.source ? getData() : getDest(widget.id);

    super.initState();
  }

  TextEditingController txt = TextEditingController();
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
                    Navigator.pop(
                        context,
                        widget.placee.name.contains('source')
                            ? {'name': 'Enter Source'}
                            : 'Enter Destination');
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                    ),
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: TextField(
                      controller: txt,
                      onChanged: (value) {
                        setState(() {
                          txt.text = value;
                        });
                      },
                      style:
                          const TextStyle(fontSize: 18, fontFamily: 'poppinsm'),
                      decoration: InputDecoration(
                        hintText: 'Enter  ${widget.placee.name}',
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(13)),
                        hintStyle: const TextStyle(
                          fontFamily: 'poppinsm',
                          fontSize: 18,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(13),
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
                          Visibility(
                            visible: snapshot.data![index].name
                                    .toLowerCase()
                                    .startsWith(txt.text.toLowerCase()) ||
                                snapshot.data![index].name
                                    .toUpperCase()
                                    .startsWith(txt.text.toUpperCase()),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context,
                                    widget.placee.name.contains('source')
                                        ? {
                                            'id': snapshot.data![index].id,
                                            'name': snapshot.data![index].name
                                          }
                                        : snapshot.data![index].name);
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index].name),
                                  ),
                                  const Divider(
                                    height: 1,
                                    indent: 15,
                                  ),
                                ],
                              ),
                            ),
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

Future<List<api>> getDest(int id) async {
  print(id);
  var respoce = await http.get(
      Uri.parse(
          'http://testapi.kpntravels.in/v1/places/destinations?sourceId=$id'),
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
