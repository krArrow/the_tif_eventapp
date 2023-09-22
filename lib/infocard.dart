// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:the_tif_eventapp/event_card.dart';
import 'package:the_tif_eventapp/homePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_tif_eventapp/event_model.dart';

//info card => event infomations when navigated by the card

class InfoCard extends StatefulWidget {
  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  List<Data> events = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((jsonData) {
      final decodedData = json.decode(jsonData);
      setState(() {
        events = AutoGenerate.fromJson(decodedData).content.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Events",
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              Navigator.pushNamed(context, '/search');
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
      body: EventListView(events),
    );
  }

  Future<String> fetchData() async {
    final url = Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
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
//event ka info card banana hai

class Event_InfoCards extends StatelessWidget {
  late Data? event;

  Event_InfoCards({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("hell0"),
    );
  }
}
