import 'package:flutter/material.dart';
void main() {
  runApp(const ShifaApp());
}
class ShifaApp extends StatelessWidget {
  const ShifaApp( {
    super.key
  }
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Shifa - شفاء',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF0D9488),
    primary: const Color(0xFF0D9488),
    secondary: const Color(0xFF0284C7),
    surface: Colors.white,
    ),
    ),
    home: const ShifaScreensHome(),
    );
  }
}
class ShifaScreensHome extends StatelessWidget {
  const ShifaScreensHome( {
    super.key
  }
  );
  @override
  Widget build(BuildContext context) {
    return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
    appBar: AppBar(
    title: const Text('شفاء - Shifa'),
    centerTitle: true,
    ),
    body: ListView(
    padding: const EdgeInsets.all(20),
    children: [
    const Text(
    'اختر الشاشة التي تريد فتحها',
    style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 18),
    _ScreenTile(
    title: 'المساعد الطبي الذكي',
    subtitle: 'محادثة صحية تفاعلية',
    icon: Icons.auto_awesome_rounded,
    onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (_) => const AiHealthAssistantScreen(),
      ),
      );
    }
    ,
    ),
    const SizedBox(height: 12),
    _ScreenTile(
    title: 'التحليلات والرؤى الصحية',
    subtitle: 'مؤشرات الصحة والتوصيات',
    icon: Icons.insights_rounded,
    onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (_) => const HealthInsightsScreen(),
      ),
      );
    }
    ,
    ),
    ],
    ),
    ),
    );
  }
}
class _ScreenTile extends StatelessWidget {
  const _ScreenTile( {
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }
  );
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 0,
    color: Colors.white,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18),
    side: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    child: ListTile(
    contentPadding: const EdgeInsets.all(16),
    leading: CircleAvatar(
    backgroundColor: const Color(0xFFCCFBF1),
    child: Icon(icon,
    color: const Color(0xFF0D9488)),
    ),
    title: Text(
    title,
    style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.arrow_back_ios_new_rounded,
    size: 16),
    onTap: onTap,
    ),
    );
  }
}
enum SenderType {
  user,
  assistant
}
class ChatMessage {
  final String id;
  final String text;
  final SenderType sender;
  final DateTime timestamp;
  final List<String>? actionButtons;
  final bool isDisclaimer;
  ChatMessage( {
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.actionButtons,
    this.isDisclaimer = false,
  }
  );
}
class AiHealthAssistantScreen extends StatefulWidget {
  const AiHealthAssistantScreen( {
    super.key
  }
  );
  @override State<AiHealthAssistantScreen> createState() => _AiHealthAssistantScreenState();
}
class _AiHealthAssistantScreenState extends State<AiHealthAssistantScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  final List<String> _suggestedPrompts = [ 'اشرح لي نتيجة فحص السكر التراكمي',
  'ما هي أعراض نقص فيتامين د؟',
  'هل يتعارض الباراسيتامول مع المضاد؟',
  'نصائح للتغذية مع خمول الغدة',
  ];
  final List<ChatMessage> _messages = [ ChatMessage( id: '1',
  text: 'مرحباً بك يا أحمد! 👋 أنا مساعدك الصحي الذكي من «شفاء». كيف يمكنني' +
    'مساعدتك في صحتك اليوم؟ يمكنك سؤالي عن نتائج فحوصاتك، أدويتك، أو أي' +
    'أعراض تشعر بها.',
  sender: SenderType.assistant,
  timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  ChatMessage( id: '2',
  text: 'أشعر بصداع مستمر منذ الصباح مع إرهاق خفيف، هل يمكن أن يكون له علاقة بجرعة دواء الضغط؟',
  sender: SenderType.user,
  timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
  ),
  ChatMessage( id: '3',
  text: 'سلامتك وألف لا بأس عليك يا أحمد! 🌿\n\nبناءً على ملفك الطبي، أنت' +
    'تتناول «كونكور 5 مجم» في الصباح. الصداع والإرهاق الخفيف قد يرتبطان' +
    'أحياناً بـ:\n• تغيرات في ضغط الدم (انخفاض أو ارتفاع مؤقت)\n• قلة شرب' +
    'الماء أو عدم أخذ قسط كافٍ من النوم\n• تخطي وجبة الإفطار قبل' +
    'الدواء\n\n💡 نصائح أولية سريعة:\n1. استرح في مكان هادئ وإضاءة خافتة' +
    'لمدة 20 دقيقة.\n2. اشرب كوبين من الماء.\n3. قم بقياس ضغط الدم وتسجيل' +
    'القراءة الآن.\n\n⚠️ تنبيه هام: إذا كان الصداع شديداً جداً أو مفاجئاً' +
    'أو مصحوباً بزغللة في العين أو غثيان، يرجى التوجه فوراً للطوارئ أو' +
    'استشارة طبيبك المعالج.',
  sender: SenderType.assistant,
  timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
  actionButtons: [ 'تسجيل قراءة الضغط الآن',
  'استشارة د. أحمد سمير',
  'تتبع الأعراض في السجل',
  ],
  isDisclaimer: true,
  ),
  ];
  void _sendMessage([String? customText]) {
    final text = customText ?? _textController.text.trim();
    if (text.isEmpty) return;
    final userMsg = ChatMessage( id: DateTime.now().millisecondsSinceEpoch.toString(),
    text: text,
    sender: SenderType.user,
    timestamp: DateTime.now(),
    );
    setState(() {
      _messages.add(userMsg);
      if (customText == null) _textController.clear();
      _isTyping = true;
    }
    );
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 2),
    () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add( ChatMessage( id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        text: 'تم استلام سؤالك وتحديث ملفك الصحي. يوصى بمراقبة الحالة خلال الساعتين' +
          'القادمتين وتسجيل أي مؤشرات حيوية جديدة.',
        sender: SenderType.assistant,
        timestamp: DateTime.now(),
        ),
        );
      }
      );
      _scrollToBottom();
    }
    );
  }
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo( _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        );
      }
    }
    );
  }
  @override Widget build(BuildContext context) {
    return Directionality( textDirection: TextDirection.rtl,
    child: Scaffold( appBar: _buildAppBar(),
    body: Column( children: [ _buildSafetyBanner(),
    Expanded( child: ListView.builder( controller: _scrollController,
    padding: const EdgeInsets.symmetric(horizontal: 16,
    vertical: 12),
    itemCount: _messages.length + (_isTyping ? 1 : 0),
    itemBuilder: (context,
    index) {
      if (index == _messages.length && _isTyping) {
        return _buildTypingIndicator();
      }
      final message = _messages[index];
      return _buildMessageBubble(message);
    }
    ,
    ),
    ),
    if (_messages.length <= 3) _buildSuggestedPromptsList(),
    _buildChatInputField(),
    ],
    ),
    ),
    );
  }
  PreferredSizeWidget _buildAppBar() {
    return AppBar( elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: false,
    leading: IconButton( icon: const Icon(Icons.arrow_forward_ios_rounded,
    color: Color(0xFF334155),
    size: 18),
    onPressed: () => Navigator.maybePop(context),
    ),
    title: Row( children: [ Stack( children: [ Container( width: 40,
    height: 40,
    decoration: BoxDecoration( gradient: const LinearGradient( colors: [Color(0xFF0D9488),
    Color(0xFF0284C7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.auto_awesome_rounded,
    color: Colors.white,
    size: 22),
    ),
    Positioned( bottom: 0,
    left: 0,
    child: Container( width: 11,
    height: 11,
    decoration: BoxDecoration( color: const Color(0xFF10B981),
    shape: BoxShape.circle,
    border: Border.all(color: Colors.white,
    width: 2),
    ),
    ),
    ),
    ],
    ),
    const SizedBox(width: 12),
    const Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text( 'مساعد شفاء الذكي',
    style: TextStyle( fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0F172A),
    ),
    ),
    Text( 'متصل ومطّلع على سجلك الطبي • AI Coach',
    style: TextStyle(fontSize: 11,
    color: Color(0xFF0D9488),
    fontWeight: FontWeight.w600),
    ),
    ],
    ),
    ],
    ),
    actions: [ IconButton( icon: const Icon(Icons.restart_alt_rounded,
    color: Color(0xFF64748B)),
    tooltip: 'محادثة جديدة',
    onPressed: () {
      setState(() {
        _messages.clear();
        _messages.add( ChatMessage( id: '0',
        text: 'أهلاً بك مجدداً! كيف يمكنني مساعدتك في استفساراتك الطبية الآن؟',
        sender: SenderType.assistant,
        timestamp: DateTime.now(),
        ),
        );
      }
      );
    }
    ,
    ),
    const SizedBox(width: 6),
    ],
    );
  }
  Widget _buildSafetyBanner() {
    return Container( width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14,
    vertical: 8),
    color: const Color(0xFFF0FDFA),
    child: const Row( children: [ Icon(Icons.shield_outlined,
    size: 16,
    color: Color(0xFF0D9488)),
    SizedBox(width: 8),
    Expanded( child: Text( 'المساعد يقدم إرشادات وتفسيرات تثقيفية ولا يُغني عن التشخيص الطبي المباشر.',
    style: TextStyle(fontSize: 11,
    color: Color(0xFF0F766E),
    fontWeight: FontWeight.w500),
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildMessageBubble(ChatMessage msg) {
    final isUser = msg.sender == SenderType.user;
    return Padding( padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row( mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ if (!isUser) ...[ Container( width: 32,
    height: 32,
    decoration: BoxDecoration( color: const Color(0xFFCCFBF1),
    borderRadius: BorderRadius.circular(10),
    ),
    child: const Icon(Icons.auto_awesome_rounded,
    color: Color(0xFF0D9488),
    size: 18),
    ),
    const SizedBox(width: 10),
    ],
    Flexible( child: Column( crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [ Container( padding: const EdgeInsets.all(14),
    decoration: BoxDecoration( color: isUser ? const Color(0xFF0D9488) : Colors.white,
    borderRadius: BorderRadius.only( topLeft: const Radius.circular(18),
    topRight: const Radius.circular(18),
    bottomLeft: Radius.circular(isUser ? 18 : 4),
    bottomRight: Radius.circular(isUser ? 4 : 18),
    ),
    boxShadow: [ BoxShadow( color: const Color(0xFF0F172A).withOpacity(0.04),
    blurRadius: 8,
    offset: const Offset(0,
    2),
    ),
    ],
    border: isUser ? null : Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Text( msg.text,
    style: TextStyle( fontSize: 13.5,
    height: 1.5,
    color: isUser ? Colors.white : const Color(0xFF1E293B),
    fontWeight: FontWeight.w500,
    ),
    ),
    ),
    if (msg.actionButtons != null && msg.actionButtons!.isNotEmpty) ...[ const SizedBox(height: 8),
    Wrap( spacing: 8,
    runSpacing: 6,
    children: msg.actionButtons!.map((btnText) {
      return InkWell( onTap: () {
        _sendMessage(btnText);
      }
      ,
      borderRadius: BorderRadius.circular(20),
      child: Container( padding: const EdgeInsets.symmetric(horizontal: 12,
      vertical: 6),
      decoration: BoxDecoration( color: const Color(0xFFF0FDFA),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFF99F6E4)),
      ),
      child: Row( mainAxisSize: MainAxisSize.min,
      children: [ const Icon(Icons.touch_app_outlined,
      size: 14,
      color: Color(0xFF0D9488)),
      const SizedBox(width: 4),
      Text( btnText,
      style: const TextStyle( fontSize: 11,
      fontWeight: FontWeight.bold,
      color: Color(0xFF0D9488),
      ),
      ),
      ],
      ),
      ),
      );
    }
    ).toList(),
    ),
    ],
    ],
    ),
    ),
    if (isUser) ...[ const SizedBox(width: 8),
    const CircleAvatar( radius: 16,
    backgroundColor: Color(0xFFE2E8F0),
    child: Icon(Icons.person,
    size: 20,
    color: Color(0xFF64748B)),
    ),
    ],
    ],
    ),
    );
  }
  Widget _buildTypingIndicator() {
    return Padding( padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row( children: [ Container( padding: const EdgeInsets.symmetric(horizontal: 16,
    vertical: 10),
    decoration: BoxDecoration( color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: const Row( mainAxisSize: MainAxisSize.min,
    children: [ SizedBox( width: 14,
    height: 14,
    child: CircularProgressIndicator(strokeWidth: 2,
    color: Color(0xFF0D9488)),
    ),
    SizedBox(width: 10),
    Text( 'شفاء AI يقوم بتحليل الاستفسار...',
    style: TextStyle(fontSize: 12,
    color: Color(0xFF64748B)),
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildSuggestedPromptsList() {
    return Container( height: 42,
    margin: const EdgeInsets.only(bottom: 8),
    child: ListView.separated( scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: _suggestedPrompts.length,
    separatorBuilder: (_,
    __) => const SizedBox(width: 8),
    itemBuilder: (context,
    index) {
      final prompt = _suggestedPrompts[index];
      return InkWell( onTap: () => _sendMessage(prompt),
      borderRadius: BorderRadius.circular(20),
      child: Container( padding: const EdgeInsets.symmetric(horizontal: 14,
      vertical: 8),
      decoration: BoxDecoration( color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: Row( children: [ const Icon(Icons.lightbulb_outline_rounded,
      size: 14,
      color: Color(0xFF0D9488)),
      const SizedBox(width: 6),
      Text( prompt,
      style: const TextStyle(fontSize: 12,
      color: Color(0xFF334155),
      fontWeight: FontWeight.w600),
      ),
      ],
      ),
      ),
      );
    }
    ,
    ),
    );
  }
  Widget _buildChatInputField() {
    return Container( padding: const EdgeInsets.symmetric(horizontal: 14,
    vertical: 10),
    decoration: BoxDecoration( color: Colors.white,
    border: const Border(top: BorderSide(color: Color(0xFFE2E8F0))),
    boxShadow: [ BoxShadow( color: const Color(0xFF0F172A).withOpacity(0.04),
    blurRadius: 10,
    offset: const Offset(0,
    -3),
    ),
    ],
    ),
    child: SafeArea( child: Row( children: [  IconButton( icon: const Icon(Icons.add_circle_outline_rounded,
    color: Color(0xFF0D9488),
    size: 24),
    tooltip: 'إرفاق فحص أو صورة روشتة',
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text('يمكنك إرفاق تحليل دم أو صورة أشعة ليقوم المساعد بقراءتها تلقائياً.'),
      duration: Duration(seconds: 2),
      ),
      );
    }
    ,
    ),
    Expanded( child: Container( padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration( color: const Color(0xFFF8FAFC),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: TextField( controller: _textController,
    textInputAction: TextInputAction.send,
    onSubmitted: (_) => _sendMessage(),
    style: const TextStyle(fontSize: 13,
    color: Color(0xFF0F172A)),
    decoration: const InputDecoration( hintText: 'اسأل عن أعراضك، أدويتك، أو تحاليلك...',
    hintStyle: TextStyle(fontSize: 12,
    color: Color(0xFF94A3B8)),
    border: InputBorder.none,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 12),
    ),
    ),
    ),
    ),
    const SizedBox(width: 8),
    _textController.text.isEmpty ? IconButton( icon: const Icon(Icons.mic_none_rounded,
    color: Color(0xFF0D9488),
    size: 24),
    tooltip: 'تسجيل صوتي',
    onPressed: () {
      _sendMessage('سؤال صوتي: ما هو أفضل موعد لتناول فيتامين د؟');
    }
    ,
    ) : Container( decoration: const BoxDecoration( shape: BoxShape.circle,
    color: Color(0xFF0D9488),
    ),
    child: IconButton( icon: const Icon(Icons.send_rounded,
    color: Colors.white,
    size: 18),
    tooltip: 'إرسال',
    onPressed: () => _sendMessage(),
    ),
    ),
    ],
    ),
    ),
    );
  }
}
class HealthInsightsScreen extends StatefulWidget {
  const HealthInsightsScreen( {
    super.key
  }
  );
  @override State<HealthInsightsScreen> createState() => _HealthInsightsScreenState();
}
class _HealthInsightsScreenState extends State<HealthInsightsScreen> {
  String _selectedPeriod = 'هذا الأسبوع';
  final List<String> _periods = ['هذا الأسبوع',
  'هذا الشهر',
  'آخر 3 أشهر'];
  final int _healthScore = 85;
  final double _medAdherence = 0.94;
  @override Widget build(BuildContext context) {
    return Directionality( textDirection: TextDirection.rtl,
    child: Scaffold( appBar: _buildAppBar(),
    body: SingleChildScrollView( padding: const EdgeInsets.symmetric(horizontal: 16.0,
    vertical: 12.0),
    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ _buildTimePeriodFilter(),
    const SizedBox(height: 16),
    _buildScoreHeroCard(),
    const SizedBox(height: 16),
    _buildAiSummaryInsightCard(),
    const SizedBox(height: 20),
    _buildSectionTitle('المؤشرات الحيوية الرئيسية',
    'مقارنة بالمعدلات المستهدفة'),
    const SizedBox(height: 12),
    _buildVitalsGrid(),
    const SizedBox(height: 20),
    _buildSectionTitle('توصيات ذكية مخصصة لك',
    'بناءً على تحليلات بياناتك الأخيرة'),
    const SizedBox(height: 12),
    _buildRecommendationsList(),
    const SizedBox(height: 24),
    _buildExportReportCard(),
    const SizedBox(height: 32),
    ],
    ),
    ),
    ),
    );
  }
  PreferredSizeWidget _buildAppBar() {
    return AppBar( elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: IconButton( icon: const Icon(Icons.arrow_forward_ios_rounded,
    color: Color(0xFF334155),
    size: 18),
    onPressed: () => Navigator.maybePop(context),
    ),
    title: const Text( 'التحليلات والرؤى الصحية',
    style: TextStyle( color: Color(0xFF0F172A),
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    actions: [ IconButton( icon: const Icon(Icons.share_outlined,
    color: Color(0xFF64748B)),
    tooltip: 'مشاركة التقرير',
    onPressed: () {
    }
    ,
    ),
    IconButton( icon: const Icon(Icons.info_outline_rounded,
    color: Color(0xFF64748B)),
    tooltip: 'كيف يُحسب المؤشر؟',
    onPressed: () {
    }
    ,
    ),
    const SizedBox(width: 6),
    ],
    );
  }
  Widget _buildTimePeriodFilter() {
    return Container( padding: const EdgeInsets.all(4),
    decoration: BoxDecoration( color: const Color(0xFFF1F5F9),
    borderRadius: BorderRadius.circular(14),
    ),
    child: Row( children: _periods.map((period) {
      final isSelected = _selectedPeriod == period;
      return Expanded( child: InkWell( borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() => _selectedPeriod = period);
      }
      ,
      child: AnimatedContainer( duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration( color: isSelected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      boxShadow: isSelected ? [ BoxShadow( color: const Color(0xFF0F172A).withOpacity(0.06),
      blurRadius: 6,
      offset: const Offset(0,
      2),
      ),
      ] : null,
      ),
      child: Text( period,
      style: TextStyle( fontSize: 12,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
      color: isSelected ? const Color(0xFF0D9488) : const Color(0xFF64748B),
      ),
      ),
      ),
      ),
      );
    }
    ).toList(),
    ),
    );
  }
  Widget _buildScoreHeroCard() {
    return Container( width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration( gradient: const LinearGradient( colors: [Color(0xFF0D9488),
    Color(0xFF0F766E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(22),
    boxShadow: [ BoxShadow( color: const Color(0xFF0D9488).withOpacity(0.25),
    blurRadius: 16,
    offset: const Offset(0,
    6),
    ),
    ],
    ),
    child: Row( children: [  Stack( alignment: Alignment.center,
    children: [ SizedBox( width: 82,
    height: 82,
    child: CircularProgressIndicator( value: _healthScore / 100,
    strokeWidth: 8,
    backgroundColor: Colors.white.withOpacity(0.2),
    color: Colors.white,
    strokeCap: StrokeCap.round,
    ),
    ),
    Column( mainAxisSize: MainAxisSize.min,
    children: [ Text( '$_healthScore',
    style: const TextStyle( color: Colors.white,
    fontSize: 26,
    fontWeight: FontWeight.bold,
    ),
    ),
    Text( 'من 100',
    style: TextStyle( color: Colors.white.withOpacity(0.8),
    fontSize: 10,
    fontWeight: FontWeight.w500,
    ),
    ),
    ],
    ),
    ],
    ),
    const SizedBox(width: 18),
    Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Container( padding: const EdgeInsets.symmetric(horizontal: 10,
    vertical: 4),
    decoration: BoxDecoration( color: Colors.white.withOpacity(0.18),
    borderRadius: BorderRadius.circular(20),
    ),
    child: const Row( mainAxisSize: MainAxisSize.min,
    children: [ Icon(Icons.trending_up_rounded,
    color: Colors.white,
    size: 14),
    SizedBox(width: 4),
    Text( 'أفضل بنسبة 5% عن الشهر الماضي',
    style: TextStyle( color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    const SizedBox(height: 8),
    const Text( 'مؤشر صحتك العام: ممتاز 🌟',
    style: TextStyle( color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 4),
    Text( 'التزامك بتناول الدواء ومعدلات المشي اليومية تعزز استقرار حالتك الصحية.',
    style: TextStyle( color: Colors.white.withOpacity(0.9),
    fontSize: 12,
    height: 1.4,
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildAiSummaryInsightCard() {
    return Container( padding: const EdgeInsets.all(18),
    decoration: BoxDecoration( color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: const Color(0xFFCCFBF1),
    width: 1.2),
    boxShadow: [ BoxShadow( color: const Color(0xFF0F172A).withOpacity(0.04),
    blurRadius: 10,
    offset: const Offset(0,
    3),
    ),
    ],
    ),
    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Row( children: [ Container( width: 36,
    height: 36,
    decoration: BoxDecoration( gradient: const LinearGradient( colors: [Color(0xFF0D9488),
    Color(0xFF0284C7)],
    ),
    borderRadius: BorderRadius.circular(10),
    ),
    child: const Icon(Icons.auto_awesome_rounded,
    color: Colors.white,
    size: 18),
    ),
    const SizedBox(width: 10),
    const Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text( 'ملخص الطبيب الذكي (شفاء AI)',
    style: TextStyle( fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0F172A),
    ),
    ),
    Text( 'تحليل مدمج من تحاليلك وأدويتك ومستشعراتك',
    style: TextStyle(fontSize: 11,
    color: Color(0xFF64748B)),
    ),
    ],
    ),
    ),
    Container( padding: const EdgeInsets.symmetric(horizontal: 8,
    vertical: 3),
    decoration: BoxDecoration( color: const Color(0xFFF0FDFA),
    borderRadius: BorderRadius.circular(8),
    ),
    child: const Text( 'محدث اليوم',
    style: TextStyle( fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0D9488),
    ),
    ),
    ),
    ],
    ),
    const SizedBox(height: 12),
    const Text( 'خلال الأيام الـ 7 الماضية، سُجل التزامك بجرعات دواء السكر بنسبة 94%،' +
      'مما حافظ على قراءات الجلوكوز ضمن النطاق الآمن (110 - 135' +
      'مجم/ديسيلتر). نوصي بالاستمرار على هذا النمط مع زيادة شرب الماء في' +
      'فترة الظهيرة.',
    style: TextStyle( fontSize: 12.5,
    color: Color(0xFF334155),
    height: 1.5,
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildSectionTitle(String title,
  String subtitle) {
    return Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text( title,
    style: const TextStyle( fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0F172A),
    ),
    ),
    const SizedBox(height: 2),
    Text( subtitle,
    style: const TextStyle(fontSize: 11,
    color: Color(0xFF64748B)),
    ),
    ],
    );
  }
  Widget _buildVitalsGrid() {
    return GridView.count( shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.15,
    children: [ _buildVitalCard( title: 'الالتزام بالدواء',
    value: '${(_medAdherence * 100).toInt()}%',
    status: 'ممتاز',
    statusColor: const Color(0xFF059669),
    statusBg: const Color(0xFFECFDF5),
    icon: Icons.medication_rounded,
    iconColor: const Color(0xFF0D9488),
    iconBg: const Color(0xFFCCFBF1),
    trend: '18 من 19 جرعة',
    ),
    _buildVitalCard( title: 'سكر الدم الصائم',
    value: '118 مجم',
    status: 'نطاق طبيعي',
    statusColor: const Color(0xFF059669),
    statusBg: const Color(0xFFECFDF5),
    icon: Icons.bloodtype_rounded,
    iconColor: const Color(0xFFDC2626),
    iconBg: const Color(0xFFFEE2E2),
    trend: 'المستهدف: < 125',
    ),
    _buildVitalCard( title: 'ضغط الدم',
    value: '122/80',
    status: 'مستقر ومثالي',
    statusColor: const Color(0xFF0284C7),
    statusBg: const Color(0xFFE0F2FE),
    icon: Icons.favorite_rounded,
    iconColor: const Color(0xFF0284C7),
    iconBg: const Color(0xFFE0F2FE),
    trend: 'آخر قراءة: أمس',
    ),
    _buildVitalCard( title: 'النشاط اليومي',
    value: '7,420 خطوة',
    status: 'نشط',
    statusColor: const Color(0xFFD97706),
    statusBg: const Color(0xFFFEF3C7),
    icon: Icons.directions_walk_rounded,
    iconColor: const Color(0xFFD97706),
    iconBg: const Color(0xFFFEF3C7),
    trend: 'الهدف: 8,000 خطوة',
    ),
    ],
    );
  }
  Widget _buildVitalCard( {
    required String title,
    required String value,
    required String status,
    required Color statusColor,
    required Color statusBg,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String trend,
  }
  ) {
    return Container( padding: const EdgeInsets.all(14),
    decoration: BoxDecoration( color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [ BoxShadow( color: const Color(0xFF0F172A).withOpacity(0.04),
    blurRadius: 8,
    offset: const Offset(0,
    2),
    ),
    ],
    ),
    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [ Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [ Container( width: 34,
    height: 34,
    decoration: BoxDecoration( color: iconBg,
    borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(icon,
    color: iconColor,
    size: 18),
    ),
    Container( padding: const EdgeInsets.symmetric(horizontal: 8,
    vertical: 3),
    decoration: BoxDecoration( color: statusBg,
    borderRadius: BorderRadius.circular(12),
    ),
    child: Text( status,
    style: TextStyle( fontSize: 10,
    fontWeight: FontWeight.bold,
    color: statusColor,
    ),
    ),
    ),
    ],
    ),
    Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text( value,
    style: const TextStyle( fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0F172A),
    ),
    ),
    const SizedBox(height: 2),
    Text( title,
    style: const TextStyle(fontSize: 11,
    color: Color(0xFF64748B)),
    ),
    ],
    ),
    Text( trend,
    style: const TextStyle(fontSize: 10,
    color: Color(0xFF94A3B8),
    fontWeight: FontWeight.w500),
    ),
    ],
    ),
    );
  }
  Widget _buildRecommendationsList() {
    return Column( children: [ _buildRecommendationItem( icon: Icons.water_drop_rounded,
    iconColor: const Color(0xFF0284C7),
    iconBg: const Color(0xFFE0F2FE),
    title: 'احرص على شرب لتر إضافي من الماء',
    subtitle: 'يساعدك ذلك على تحسين استقلاب دواء الضغط وتجنب الصداع الصباحي.',
    actionLabel: 'تسجيل كوب ماء',
    onAction: () {
    }
    ,
    ),
    const SizedBox(height: 10),
    _buildRecommendationItem( icon: Icons.calendar_month_rounded,
    iconColor: const Color(0xFF0D9488),
    iconBg: const Color(0xFFCCFBF1),
    title: 'موعد فحص السكر التراكمي (HbA1c) القادم',
    subtitle: 'مرت 3 أشهر منذ آخر فحص مسجل، يُستحسن تجديد الفحص قريباً.',
    actionLabel: 'حجز موعد معمل',
    onAction: () {
    }
    ,
    ),
    const SizedBox(height: 10),
    _buildRecommendationItem( icon: Icons.bedtime_rounded,
    iconColor: const Color(0xFF7C3AED),
    iconBg: const Color(0xFFEDE9FE),
    title: 'انتظام دورة النوم الليلي',
    subtitle: 'تحسين ساعات النوم إلى 7 ساعات يقلل من مقاومة الأنسولين بنسبة ملحوظة.',
    actionLabel: 'تتبع النوم',
    onAction: () {
    }
    ,
    ),
    ],
    );
  }
  Widget _buildRecommendationItem( {
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String actionLabel,
    required VoidCallback onAction,
  }
  ) {
    return Container( padding: const EdgeInsets.all(14),
    decoration: BoxDecoration( color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Row( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Container( width: 40,
    height: 40,
    decoration: BoxDecoration( color: iconBg,
    borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(icon,
    color: iconColor,
    size: 20),
    ),
    const SizedBox(width: 12),
    Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text( title,
    style: const TextStyle( fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0F172A),
    ),
    ),
    const SizedBox(height: 4),
    Text( subtitle,
    style: const TextStyle(fontSize: 11.5,
    color: Color(0xFF64748B),
    height: 1.3),
    ),
    const SizedBox(height: 8),
    InkWell( onTap: onAction,
    child: Row( mainAxisSize: MainAxisSize.min,
    children: [ Text( actionLabel,
    style: const TextStyle( fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0D9488),
    ),
    ),
    const SizedBox(width: 4),
    const Icon(Icons.arrow_back_ios_rounded,
    size: 10,
    color: Color(0xFF0D9488)),
    ],
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildExportReportCard() {
    return Container( padding: const EdgeInsets.all(16),
    decoration: BoxDecoration( color: const Color(0xFFF0FDFA),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: const Color(0xFF99F6E4)),
    ),
    child: Row( children: [ Container( padding: const EdgeInsets.all(10),
    decoration: BoxDecoration( color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.picture_as_pdf_rounded,
    color: Color(0xFF0D9488),
    size: 24),
    ),
    const SizedBox(width: 14),
    const Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text( 'تصدير التقرير الطبي الشامل',
    style: TextStyle( fontSize: 13.5,
    fontWeight: FontWeight.bold,
    color: Color(0xFF0F766E),
    ),
    ),
    SizedBox(height: 2),
    Text( 'ملخص PDF جاهز لتقديمه لطبيبك في الزيارة القادمة',
    style: TextStyle(fontSize: 11,
    color: Color(0xFF0D9488)),
    ),
    ],
    ),
    ),
    ElevatedButton( onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar( content: Text('جاري إنشاء وتحميل تقرير المؤشرات الصحية بصيغة PDF...'),
      backgroundColor: Color(0xFF0D9488),
      ),
      );
    }
    ,
    style: ElevatedButton.styleFrom( backgroundColor: const Color(0xFF0D9488),
    foregroundColor: Colors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 14,
    vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: const Text('تحميل',
    style: TextStyle(fontSize: 12,
    fontWeight: FontWeight.bold)),
    ),
    ],
    ),
    );
  }
}
