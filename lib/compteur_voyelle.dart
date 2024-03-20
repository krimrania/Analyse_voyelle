import 'package:flutter/material.dart';
import 'dart:async'; // Importez ce package pour utiliser Timer


void main()=> runApp(const MyApp());


class SystemFonts {
  static void addFont(String s) {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 57, 117, 238), // Couleur principale
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color.fromARGB(255, 5, 7, 8)), // Couleur d'accentuation
        // Autres personnalisations de thème...
      ),
     initialRoute: '/',
      routes: {
        '/': (context) => VowelConsonantCounter(),
        // Ajoutez d'autres routes ici pour les écrans supplémentaires
      },
    );
  }
}

class VowelConsonantCounter extends StatefulWidget {
  @override
  _VowelConsonantCounterState createState() => _VowelConsonantCounterState();
}

class _VowelConsonantCounterState extends State<VowelConsonantCounter> {
  String inputText = '';
  Map<String, int> vowelCountMap = {
    'a': 0,
    'e': 0,
    'i': 0,
    'o': 0,
    'u': 0,
    'y': 0,
  };
  int consonantCount = 0;

  // Fonction pour compter les voyelles et les consonnes dans le texte donné
  void countVowelsAndConsonants(String text) {
    // Réinitialiser les compteurs à zéro
    setState(() {
      vowelCountMap = {
        'a': 0,
        'e': 0,
        'i': 0,
        'o': 0,
        'u': 0,
        'y': 0,
      };
      consonantCount = 0;
    });

    // Effectuer l'analyse du nouveau mot
    for (int i = 0; i < text.length; i++) {
      String char = text[i].toLowerCase();
      if (RegExp(r'[aeiouy]').hasMatch(char)) {
        setState(() {
          vowelCountMap[char] = (vowelCountMap[char] ?? 0) + 1;
        });
      } else if (RegExp(r'[a-z]').hasMatch(char)) {
        setState(() {
          consonantCount++;
        });
      }
    }
  }

  // Fonction pour obtenir la couleur de la voyelle spécifiée
  Color _getVowelColor(String vowel) {
    switch (vowel) {
      case 'a':
        return Colors.red;
      case 'e':
        return const Color.fromARGB(255, 255, 0, 149);
      case 'i':
        return Color.fromARGB(255, 211, 191, 4);
      case 'o':
        return Color.fromARGB(255, 204, 236, 74);
      case 'u':
        return Color.fromARGB(255, 19, 180, 62);
      case 'y':
        return Color.fromARGB(255, 23, 203, 182);
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Définir un Timer pour mettre à jour l'heure chaque seconde
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {}); // Mettre à jour l'état pour reconstruire l'interface utilisateur avec l'heure actuelle
    });

    // Obtenir l'heure actuelle
    String currentTime = "${DateTime.now().hour}:${DateTime.now().minute}";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ANALYSE VOYELLE',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: Text(
          currentTime,
          style: const TextStyle(fontSize: 16.0, color: Colors.white), // Style pour l'heure du système
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  inputText = value;
                });
              },
              style: const TextStyle(color: Colors.blue), // Couleur du texte
              decoration: InputDecoration(
                hintText: 'Entrez un mot',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Couleur du border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Couleur du border
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Couleur du border
                ),
                hintStyle: const TextStyle(color: Colors.blue), // Couleur du texte d'indice
              ),
            ),
            const SizedBox(height: 10.0), // Espace entre le champ de texte et le bouton
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    countVowelsAndConsonants(inputText);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor, // Couleur du bouton
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Bord arrondi du bouton
                  ),
                ),
                child: const Text(
                  'Analyser', // Texte du bouton
                  style: TextStyle(
                    color: Colors.white, // Couleur du texte
                    fontSize: 16.0, // Taille du texte
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 10.0), // Espace entre le texte et la liste des voyelles
            Expanded(
  child: ListView.builder(
    itemCount: vowelCountMap.length,
    itemBuilder: (context, index) {
      String vowel = vowelCountMap.keys.elementAt(index);
      int count = vowelCountMap[vowel] ?? 0;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: _getVowelColor(vowel), // Couleur de fond basée sur la voyelle
          borderRadius: BorderRadius.circular(8.0),
        ),
         child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$vowel : ',
                              style: const TextStyle(
                                color: Colors.white, // Couleur du texte
                                fontFamily: 'Damion', // Police d'écriture
                                fontSize: 28, // Taille du texte
                                
                              ),
                            ),
                            TextSpan(
                              text: '$count Occurrence', // Texte avec l'occurrence
                              style: const TextStyle(
                                color: Colors.white, // Couleur du texte
                                fontFamily: 'Damion', // Police d'écriture pour l'occurrence
                                fontSize: 16, // Taille du texte pour l'occurrence
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0), // Espace entre le texte des voyelles et le ListTile des consonnes
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary, // Couleur de fond pour le nombre de consonnes
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(
                  'Consonnes : $consonantCount', // Afficher le nombre de consonnes
                  style: const TextStyle(
                                color: Colors.white, // Couleur du texte
                                fontFamily: 'Damion', // Police d'écriture
                                fontSize: 28, // Taille du texte
                                
                              ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
