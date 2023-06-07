import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      child: ListView.builder(
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, int index) => _CastCard(),
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 110,
      height: 100,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            image: NetworkImage('https://via.placeholder.com/200x300'),
            placeholder: AssetImage('assets/no-image.jpg'),
            height: 140,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'actor.name dsdadasd asdsads dadsd',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
