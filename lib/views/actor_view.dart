import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ActorView extends StatelessWidget {
  const ActorView({super.key});

  @override
  Widget build(BuildContext context) {
    final Cast castMember = ModalRoute.of(context)?.settings.arguments as Cast;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actor Name'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ActorInfo(castMember: castMember),
            const SizedBox(height: 20),
            _MoviesByActor(castMember: castMember)
          ],
        ),
      ),
    );
  }
}

class _ActorInfo extends StatelessWidget {
  const _ActorInfo({required this.castMember});

  final Cast castMember;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: moviesProvider.getActorInfo(castMember.id),
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
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Hero(
                tag: castMember.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    image: NetworkImage(castMember.safeProfileImageUrl),
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 190),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      castMember.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      snapshot.data?.placeOfBirth ?? '',
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      DateFormat('MMMM d, yyyy')
                          .format(snapshot.data!.birthday),
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      "Age: ${DateTime.now().year - snapshot.data!.birthday.year}",
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _MoviesByActor extends StatelessWidget {
  const _MoviesByActor({required this.castMember});
  final Cast castMember;
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      child: FutureBuilder(
        future: moviesProvider.getMoviestByPersonId(castMember.id),
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

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (_, int index) => _RowActorMovie(
              movie: snapshot.data![index],
            ),
          );
        },
      ),
    );
  }
}

class _RowActorMovie extends StatelessWidget {
  const _RowActorMovie({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'actor-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage(movie.safePosterImageUrl),
          placeholder: const AssetImage('assets/no-image.jpg'),
          width: 100,
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
