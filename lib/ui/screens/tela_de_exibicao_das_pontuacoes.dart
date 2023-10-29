import 'package:campo_minado_flutter/db/collections/pontuacao.dart';
import 'package:campo_minado_flutter/db/db_metodos.dart';
import 'package:campo_minado_flutter/utils/formatar_tempo_decorrido.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TelaDeExibicaoDasPontuacoes extends StatelessWidget {
  const TelaDeExibicaoDasPontuacoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'fácil'),
                  Tab(text: 'intermediário'),
                  Tab(text: 'dificil'),
                ],
              ),
              title: const Text('Pontuações'),
            ),
            body: TabBarView(
              children: [
                FutureBuilder(
                  future: getPontuacoesPorDificuldade(1),
                  builder: (context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                FutureBuilder(
                  future: getPontuacoesPorDificuldade(2),
                  builder: (context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                FutureBuilder(
                  future: getPontuacoesPorDificuldade(3),
                  builder: (context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Widget> getPontuacoesPorDificuldade(int dificuldade) async {
    final DBMetodos db = DBMetodos();

    List<Pontuacao> pontuacoes;

    if (dificuldade == 1) {
      pontuacoes = await db.listarTodasVitoriasFacil();
    } else if (dificuldade == 2) {
      pontuacoes = await db.listarTodasVitoriasIntermediario();
    } else if (dificuldade == 3) {
      pontuacoes = await db.listarTodasVitoriasDificil();
    } else {
      return Container();
    }

    if (pontuacoes.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma pontuação armazenada ainda!',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: pontuacoes.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Text(
                pontuacoes[index].nomeDoJogador,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5),
              if (index == 0)
                const FaIcon(FontAwesomeIcons.crown,
                    color: Colors.amber, size: 12)
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formatarTempoDecorrido(
                  Duration(seconds: pontuacoes[index].duracaoEmSegundos))),
            ],
          ),
        );
      },
    );
  }
}
