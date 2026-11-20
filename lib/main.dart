import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const CvApp());
}

class Donnees {
  static const identifiant = 'christelle';
  static const motDePasse = 'christelle2026';

  static const nom = 'Christelle Nshonole';
  static const titre = 'Étudiante en Informatique et Gestion';
  
  static const naissance = '15 août 2005';
  static const lieuNaissance = 'Bukavu';
  static const nationalite = 'Congolaise';
  static const etatCivil = 'Célibataire';

  static const etudes = 'L3 à l\'ISIG-Goma';
  static const filiere = 'Informatique et gestion';
  static const experience = 'Stage académique à la REGIDESO';

  static const competences = ['Informatique', 'Word', 'Bases de données', 'Programmation'];
  static const qualites = ['Patiente', 'Curieuse', 'Sérieuse', 'Persévérante'];
  static const interets = ['Technologie', 'Lecture', 'Apprentissage'];

  static const pere = 'Mushingi';
  static const mere = 'Anny';
  static const rangFamille = '7e';
  static const fratrie = [
    {'nom': 'Josué', 'role': 'Frère'},
    {'nom': 'Lumière Denise', 'role': 'Sœur'},
    {'nom': 'Lumière', 'role': 'Sœur'},
    {'nom': 'Grâce', 'role': 'Sœur'},
  ];
}

const kBg = Color(0xFFF9F8FC);
const kSurface = Color(0xFFFFFFFF);
const kInk = Color(0xFF1E1B2E);
const kInk2 = Color(0xFF6E6B8A);
const kInk3 = Color(0xFF9E9CB0);
const kBorder = Color(0xFFEAE7F2);
const kAccent = Color(0xFF8B5CF6);
const kAccentSoft = Color(0xFFF3E8FF);
const kDanger = Color(0xFFEF4444);

TextStyle font(
  double size, {
  FontWeight w = FontWeight.w400,
  Color c = kInk,
  double? h,
  double? ls,
}) =>
    GoogleFonts.outfit(
        fontSize: size, fontWeight: w, color: c, height: h, letterSpacing: ls);

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Christelle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kAccent,
          brightness: Brightness.light,
        ).copyWith(
          primary: kAccent,
          surface: kSurface,
          onSurface: kInk,
        ),
        scaffoldBackgroundColor: kBg,
        splashFactory: InkSparkle.splashFactory,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: kAccent,
          selectionColor: kAccent.withOpacity(0.2),
          selectionHandleColor: kAccent,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  final IconData icon;
  const SectionTitle(this.text, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28, bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kAccentSoft,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: kAccent),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: font(18, w: FontWeight.w700, ls: -0.3),
          ),
        ],
      ),
    );
  }
}

class CardBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const CardBox({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(
            color: kAccent.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(20),
      child: child,
    );
  }
}

void toast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(msg, style: font(13, w: FontWeight.w500, c: Colors.white)),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 90),
      backgroundColor: kInk,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idCtrl = TextEditingController();
  final _mdpCtrl = TextEditingController();
  bool _hide = true;
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _error = null;
      _loading = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    if (_idCtrl.text.trim().toLowerCase() == Donnees.identifiant &&
        _mdpCtrl.text == Donnees.motDePasse) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => const MainShell(),
          transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        ),
      );
    } else {
      setState(() {
        _loading = false;
        _error = 'Identifiant ou mot de passe incorrect.';
      });
    }
  }

  @override
  void dispose() {
    _idCtrl.dispose();
    _mdpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 48),
              
              const SizedBox(height: 36),
              Text('Bienvenue.', style: font(34, w: FontWeight.w800, h: 1.1, ls: -1.0)),
              const SizedBox(height: 8),
              Text('Connectez-vous pour voir mon CV.', style: font(15, c: kInk2, h: 1.5)),
              const SizedBox(height: 48),

              _buildField(
                label: 'Identifiant',
                ctrl: _idCtrl,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              _buildField(
                label: 'Mot de passe',
                ctrl: _mdpCtrl,
                obscure: _hide,
                onSubmitted: (_) => _submit(),
                suffix: IconButton(
                  iconSize: 20,
                  icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: kInk3),
                  onPressed: () => setState(() => _hide = !_hide),
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: kDanger.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, size: 18, color: kDanger),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(_error!, style: font(13, w: FontWeight.w500, c: kDanger)),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                child: FilledButton(
                  onPressed: _loading ? null : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: kAccent,
                    disabledBackgroundColor: kAccent.withOpacity(0.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        )
                      : Text('Se connecter', style: font(16, w: FontWeight.w700, c: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController ctrl,
    bool obscure = false,
    Widget? suffix,
    TextInputAction? textInputAction,
    ValueChanged<String>? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: font(13, w: FontWeight.w600, c: kInk2)),
        ),
        TextField(
          controller: ctrl,
          obscureText: obscure,
          cursorColor: kAccent,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          style: font(15, w: FontWeight.w500),
          decoration: InputDecoration(
            filled: true,
            fillColor: kSurface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: suffix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: kBorder)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: kBorder)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: kAccent, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _i = 0;

  void _logout() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => const LoginPage(),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      AccueilPage(onLogout: _logout),
      const FamillePage(),
    ];

    return Scaffold(
      backgroundColor: kBg,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: KeyedSubtree(key: ValueKey(_i), child: pages[_i]),
      ),
      bottomNavigationBar: _NavBar(
        index: _i,
        onChange: (v) => setState(() => _i = v),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChange;
  const _NavBar({required this.index, required this.onChange});

  static const _items = [
    (icon: Icons.person_outline_rounded, active: Icons.person_rounded, label: 'Mon CV'),
    (icon: Icons.people_outline_rounded, active: Icons.people_rounded, label: 'Famille'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kSurface,
        border: Border(top: BorderSide(color: kBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              for (int i = 0; i < _items.length; i++) Expanded(child: _item(i)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(int i) {
    final active = i == index;
    final it = _items[i];
    return InkWell(
      onTap: () => onChange(i),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(active ? it.active : it.icon, size: 24, color: active ? kAccent : kInk3),
          const SizedBox(height: 4),
          Text(
            it.label,
            style: font(11, w: active ? FontWeight.w700 : FontWeight.w500, c: active ? kAccent : kInk3),
          ),
        ],
      ),
    );
  }
}

class AccueilPage extends StatelessWidget {
  final VoidCallback? onLogout;
  const AccueilPage({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Portfolio', style: font(15, w: FontWeight.w600, c: kInk2)),
                  Material(
                    color: kSurface,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: onLogout,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: kBorder),
                        ),
                        child: const Icon(Icons.logout_rounded, size: 18, color: kInk2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              CardBox(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: kAccentSoft,
                        shape: BoxShape.circle,
                        border: Border.all(color: kAccent.withOpacity(0.2), width: 2),
                      ),
                      child: Center(
                        child: Text('CN', style: font(28, w: FontWeight.w800, c: kAccent)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(Donnees.nom, style: font(22, w: FontWeight.w800, ls: -0.5)),
                    const SizedBox(height: 6),
                    Text(Donnees.titre, style: font(14, c: kAccent, w: FontWeight.w600)),
                  ],
                ),
              ),

              const SectionTitle('Informations', Icons.info_outline_rounded),
              CardBox(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _infoRow(Icons.cake_outlined, 'Date de naissance', Donnees.naissance),
                    const Divider(color: kBorder, height: 1),
                    _infoRow(Icons.location_on_outlined, 'Lieu de naissance', Donnees.lieuNaissance),
                    const Divider(color: kBorder, height: 1),
                    _infoRow(Icons.flag_outlined, 'Nationalité', Donnees.nationalite),
                    const Divider(color: kBorder, height: 1),
                    _infoRow(Icons.favorite_border_rounded, 'État civil', Donnees.etatCivil),
                  ],
                ),
              ),

              const SectionTitle('Études & Expérience', Icons.school_outlined),
              CardBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Formation', style: font(12, w: FontWeight.w600, c: kInk3, ls: 0.5)),
                    const SizedBox(height: 4),
                    Text(Donnees.etudes, style: font(16, w: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(Donnees.filiere, style: font(14, c: kInk2, w: FontWeight.w500)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: kBorder, height: 1),
                    ),
                    Text('Expérience', style: font(12, w: FontWeight.w600, c: kInk3, ls: 0.5)),
                    const SizedBox(height: 4),
                    Text(Donnees.experience, style: font(16, w: FontWeight.w700)),
                  ],
                ),
              ),

              const SectionTitle('Compétences', Icons.bolt_rounded),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: Donnees.competences.map((e) => _tag(e, primary: true)).toList(),
              ),

              const SectionTitle('Qualités', Icons.star_outline_rounded),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: Donnees.qualites.map((e) => _tag(e)).toList(),
              ),

              const SectionTitle('Centres d\'intérêt', Icons.favorite_rounded),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: Donnees.interets.map((e) => _tag(e)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: kInk3),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: font(14, c: kInk2, w: FontWeight.w500))),
          Text(value, style: font(14, w: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _tag(String text, {bool primary = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: primary ? kAccentSoft : kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary ? kAccent.withOpacity(0.2) : kBorder),
      ),
      child: Text(text, style: font(13, w: FontWeight.w600, c: primary ? kAccent : kInk2)),
    );
  }
}

class FamillePage extends StatelessWidget {
  const FamillePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text('Ma Famille', style: font(28, w: FontWeight.w800, ls: -0.8)),
              const SizedBox(height: 8),
              Text('Christelle est la ${Donnees.rangFamille} de la famille.', style: font(14, c: kInk2)),
              const SizedBox(height: 24),

              const SectionTitle('Parents', Icons.home_outlined),
              Row(
                children: [
                  Expanded(child: _parentCard(Donnees.pere, 'Père')),
                  const SizedBox(width: 12),
                  Expanded(child: _parentCard(Donnees.mere, 'Mère')),
                ],
              ),

              const SectionTitle('Frères & Sœurs', Icons.people_outlined),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                ),
                itemCount: Donnees.fratrie.length,
                itemBuilder: (context, index) {
                  final f = Donnees.fratrie[index];
                  return CardBox(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kBg,
                            shape: BoxShape.circle,
                            border: Border.all(color: kBorder),
                          ),
                          child: Center(
                            child: Text(f['nom']![0], style: font(16, w: FontWeight.w700, c: kInk2)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          f['nom']!,
                          style: font(14, w: FontWeight.w600),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(f['role']!, style: font(11, c: kInk3)),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _parentCard(String nom, String role) {
    return CardBox(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: kAccentSoft,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(nom[0], style: font(22, w: FontWeight.w800, c: kAccent)),
            ),
          ),
          const SizedBox(height: 12),
          Text(nom, style: font(15, w: FontWeight.w700), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Text(role, style: font(12, c: kInk2, w: FontWeight.w500)),
        ],
      ),
    );
  }
}