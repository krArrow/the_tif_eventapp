// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_tif_eventapp/event_card.dart';
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
    updateEvents(_toSearch.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
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
              // Call a function to update the events based on the search query here.
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
              Text(
                "|",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: _toSearch,
                    onChanged: (query) {
                      updateEvents(query);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none, // Remove the border
                      hintText: "Type Event Name",
                    ),
                  ),
                ),
              ),
            ],
          ),
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
