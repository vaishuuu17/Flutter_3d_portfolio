import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _bg = Color(0xFF090B18);
const _panel = Color(0xFF12162A);
const _purple = Color(0xFF9B7BFF);
const _blue = Color(0xFF55B8FF);
const _muted = Color(0xFFADB4CC);
const _github = 'https://github.com/vaishuuu17';
const _cropRepo = 'https://github.com/vaishuuu17/crop_doctor';
const _email = 'vaishnavimore360@gmail.com';
const _linkedin = 'https://www.linkedin.com/in/vaishnavi-more-2142a8288';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});
  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _scroll = ScrollController();
  final _keys = List.generate(7, (_) => GlobalKey());
  final _labels = ['Home', 'About', 'Skills', 'Projects', 'Experience', 'Education', 'Contact'];
  int _active = 0;

  void _go(int index) {
    setState(() => _active = index);
    final context = _keys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 650), curve: Curves.easeInOut, alignment: 0.04);
    }
  }

  Future<void> _open(String value) async {
    final uri = Uri.parse(value);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() { _scroll.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 760;
    return Scaffold(
      drawer: compact ? Drawer(backgroundColor: _panel, child: SafeArea(child: ListView(children: [const Padding(padding: EdgeInsets.all(22), child: Text('VAISHNAVI MORE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2))), ...List.generate(_labels.length, (i) => ListTile(title: Text(_labels[i]), onTap: () { Navigator.pop(context); _go(i); }))]))) : null,
      body: Stack(children: [
        const Positioned.fill(child: _BackgroundGlow()),
        CustomScrollView(controller: _scroll, slivers: [
          SliverAppBar(
            pinned: true, floating: true, elevation: 0, backgroundColor: _bg.withOpacity(.92),
            title: const Text('VM.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: _purple, letterSpacing: 1)),
            actions: compact ? null : [for (int i=0;i<_labels.length;i++) TextButton(onPressed: () => _go(i), child: Text(_labels[i], style: TextStyle(color: _active == i ? Colors.white : _muted, fontWeight: _active == i ? FontWeight.bold : FontWeight.normal))), const SizedBox(width: 24)],
          ),
          SliverToBoxAdapter(child: _section(key: _keys[0], child: _HeroSection(compact: compact, onProjects: () => _go(3), onContact: () => _go(6)))),
          SliverToBoxAdapter(child: _section(key: _keys[1], child: _AboutSection(compact: compact))),
          SliverToBoxAdapter(child: _section(key: _keys[2], child: const _SkillsSection())),
          SliverToBoxAdapter(child: _section(key: _keys[3], child: _ProjectsSection(onOpen: _open))),
          SliverToBoxAdapter(child: _section(key: _keys[4], child: const _ExperienceSection())),
          SliverToBoxAdapter(child: _section(key: _keys[5], child: const _EducationSection())),
          SliverToBoxAdapter(child: _section(key: _keys[6], child: _ContactSection(onOpen: _open))),
          const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.fromLTRB(24, 20, 24, 35), child: Center(child: Text('Designed & built with Flutter  •  © 2026 Vaishnavi More', style: TextStyle(color: _muted, fontSize: 12))))),
        ]),
        if (compact) Positioned(left: 8, top: 5, child: Builder(builder: (ctx) => IconButton(onPressed: () => Scaffold.of(ctx).openDrawer(), icon: const Icon(Icons.menu, color: Colors.white))))
      ]),
    );
  }

  Widget _section({required GlobalKey key, required Widget child}) => Container(key: key, child: child);
}

class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();
  @override
  Widget build(BuildContext context) => Stack(children: [
    Positioned(top: 80, right: -130, child: _blurCircle(360, _purple.withOpacity(.15))),
    Positioned(top: 850, left: -170, child: _blurCircle(390, _blue.withOpacity(.10))),
    Positioned(bottom: 300, right: -160, child: _blurCircle(360, _purple.withOpacity(.10))),
  ]);
  Widget _blurCircle(double size, Color color) => Container(width: size, height: size, decoration: BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: [BoxShadow(color: color, blurRadius: 120, spreadRadius: 45)]));
}

class _WrapWidth extends StatelessWidget {
  const _WrapWidth({required this.child}); final Widget child;
  @override
  Widget build(BuildContext context) => Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1120), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 76), child: child)));
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.compact, required this.onProjects, required this.onContact});
  final bool compact; final VoidCallback onProjects, onContact;
  @override
  Widget build(BuildContext context) {
    final intro = Column(crossAxisAlignment: compact ? CrossAxisAlignment.center : CrossAxisAlignment.start, children: [
      const _Eyebrow('HELLO, I’M VAISHNAVI MORE'), const SizedBox(height: 22),
      Text('Aspiring Software\nDeveloper', textAlign: compact ? TextAlign.center : TextAlign.left, style: TextStyle(fontSize: compact ? 42 : 62, height: 1.12, fontWeight: FontWeight.w900, letterSpacing: -2)),
      const SizedBox(height: 20), Text('Final-Year BE Electronics & Telecommunication Engineering Student  |  2027', textAlign: compact ? TextAlign.center : TextAlign.left, style: const TextStyle(color: _muted, fontSize: 16, height: 1.7)),
      const SizedBox(height: 18), const Text('Building thoughtful digital experiences with Flutter, Python and intelligent technologies.', style: TextStyle(color: Color(0xFFDCE1F5), fontSize: 16, height: 1.7)),
      const SizedBox(height: 30), Wrap(alignment: compact ? WrapAlignment.center : WrapAlignment.start, spacing: 14, runSpacing: 12, children: [ElevatedButton.icon(onPressed: onProjects, icon: const Icon(Icons.arrow_forward), label: const Text('View Projects'), style: _primaryButton), OutlinedButton.icon(onPressed: onContact, icon: const Icon(Icons.mail_outline), label: const Text('Contact Me'), style: _outlineButton)]),
      const SizedBox(height: 28), const Wrap(spacing: 9, runSpacing: 9, children: [_Tag('Flutter & Dart'), _Tag('Python'), _Tag('AI & Machine Learning'), _Tag('SQL'), _Tag('Web Technologies')]),
    ]);
    return _WrapWidth(child: compact
      ? Column(children: [intro, const SizedBox(height: 30), const _OrbitIllustration()])
      : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Expanded(flex: 6, child: intro), const Expanded(flex: 5, child: _OrbitIllustration())]));
  }
}

class _OrbitIllustration extends StatefulWidget { const _OrbitIllustration(); @override State<_OrbitIllustration> createState() => _OrbitIllustrationState(); }
class _OrbitIllustrationState extends State<_OrbitIllustration> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 18))..repeat();
  @override void dispose() { _controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => SizedBox(height: 390, child: AnimatedBuilder(animation: _controller, builder: (_, __) => Stack(alignment: Alignment.center, children: [
    Container(width: 280, height: 280, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const RadialGradient(colors: [Color(0xFF30245F), Color(0xFF11172F), Colors.transparent]), boxShadow: [BoxShadow(color: _purple.withOpacity(.22), blurRadius: 55, spreadRadius: 12)])),
    Transform.rotate(angle: _controller.value * 2 * math.pi, child: Container(width: 310, height: 155, decoration: BoxDecoration(border: Border.all(color: _purple.withOpacity(.65), width: 1.2), borderRadius: BorderRadius.circular(100)))),
    Transform.rotate(angle: -_controller.value * 2 * math.pi, child: Container(width: 230, height: 310, decoration: BoxDecoration(border: Border.all(color: _blue.withOpacity(.45), width: 1.2), borderRadius: BorderRadius.circular(100)))),
    Container(width: 170, height: 170, decoration: BoxDecoration(borderRadius: BorderRadius.circular(42), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFB7A3FF), Color(0xFF5B55C9), Color(0xFF202D64)]), boxShadow: [BoxShadow(color: _purple.withOpacity(.4), blurRadius: 35, offset: const Offset(0, 18))]), child: const Icon(Icons.code_rounded, size: 82, color: Colors.white)),
    Positioned(top: 42, right: 32, child: _floatIcon(Icons.memory, _blue)), Positioned(bottom: 45, left: 25, child: _floatIcon(Icons.auto_awesome, _purple)),
    Positioned(bottom: 20, child: const Text('CREATIVE  •  CURIOUS  •  CONSTANTLY LEARNING', style: TextStyle(color: _muted, fontSize: 10, letterSpacing: 1.4))),
  ])));
  Widget _floatIcon(IconData icon, Color color) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(18), border: Border.all(color: color.withOpacity(.55)), boxShadow: [BoxShadow(color: color.withOpacity(.18), blurRadius: 25)]), child: Icon(icon, color: color, size: 27));
}

class _AboutSection extends StatelessWidget { const _AboutSection({required this.compact}); final bool compact;
  @override Widget build(BuildContext context) => _WrapWidth(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const _SectionTitle('About Me', 'A little about my journey'), const SizedBox(height: 26), Container(padding: const EdgeInsets.all(28), decoration: _panelDecoration, child: Text('I’m Vaishnavi, a final-year Electronics & Telecommunication Engineering student at SKNCOE. I enjoy exploring the intersection of software development, mobile applications and artificial intelligence. Through academic and personal projects, I’m building practical skills in Flutter, Python, machine learning and database technologies.\n\nMy goal is to grow as a software developer, contribute to meaningful products and keep learning by solving real-world problems.', style: const TextStyle(color: _muted, fontSize: 16, height: 1.9))), const SizedBox(height: 18), const Wrap(spacing: 12, runSpacing: 12, children: [_InfoPill(Icons.lightbulb_outline, 'Problem solving'), _InfoPill(Icons.school_outlined, 'Continuous learning'), _InfoPill(Icons.devices_outlined, 'Building applications')]) ]));
}

class _SkillsSection extends StatelessWidget { const _SkillsSection();
  @override Widget build(BuildContext context) { final groups = <(String, IconData, List<String>)>[( 'Programming', Icons.terminal, ['Python', 'Dart', 'SQL']), ('Mobile Development', Icons.phone_android, ['Flutter', 'Dart', 'Responsive UI']), ('AI & Machine Learning', Icons.psychology, ['Machine Learning', 'CNN', 'TensorFlow Lite', 'OpenCV']), ('Web & Tools', Icons.web, ['HTML / CSS', 'Web Technologies', 'Git & GitHub'])]; return _WrapWidth(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const _SectionTitle('Skills', 'Tools I use to turn ideas into solutions'), const SizedBox(height: 28), LayoutBuilder(builder: (context, c) { final count = c.maxWidth > 760 ? 2 : 1; return GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: groups.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: count == 2 ? 2.35 : 2.5), itemBuilder: (_, i) { final g = groups[i]; return Container(padding: const EdgeInsets.all(22), decoration: _panelDecoration, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(g.$2, color: _purple, size: 26), const SizedBox(height: 12), Text(g.$1, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), Wrap(spacing: 8, runSpacing: 8, children: [for (final s in g.$3) _Tag(s)])])); }); })])); }
}

class _ProjectsSection extends StatelessWidget { const _ProjectsSection({required this.onOpen}); final Future<void> Function(String) onOpen;
  @override Widget build(BuildContext context) => _WrapWidth(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const _SectionTitle('Featured Projects', 'A selection of things I’ve worked on'), const SizedBox(height: 28), LayoutBuilder(builder: (context, c) { final wide = c.maxWidth > 760; return GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: wide ? 2 : 1, crossAxisSpacing: 18, mainAxisSpacing: 18, childAspectRatio: wide ? 1.38 : 1.45, children: [
    _ProjectCard(icon: Icons.local_florist, accent: const Color(0xFF79D7A4), title: 'Crop Doctor', description: 'AI-based crop disease detection using MobileNetV2 and TensorFlow Lite. The model achieved 91.31% test accuracy.', tech: 'Flutter  •  Python  •  Deep Learning  •  TFLite', onTap: () => onOpen(_cropRepo), button: 'View GitHub'),
    _ProjectCard(icon: Icons.texture, accent: _blue, title: 'Garment Defect Detection', description: 'CNN-based fabric defect detection project combining image preprocessing and computer vision for textile quality inspection.', tech: 'Python  •  CNN  •  OpenCV  •  Machine Learning', onTap: () => onOpen(_github), button: 'GitHub Profile'),
    _ProjectCard(icon: Icons.psychology_alt, accent: _purple, title: 'Brain Game', description: 'A timed, score-based interactive brain game. The screenshots show its play screen, score counter and game-over/restart flow.', tech: 'Flutter  •  Dart  •  Game UI', onTap: () {}, button: 'Project Preview', screenshot: 'assets/images/brain_game_play.png'),
  ]); })]));
}

class _ExperienceSection extends StatelessWidget { const _ExperienceSection();
  @override Widget build(BuildContext context) => _WrapWidth(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const _SectionTitle('Experience', 'Practical learning and internship experience'), const SizedBox(height: 28), Container(padding: const EdgeInsets.all(26), decoration: _panelDecoration, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Python Technologies Intern', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 6), const Text('MASS IT Solutions LLP  •  Pune, Maharashtra', style: TextStyle(color: _blue, fontWeight: FontWeight.w600)), const SizedBox(height: 6), const Text('2 January 2026 – 18 February 2026', style: TextStyle(color: _muted)), const SizedBox(height: 16), const Text('• Explored Python technologies, Data Science and Machine Learning projects.\n• Worked on CNN-based garment defect detection for textile images.\n• Used image preprocessing and computer vision techniques with Python and OpenCV.\n• Strengthened practical understanding of Python, deep learning and image classification.', style: TextStyle(color: _muted, height: 1.8))]))]));
}

class _EducationSection extends StatelessWidget { const _EducationSection();
  @override Widget build(BuildContext context) => _WrapWidth(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const _SectionTitle('Education', 'My academic background'), const SizedBox(height: 28), Container(padding: const EdgeInsets.all(26), decoration: _panelDecoration, child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 52, height: 52, decoration: BoxDecoration(color: _purple.withOpacity(.15), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.school, color: _purple)), const SizedBox(width: 18), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Bachelor of Engineering – Electronics & Telecommunication', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, height: 1.4)), SizedBox(height: 8), Text('Smt. Kashibai Navale College of Engineering (SKNCOE)', style: TextStyle(color: _muted, height: 1.5)), SizedBox(height: 8), Text('2023 – 2027  •  CGPA: 7.84 / 10  •  Expected graduation: 2027', style: TextStyle(color: _blue, fontWeight: FontWeight.w600))]))]))]));
}

class _ContactSection extends StatelessWidget { const _ContactSection({required this.onOpen}); final Future<void> Function(String) onOpen;
  @override Widget build(BuildContext context) => _WrapWidth(child: Container(width: double.infinity, padding: const EdgeInsets.all(30), decoration: BoxDecoration(borderRadius: BorderRadius.circular(28), gradient: const LinearGradient(colors: [Color(0xFF211B45), Color(0xFF111A35)]), border: Border.all(color: _purple.withOpacity(.3))), child: Column(children: [const _Eyebrow('LET’S CONNECT'), const SizedBox(height: 15), const Text('Have an opportunity or an idea?', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)), const SizedBox(height: 12), const Text('I’d love to connect, learn and explore how I can contribute.', textAlign: TextAlign.center, style: TextStyle(color: _muted, height: 1.6)), const SizedBox(height: 26), Wrap(alignment: WrapAlignment.center, spacing: 12, runSpacing: 12, children: [OutlinedButton.icon(onPressed: () => onOpen('mailto:$_email'), icon: const Icon(Icons.email_outlined), label: const Text('Email')), OutlinedButton.icon(onPressed: () => onOpen(_linkedin), icon: const Icon(Icons.person_outline), label: const Text('LinkedIn')), OutlinedButton.icon(onPressed: () => onOpen(_github), icon: const Icon(Icons.code), label: const Text('GitHub')), OutlinedButton.icon(onPressed: () => onOpen(Uri.base.resolve('assets/assets/vaishnavi_more_resume.pdf').toString()), icon: const Icon(Icons.download_outlined), label: const Text('Download Resume'))]), const SizedBox(height: 18), SelectableText(_email, style: const TextStyle(color: _muted, fontSize: 13))])));
}

class _ProjectCard extends StatelessWidget { const _ProjectCard({required this.icon, required this.accent, required this.title, required this.description, required this.tech, required this.onTap, required this.button, this.screenshot}); final IconData icon; final Color accent; final String title, description, tech, button; final VoidCallback onTap; final String? screenshot;
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(24), decoration: _panelDecoration, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [if (screenshot != null) ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset(screenshot!, height: 112, width: double.infinity, fit: BoxFit.cover)), if (screenshot != null) const SizedBox(height: 14), Container(width: 48, height: 48, decoration: BoxDecoration(color: accent.withOpacity(.13), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: accent, size: 27)), const SizedBox(height: 17), Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const SizedBox(height: 10), Expanded(child: Text(description, style: const TextStyle(color: _muted, height: 1.6, fontSize: 13))), Text(tech, style: const TextStyle(color: _blue, fontSize: 11, height: 1.5)), const SizedBox(height: 15), Align(alignment: Alignment.centerLeft, child: TextButton.icon(onPressed: onTap, icon: const Icon(Icons.open_in_new, size: 16), label: Text(button)))]));
}

class _SectionTitle extends StatelessWidget { const _SectionTitle(this.title, this.subtitle); final String title, subtitle; @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, letterSpacing: -.7)), const SizedBox(height: 8), Text(subtitle, style: const TextStyle(color: _muted, fontSize: 15))]); }
class _Eyebrow extends StatelessWidget { const _Eyebrow(this.text); final String text; @override Widget build(BuildContext context) => Text(text, style: const TextStyle(color: _blue, letterSpacing: 2.2, fontWeight: FontWeight.bold, fontSize: 11)); }
class _Tag extends StatelessWidget { const _Tag(this.text); final String text; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: _purple.withOpacity(.10), borderRadius: BorderRadius.circular(30), border: Border.all(color: _purple.withOpacity(.25))), child: Text(text, style: const TextStyle(color: Color(0xFFDAD2FF), fontSize: 11, fontWeight: FontWeight.w600))); }
class _InfoPill extends StatelessWidget { const _InfoPill(this.icon, this.text); final IconData icon; final String text; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11), decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(.07))), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: _purple, size: 17), const SizedBox(width: 8), Text(text, style: const TextStyle(color: _muted, fontSize: 12))])); }

const _panelDecoration = BoxDecoration(color: _panel, borderRadius: BorderRadius.all(Radius.circular(22)), border: Border.fromBorderSide(BorderSide(color: Color(0x1FFFFFFF))));
const _primaryButton = ButtonStyle(backgroundColor: WidgetStatePropertyAll(_purple), foregroundColor: WidgetStatePropertyAll(Colors.white), padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 17)), shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))));
const _outlineButton = ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.white), side: WidgetStatePropertyAll(BorderSide(color: Color(0x669B7BFF))), padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 17)), shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)))));
