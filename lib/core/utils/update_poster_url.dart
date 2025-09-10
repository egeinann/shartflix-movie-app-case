class UpdatePosterurl {
   static String upgradePosterUrl(String url, {int width = 1000}) {
    if (url.startsWith('http://ia.media-imdb.com/')) {
      return url.replaceFirst(
          'http://ia.media-imdb.com/', 'https://m.media-amazon.com/');
    }

    final regex = RegExp(r'SX\d+');
    if (regex.hasMatch(url)) {
      return url.replaceAll(regex, 'SX$width');
    }
    return url;
  }
}