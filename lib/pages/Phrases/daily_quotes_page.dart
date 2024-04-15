import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/classes/ToolBoxNavigator.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/classes/Models/QuotesModel.dart';
import 'package:toolbox/firebase_service.dart';
import 'package:toolbox/pages/Phrases/create_daily_quotes_page.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';

class DailyPhrasesPage extends StatelessWidget {
  const DailyPhrasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<PhrasesModel> data = [];
    return BackgroundPage(
      currentPage: DrawerItens.phrases,
      title: 'Frases do dia',
      fabTooltip: 'Adicionar frase',
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      onFABPressed: () => ToolBoxNavigator.push(
        context,
        const CreateDailyPhrasesPage(),
      ),
      children: [
        Flexible(
          child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: FirebaseService().getPhrases(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Tivemos um problema, tente novamente mais tarde!',
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data.docs.isEmpty) {
                return const Center(
                  child: Text('Nenhuma frase encontrada!'),
                );
              } else {
                data = snapshot.data.docs
                    .map<PhrasesModel>(
                        (doc) => PhrasesModel.fromJson(doc.data()))
                    .toList();
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: AutoSizeText(
                          '"${data[index].description}"',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        subtitle: Text(
                          data[index].source == ''
                              ? '~ ${data[index].author.toString()}'
                              : '~ ${data[index].source.toString()}, ${data[index].author.toString()}',
                          textAlign: TextAlign.end,
                        ),
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                        // trailing: IconButton(
                        //   icon: const Icon(Icons.delete),
                        //   onPressed: () =>
                        //       FirebaseService().deletePhrase(data[index].id),
                        // ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
