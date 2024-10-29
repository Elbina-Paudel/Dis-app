// news_slider.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewsSlider extends StatelessWidget {
  final List<Map<String, String>> newsArticles = [
    {
      "title": "Nepal: Hundreds killed as unprecedented flash floods strike capital Kathmandu",
      "description": "More than 215 people, including 35 children, have been killed and dozens are missing after heavy rains triggered flash floods and landslides across Nepal.",
      "image": "assets/flood.jpg"
    },
    {
      "title": "Forest fire destroys 4,500 hectares of forest area in Ramechhap",
      "description": "Forest fires broke out in 155 places of eight municipalities and rural municipalities in the district have destroyed almost 4,500 hectares of forest area in the past one month.",
      "image": "assets/forestfire.png"
    },
    {
      "title": "Thousands sleep outside in Nepal after quake kills 157, destroys houses",
      "description": "Most of the houses in villages in Jajarkot district either collapsed or were severely damaged by the sudden earthquake Friday night, while the few concrete houses in towns were also damaged.",
      "image": "assets/earthquake.png"
    },
  ];

  // Removed the `const` keyword from the constructor
  NewsSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval: const Duration(seconds: 4),
        ),
        items: newsArticles.map((news) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          news['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        news['description']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
