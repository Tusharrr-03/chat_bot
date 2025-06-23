import 'dart:math';

import 'package:flutter/material.dart';

class AppConstants{
  List<Map<String, dynamic>> defaultQues = [
    {
      'title' : 'Most Popular',
      'ques' : [
        {
          'icon' : Icons.ac_unit,
          'color' : Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
          'ques' : 'What is AI',
        },

        {
          'icon' : Icons.face,
          'color' : Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
          'ques' : 'Tell me a Joke',
        },

        {
          'icon' : Icons.medical_information_outlined,
          'color' : Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
          'ques' : 'Explain the concept machine learning.',
        },

        {
          'icon' : Icons.cloud,
          'color' : Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
          'ques' : 'How does climate change work.',
        },
      ],
    },

    {
      'title' : 'Trending',
      'ques' : [
        {
          'icon' : Icons.favorite_outlined,
          'color' : Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
          'ques' : 'What is the meaning of life',
        },

        {
          'icon' : Icons.calculate,
          'color' : Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
          'ques' : 'Can you help with a main problem',
        },
      ],
    },

    {
      'title' : 'Instagram',
      'ques' : [
        {
          'icon' : Icons.social_distance_rounded,
          'color' : Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
          'ques' : 'How to get more insights.',
        },
      ],
    }
  ];
}