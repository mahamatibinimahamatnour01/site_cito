import 'package:flutter/material.dart';

void main() {
  runApp(const SiteCitoApp());
}

class SiteCitoApp extends StatelessWidget {
  const SiteCitoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Site Cito',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
// ------------------ PAGE ACCUEIL ------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Site Cito - Accueil')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Construis ton avenir avec Site Cito 🎓',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FormationsPage()),
                  );
                },
                child: const Text('Découvrir les Formations'),
              ),
            ],
          ),
        ),
      ),
      drawer: buildDrawer(context),
    );
  }
}

// ------------------ PAGE FORMATIONS ------------------
class FormationsPage extends StatelessWidget {
  const FormationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formations disponibles')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildFormationCard(
            context,
            'Bureautique (Word, Excel, PowerPoint)',
            'Niveau : Débutant | Durée : 1 mois',
          ),
          buildFormationCard(
            context,
            'Développement d’application mobile (Flutter/Dart)',
            'Langage Dart & Flutter | Durée : 1 mois',
          ),
          buildFormationCard(
            context,
            'Initiation en Cybersécurité',
            'Bases de la sécurité informatique | Durée : 1 mois',
          ),
          buildFormationCard(
            context,
            'Formation en E‑commerce',
            'Business en ligne | Durée : 3 jours',
          ),
        ],
      ),
      drawer: buildDrawer(context),
    );
  }

  Widget buildFormationCard(BuildContext context, String titre, String details) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(details, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InscriptionPage(formation: titre),
                    ),
                  );
                },
                child: const Text('S’inscrire'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ PAGE INSCRIPTION ------------------
class InscriptionPage extends StatefulWidget {
  final String? formation; // peut être null

  const InscriptionPage({super.key, this.formation});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final _formKey = GlobalKey<FormState>();
  String nom = '';
  String prenom = '';
  String contact = '';
  String email = '';
  String formationChoisie = 'Bureautique (Word, Excel, PowerPoint)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulaire d’Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(   // <-- scroll ajouté
            child: Column(
              children: [
                // Cas 1 : formation fixée (depuis Formations)
                if (widget.formation != null) ...[
                  Text(
                    'Formation choisie : ${widget.formation}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ] else ...[
                  // Cas 2 : choix libre (depuis le menu)
                  DropdownButtonFormField<String>(
                    value: formationChoisie,
                    decoration: InputDecoration(
                      labelText: 'Choisissez une formation',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Bureautique (Word, Excel, PowerPoint)',
                        child: Text('Bureautique (Word, Excel, PowerPoint)'),
                      ),
                      DropdownMenuItem(
                        value: 'Développement d’application mobile (Flutter/Dart)',
                        child: Text('Développement d’application mobile (Flutter/Dart)'),
                      ),
                      DropdownMenuItem(
                        value: 'Initiation en Cybersécurité',
                        child: Text('Initiation en Cybersécurité'),
                      ),
                      DropdownMenuItem(
                        value: 'Formation en E‑commerce',
                        child: Text('Formation en E‑commerce'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        formationChoisie = value ?? formationChoisie;
                      });
                    },
                  ),
                ],

                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nom'),
                  onSaved: (value) => nom = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Prénom'),
                  onSaved: (value) => prenom = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Contact'),
                  onSaved: (value) => contact = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Adresse Email'),
                  onSaved: (value) => email = value ?? '',
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.save();
                    final formationFinale =
                        widget.formation ?? formationChoisie;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Inscription envoyée : $nom $prenom\nFormation : $formationFinale',
                        ),
                      ),
                    );
                  },
                  child: const Text('Envoyer'),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: buildDrawer(context),
    );
  }
}
// ------------------ PAGE CONTACT ------------------
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contactez-nous 📩',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Email : ibinimahamatnour00@gmail.com'),
            SizedBox(height: 10),
            Text('Téléphone : +235 60021331'),
            SizedBox(height: 10),
            Text('N’Djamena'),
          ],
        ),
      ),
      drawer: buildDrawer(context),
    );
  }
}

// ------------------ PAGE À PROPOS ------------------
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(   // scroll ajouté pour éviter overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'À propos de Site Cito',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Je m’appelle Mahamat Ibini Mahamat Nour, '
                    'étudiant en Informatique à l’Université de N’Djamena. '
                    'Site Cito est une plateforme dédiée aux candidatures et inscriptions '
                    'pour des formations académiques et professionnelles.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Notre objectif est de faciliter l’accès aux formations, '
                    'd’offrir une interface simple pour les inscriptions, '
                    'et de promouvoir l’apprentissage pour tous.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      drawer: buildDrawer(context),
    );
  }
}

// ------------------ FOOTER ------------------
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: Text(
          '© 2026 Site Cito - Plateforme de formation en informatique',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    );
  }
}

// ------------------ MENU GLOBAL ------------------
Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.indigo),
          child: Text(
            'Site Cito',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          title: const Text('Accueil'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const HomePage()));
          },
        ),
        ListTile(
          title: const Text('Formations'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const FormationsPage()));
          },
        ),
        ListTile(
          title: const Text('Inscription'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const InscriptionPage()));
          },
        ),
        ListTile(
          title: const Text('Contact'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactPage()));
          },
        ),
        ListTile(
          title: const Text('À propos'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
          },
        ),
      ],
    ),
  );
}