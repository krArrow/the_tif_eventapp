import 'package:flutter/material.dart';
import 'package:the_tif_eventapp/event_model.dart';

class EventCard extends StatelessWidget {
  final Data event;

  EventCard(this.event);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //do something
      },
      child: Card(
        elevation: 2.0,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 90,
                width: 70,
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
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2, // Adjust maxLines as needed
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on, size: 15),
                        const SizedBox(
                          width: 7,
                        ),
                        Flexible(
                          child: Text(
                            "${event.venueName} • ${event.venueCity}, ${event.venueCountry}",
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2, // Adjust maxLines as needed
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
