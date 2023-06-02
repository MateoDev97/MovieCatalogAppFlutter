import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            ImageSlider(),
          ],
        ),
      ),
    );
  }
}
