class Video {
  String id;
  String titulo;
  String descricao;
  String imagem;
  String canal;

  Video(this.id, this.descricao, this.titulo, this.imagem, this.canal);

  factory Video.fromJson(Map<String, dynamic> map) {
    return Video(
      map["id"]["videoId"],
      map["snippet"]["description"],
      map["snippet"]["title"],
      map["snippet"]["thumbnails"]["high"]["url"],
      map["snippet"]["channelTitle"],
    );
  }
}
