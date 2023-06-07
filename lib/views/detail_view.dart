import 'package:flutter/material.dart';
import 'package:movies_app/theme/app_theme.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(),
                _Overview(),
                _Overview(),
                CastingCards(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primaryColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 15),
          color: Colors.black12,
          child: const Text(
            'movie.title',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: const FadeInImage(
          image: NetworkImage('https://via.placeholder.com/500x300'),
          placeholder: AssetImage('assets/no-image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              image: NetworkImage('https://via.placeholder.com/200x300'),
              placeholder: AssetImage('assets/no-image.jpg'),
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'movie.originalTitle',
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const Row(
                children: [
                  Icon(Icons.star_outline),
                  Text('movie.voteAverage'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Text(
        'Sunt minim do id consequat consequat culpa anim minim veniam. Anim minim consequat et voluptate sunt commodo mollit mollit est deserunt cupidatat. Occaecat cupidatat fugiat consectetur proident eu fugiat. Est aliqua consectetur enim sunt nulla ex mollit id. Aliqua adipisicing ut incididunt dolor ad elit cupidatat. Proident eu eu esse et exercitation id. Exercitation enim qui sunt dolor fugiat. In do laboris laborum proident voluptate. Fugiat consectetur irure nulla cillum mollit cillum ipsum. Cillum cillum aliquip pariatur consectetur aute et mollit commodo. Est et irure laborum nisi in ipsum. Pariatur occaecat veniam aliqua sit deserunt in occaecat sint sint sit.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
