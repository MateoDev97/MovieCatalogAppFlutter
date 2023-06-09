import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getCastByMovieId(movieId),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 100.0,
            width: 100.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 220,
          child: ListView.builder(
            itemCount: snapshot.data?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CastCard(
              castMember: snapshot.data![index],
            ),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({required this.castMember});

  final Cast castMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 110,
      height: 120,
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, 'actorView', arguments: castMember),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(castMember.safeProfileImageUrl),
              placeholder: const AssetImage('assets/no-image.jpg'),
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            castMember.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            castMember.character ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ]),
      ),
    );
  }
}
