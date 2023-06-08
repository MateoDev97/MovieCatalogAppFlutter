import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          size: 150,
        ),
      );
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.sugestionStream,
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Icon(
              Icons.movie_creation_outlined,
              size: 150,
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 220,
          child: ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (_, int index) => _RowSearch(
              movie: snapshot.data![index],
            ),
          ),
        );
      },
    );
  }
}

class _RowSearch extends StatelessWidget {
  const _RowSearch({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.safePosterImageUrl),
          placeholder: const AssetImage('assets/no-image.jpg'),
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'detailView', arguments: movie);
      },
    );
  }
}
