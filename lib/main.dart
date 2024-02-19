// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'movie.dart';

void main() {
  runApp(
    MaterialApp(home: MovieListView()));
}

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();
  final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf Of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings"

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 44, 48, 49),
      ),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) { 
          return Stack(
            children:<Widget>[
              
                movieCard(movieList[index], context),
                Positioned(
                  top:10.0, 
                  child: movieImage(movieList[index].images[2]))
            
                ]);
      },)
    );
  }
  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60.0), //changes the card ui from the left so we can see the image better
        width: MediaQuery.of(context).size.width,
        height:120.0,
        child: Card(
          color: Color.fromARGB(115, 86, 85, 85),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,
            bottom: 8.0,
            left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,   //makes space between 
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 15.0, color: Colors.white)),
                      Text("Rating: ${movie.imdbRating} / 10",
                      style: TextStyle(
                        fontSize: 13.0,
                        color:Colors.grey
                      ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Released: ${movie.released}", style: TextStyle(
                        fontSize: 11.0,
                        color:Colors.grey
                      )),
                    Text(movie.runtime, style: TextStyle(
                        fontSize: 11.0,
                        color:Colors.grey
                      )),
                    Text(movie.rated, style: TextStyle(
                        fontSize: 11.0,
                        color:Colors.grey
                      ))],
                  )
                ],
              ),
            ),
          )
        ),
      ),
      onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => MovieListViewDetails(movieName: movie.title,
                movie: movie,))
                ),
    );
  }
  TextStyle mainTextStyle() {
    return TextStyle(
      fontSize: 13.0,
      color: Colors.grey,
    );
  }
  Widget movieImage(String imageUrl) { 
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(imageUrl),
        fit: BoxFit.cover)
      ),
    );
  }
}

// New Route (screen or page)
class MovieListViewDetails extends StatelessWidget {

final String movieName;
  final Movie movie;
  const MovieListViewDetails({super.key, required this.movieName, required this.movie}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade600,
      ),
      body: ListView(
        children: <Widget>[
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsExtraPosters(posters: movie.images)
        ],
      )
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
   const MovieDetailsThumbnail({super.key, required this.thumbnail});
final String thumbnail;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(thumbnail),
                fit: BoxFit.cover)
              ),
            ),
            Icon(Icons.play_circle_outline, size: 100,
            color: Colors.white)
          ],
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
          ),
          height: 80,
        )
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  const MovieDetailsHeaderWithPoster({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          MoviePoster(poster: movie.images[1].toString()),
          SizedBox(width: 16),
          Expanded(child: MovieDetailsHeader(movie: movie))
        ],
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({super.key, required this.movie});
final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text("${movie.year} . ${movie.genre}".toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.cyan
      ),),
      Text(movie.title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),),
      Text.rich(TextSpan(style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      children: <TextSpan>[
        TextSpan(
          text:movie.plot
        ),
        TextSpan(
          text:" Read more...",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w400
          )
        )
      ]
      ),
      ),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  MoviePoster({super.key, required this.poster});
final String poster;
  @override
  Widget build(BuildContext context) {
     const br = BorderRadius.all((Radius.circular(10)));
    return Card(
      child: ClipRRect(
        borderRadius: br,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(poster),
            fit: BoxFit.cover)
          ),
        ),
      ),
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  const MovieDetailsCast({super.key, required this.movie});
final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director),
          MovieField(field: "Awards", value: movie.awards),
          MovieField(field: "Writer", value: movie.writer),
          MovieField(field: "Language", value: movie.language),
          MovieField(field: "Country", value: movie.country),
          MovieField(field: "imdbRating", value: movie.imdbRating),
          MovieField(field: "imdbVotes", value: movie.imdbVotes),
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  const MovieField({super.key, required this.field, required this.value});
final String field;
final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text("$field : ", style: TextStyle(
            color: Colors.black,
            fontSize: 12, fontWeight: FontWeight.w600,
          ),),
          Expanded( child:
            Text(value,  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300)),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {
  const MovieDetailsExtraPosters({super.key, required this.posters});
final List<String> posters;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0,bottom: 11.0),
              child: Text("Images".toUpperCase(),
              style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black),),
            ), 
        Container(
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
           separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: posters.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(width: MediaQuery.of(context).size.width / 4,
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(posters[index]),
                fit: BoxFit.cover)
              ),),
            ),),
        )
      ],
    );
  }
}