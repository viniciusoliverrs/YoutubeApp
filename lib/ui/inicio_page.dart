import 'package:flutter/material.dart';
import 'package:youtube_app/api.dart';
import 'package:youtube_app/model/video_model.dart';
// import 'package:flutter_youtube/flutter_youtube.dart';

class InicioPage extends StatefulWidget {
  String _resultado;

  InicioPage(this._resultado, {Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  Api api = Api();
  _listarVideos(String pesquisa) {
    return api.pesquisar(pesquisa);
  }

  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant InicioPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return FutureBuilder(
        future: _listarVideos(widget._resultado.toString()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    List<Video> videos = snapshot.data as List<Video>;
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(videos[index].imagem),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(videos[index].titulo),
                            subtitle: Text(videos[index].canal),
                          )
                        ],
                      ),
                      onTap: () {
                        // dependencie don't support null safety
                        // FlutterYoutube.playYoutubeVideoById(
                        //   apiKey: CHAVE_API,
                        //   videoId: videos[index].id,
                        //   fullScreen: true,
                        // );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 2,
                    color: Colors.red,
                  ),
                  itemCount: (snapshot.data! as List).length,
                );
              } else {
                return const Center(
                  child: Text("Nenhum dado a ser exibido!"),
                );
              }
          }
        });
  }
}
