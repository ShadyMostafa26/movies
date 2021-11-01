abstract class AppStates{}

class AppInitialState extends AppStates{}

class GetNowPlayingLoadingState extends AppStates{}
class GetNowPlayingSuccessState extends AppStates{}
class GetNowPlayingErrorState extends AppStates{}

class GetGenresLoadingState extends AppStates{}
class GetGenresSuccessState extends AppStates{}
class GetGenresErrorState extends AppStates{}

class GetTrendingActorsLoadingState extends AppStates{}
class GetTrendingActorsSuccessState extends AppStates{}
class GetTrendingActorsErrorState extends AppStates{}

class GetTrendingMoviesLoadingState extends AppStates{}
class GetTrendingMoviesSuccessState extends AppStates{}
class GetTrendingMoviesErrorState extends AppStates{}

class GetMovieByGenreLoadingState extends AppStates{}
class GetMovieByGenreSuccessState extends AppStates{}
class GetMovieByGenreErrorState extends AppStates{}

class GetMovieDetailsLoadingState extends AppStates{}
class GetMovieDetailsSuccessState extends AppStates{}
class GetMovieDetailsErrorState extends AppStates{}

class GetSimilarMoviesSuccessState extends AppStates{}
class GetSimilarMoviesErrorState extends AppStates{}

class GetMovieVideoSuccessState extends AppStates{}
class GetMovieVideoErrorState extends AppStates{}

class SearchMovieLoadingState extends AppStates{}
class SearchMovieSuccessState extends AppStates{}
class SearchMovieErrorState extends AppStates{}