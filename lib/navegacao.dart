import 'package:flutter/material.dart';
import 'package:youtube_app/custom_search_delegate.dart';
import 'package:youtube_app/ui/biblioteca_page.dart';
import 'package:youtube_app/ui/emalta_page.dart';
import 'package:youtube_app/ui/inicio_page.dart';
import 'package:youtube_app/ui/inscricoes_page.dart';

class Navegacao extends StatefulWidget {
  const Navegacao({Key? key}) : super(key: key);

  @override
  State<Navegacao> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int _indiceAtual = 0;
  String _resultado = "";
  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      InicioPage(_resultado),
      EmAltaPage(),
      InscricoesPage(),
      BibliotecaPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              var rsp = await showSearch(
                  context: context, delegate: CustomSearchDelegate());
              setState(() {
                _resultado = rsp as String;
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        onTap: (indice) {
          setState(() {
            _indiceAtual = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Início",
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "Em alta",
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            label: "Incrições",
            icon: Icon(
              Icons.subscriptions,
            ),
          ),
          BottomNavigationBarItem(
            label: "Biblioteca",
            icon: Icon(
              Icons.folder,
            ),
          ),
        ],
      ),
    );
  }
}
