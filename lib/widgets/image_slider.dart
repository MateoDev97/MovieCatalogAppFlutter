import 'package:flutter/material.dart';

import '../models/models.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider(
      {super.key, required this.movies, required this.onNextPage});

  final List<Movie> movies;
  final Function onNextPage;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final nearEndPixels = scrollController.position.pixels + 500;
      if (nearEndPixels >= scrollController.position.maxScrollExtent) {
        widget.onNextPage();
      }
    });
  }

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
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (BuildContext context, int index) {
                return _ImagePoster(
                  movie: widget.movies[index],
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
    movie.heroId = 'slider-${movie.id}';
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detailView', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
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
