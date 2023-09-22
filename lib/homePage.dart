// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_tif_eventapp/event_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

class EventCard extends StatelessWidget {
  final Data event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      //yahn thik karna hain as cards pe navigation chahiye
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
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
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  event.bannerImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          //ye jo info section hain ye evenly distribute nahi ho rha hai CARD me
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 15,
                    color: Colors.grey,
                  ),
                  Text(" ${event.venueCity}, ${event.venueCountry}",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
