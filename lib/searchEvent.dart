// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_tif_eventapp/event_model.dart';

class SearchEvent extends StatefulWidget {
  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  List<Data> events = [];

  final TextEditingController _toSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(_toSearch.text).then((jsonData) {
      final decodedData = json.decode(jsonData);
      setState(() {
        events = AutoGenerate.fromJson(decodedData).content.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //yahn app bar me back button - white => black
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        //ye bg color bhi blue se white kar liyo plz
        backgroundColor: Colors.blue,
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              updateEvents(_toSearch.text);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 6, top: 10),
                child: GestureDetector(
                  onTap: () {
                    updateEvents(_toSearch.text);
                  },
                  child: Icon(Icons.search),
                ),
              ),
              //yahn pr type box same nahi hai
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _toSearch,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey[300],
                      hintText: "Type Event Name",
                    ),
                  ),
                ),
              ),
            ],
          ),
          //yahn homePage ka card (in return) me changes kiye show ho rha hai ??? //comment plz
          Expanded(
            child: EventListView(events),
          ),
        ],
      ),
    );
  }

  Future<String> fetchData(String search) async {
    final url = Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event?search=$search');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void updateEvents(String search) {
    fetchData(search).then((jsonData) {
      final decodedData = json.decode(jsonData);
      setState(() {
        events = AutoGenerate.fromJson(decodedData).content.data;
      });
    });
  }
}

class EventListView extends StatelessWidget {
  final List<Data> events;

  EventListView(this.events);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final event = events[index];
              return EventCard(event);
            },
            childCount: events.length,
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final Data event;

  // ignore: prefer_const_constructors_in_immutables
  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 92,
              width: 79,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event.bannerImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  event.newDateTime,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  event.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
