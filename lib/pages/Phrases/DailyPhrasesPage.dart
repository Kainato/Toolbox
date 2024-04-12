// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/classes/ToolBoxNavigator.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/classes/Models/PhrasesModel.dart';
import 'package:toolbox/firebase_service.dart';
import 'package:toolbox/pages/Phrases/CreateDailyPhrasesPage.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';

class DailyPhrasesPage extends StatelessWidget {
  const DailyPhrasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<PhrasesModel> data = [];
    return BackgroundPage(
      currentPage: DrawerItens.phrases,
      title: 'Daily Phrases Page',
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      onFABPressed: () {
        ToolBoxNavigator.push(
          context,
          const CreateDailyPhrasesPage(),
        );
      },
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
                return Center(
                  child: CircularProgressIndicator(
                    value: snapshot.connectionState.index.toDouble() / 2.0,
                  ),
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
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        data[index].description,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${data[index].author.toString()}\n${data[index].id.toString()}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            FirebaseService().deletePhrase(data[index].id),
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
