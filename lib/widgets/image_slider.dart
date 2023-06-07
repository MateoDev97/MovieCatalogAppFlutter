import 'package:flutter/material.dart';

import '../models/models.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Populars',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return _ImagePoster(
                  movie: movies[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePoster extends StatelessWidget {
  const _ImagePoster({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detailView',
                arguments: 'movie-arguments'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(movie.safePosterImageUrl),
                placeholder: const AssetImage('assets/no-image.jpg'),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
