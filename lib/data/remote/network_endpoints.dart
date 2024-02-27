class NetworkEndpoints {
  static const String _baseUrl = "https://api.themoviedb.org/3";

  static String nowPlayingMovies = "$_baseUrl/movie/now_playing";
  static String popularMovies = "$_baseUrl/movie/popular";
  static String topRatedMovies = "$_baseUrl/movie/top_rated";
  static String upcomingMovies = "$_baseUrl/movie/upcoming";
  static String detailsMovie = "$_baseUrl/movie/";
  static String detailsTv = "$_baseUrl/tv/";
  static String topRatedTv = "$_baseUrl/tv/top_rated";
  static String popularTv = "$_baseUrl/tv/popular";
  static String onTheAirTv = "$_baseUrl/tv/on_the_air";
  static String airingTv = "$_baseUrl/tv/airing_today";
  static String castingTv = "$_baseUrl/tv/";
  static String castingMovie = "$_baseUrl/movie/";
  static String search = "$_baseUrl/search/movie";

  static String API_KEY = "d6a3804b9650e332637a4a35198c4f15";
  static String Bearer_token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNmEzODA0Yjk2NTBlMzMyNjM3YTRhMzUxOThjNGYxNSIsInN1YiI6IjY1YWU5ZjQyMTU4Yzg1MDEwYWEwNGFhNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6IZfVN6XBr2mWCDnICCCX20mTJ3jPg8llo_pywhA5JI";

  static String refreshTokenUrl = "${_baseUrl}refresh";
  static String loginUrl = "${_baseUrl}refresh";
  static String artistsUrl = "${_baseUrl}refresh";
}
