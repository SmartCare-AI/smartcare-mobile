import 'package:flutter/material.dart';
void main(
) => runApp(
const ShifaApp(
)
);
class ShifaApp extends StatelessWidget {
  const ShifaApp(
  {
    super.key
  }
  );
  @override Widget build(
  BuildContext context
  ) {
    return MaterialApp(
    title: 'Shifa - شفاء',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(
    0xFFF8FAFC
    ),
    fontFamily: 'Tajawal',
    colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(
    0xFF0D9488
    ),
    primary: const Color(
    0xFF0D9488
    ),
    secondary: const Color(
    0xFF0284C7
    ),
    surface: Colors.white,
    ),
    ),
    home: const MedicationsListScreen(
    ),
    );
  }
}
enum DoseTimeSlot {
  morning,
  afternoon,
  evening,
  bedtime
}
class MedicationItem {
  final String id;
  final String name;
  final String dosage;
  final String instruction;
  final String scheduledTime;
  final DoseTimeSlot slot;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  bool isTaken;
  MedicationItem(
  {
    required this.id,
    required this.name,
    required this.dosage,
    required this.instruction,
    required this.scheduledTime,
    required this.slot,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.isTaken = false,
  }
  );
}
class MedicationsListScreen extends StatefulWidget {
  const MedicationsListScreen(
  {
    super.key
  }
  );
  @override State<MedicationsListScreen> createState(
  ) => _MedicationsListScreenState(
  );
}
class _MedicationsListScreenState extends State<MedicationsListScreen> {
  int _selectedDayIndex = 2;
  String _selectedTab = 'اليوم';
  final List<Map<String,
  dynamic>> _weekDays = [ {
    'day': 'الأحد',
    'date': '12',
    'hasDoses': true
  },
  {
    'day': 'الإثنين',
    'date': '13',
    'hasDoses': true
  },
  {
    'day': 'الثلاثاء',
    'date': '14',
    'hasDoses': true,
    'isToday': true
  },
  {
    'day': 'الأربعاء',
    'date': '15',
    'hasDoses': true
  },
  {
    'day': 'الخميس',
    'date': '16',
    'hasDoses': true
  },
  {
    'day': 'الجمعة',
    'date': '17',
    'hasDoses': true
  },
  {
    'day': 'السبت',
    'date': '18',
    'hasDoses': true
  },
  ];
  final List<MedicationItem> _medications = [ MedicationItem(
  id: 'MED-1',
  name: 'ميتفورمين (Metformin)',
  dosage: '500 مجم • قرص واحد',
  instruction: 'بعد وجبة الإفطار مباشرة',
  scheduledTime: '08:00 ص',
  slot: DoseTimeSlot.morning,
  icon: Icons.medication_liquid_rounded,
  iconBgColor: const Color(
  0xFFCCFBF1
  ),
  iconColor: const Color(
  0xFF0D9488
  ),
  isTaken: true,
  ),
  MedicationItem(
  id: 'MED-2',
  name: 'فيتامين د3 (Vitamin D3)',
  dosage: '1000 وحدة • كبسولة واحدة',
  instruction: 'مع وجبة دسمة',
  scheduledTime: '08:30 ص',
  slot: DoseTimeSlot.morning,
  icon: Icons.shield_rounded,
  iconBgColor: const Color(
  0xFFFEF3C7
  ),
  iconColor: const Color(
  0xFFD97706
  ),
  isTaken: true,
  ),
  MedicationItem(
  id: 'MED-3',
  name: 'كونكور (Concor)',
  dosage: '5 مجم • قرص واحد',
  instruction: 'قبل وجبة الغداء بنصف ساعة',
  scheduledTime: '02:00 م',
  slot: DoseTimeSlot.afternoon,
  icon: Icons.favorite_rounded,
  iconBgColor: const Color(
  0xFFFEE2E2
  ),
  iconColor: const Color(
  0xFFDC2626
  ),
  isTaken: false,
  ),
  MedicationItem(
  id: 'MED-4',
  name: 'أوميجا 3 (Omega 3 Fish Oil)',
  dosage: '1000 مجم • كبسولة واحدة',
  instruction: 'بعد الغداء',
  scheduledTime: '02:30 م',
  slot: DoseTimeSlot.afternoon,
  icon: Icons.water_drop_rounded,
  iconBgColor: const Color(
  0xFFE0F2FE
  ),
  iconColor: const Color(
  0xFF0284C7
  ),
  isTaken: false,
  ),
  MedicationItem(
  id: 'MED-5',
  name: 'أتورفاستاتين (Atorvastatin)',
  dosage: '20 مجم • قرص واحد',
  instruction: 'قبل النوم',
  scheduledTime: '10:00 م',
  slot: DoseTimeSlot.bedtime,
  icon: Icons.bedtime_rounded,
  iconBgColor: const Color(
  0xFFEDE9FE
  ),
  iconColor: const Color(
  0xFF7C3AED
  ),
  isTaken: false,
  ),
  ];
  int get _takenCount => _medications.where(
  (
  m
  ) => m.isTaken
  ).length;
  int get _totalCount => _medications.length;
  double get _adherenceRatio => _totalCount == 0 ? 0.0 : _takenCount / _totalCount;
  @override Widget build(
  BuildContext context
  ) {
    return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
    appBar: _buildAppBar(
    ),
    body: SingleChildScrollView(
    padding: const EdgeInsets.only(
    bottom: 96
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ _buildViewTabs(
    ),
    _buildWeekCalendarStrip(
    ),
    _buildAdherenceSummaryCard(
    ),
    const SizedBox(
    height: 16
    ),
    _buildSlotGroup(
    title: 'جرعات الصباح',
    timeRange: '06:00 ص - 11:59 ص',
    icon: Icons.wb_sunny_rounded,
    iconColor: const Color(
    0xFFF59E0B
    ),
    slot: DoseTimeSlot.morning,
    ),
    _buildSlotGroup(
    title: 'جرعات الظهيرة والعصر',
    timeRange: '12:00 م - 05:59 م',
    icon: Icons.wb_twilight_rounded,
    iconColor: const Color(
    0xFF0284C7
    ),
    slot: DoseTimeSlot.afternoon,
    ),
    _buildSlotGroup(
    title: 'جرعات المساء وقبل النوم',
    timeRange: '09:00 م - 11:59 م',
    icon: Icons.nightlight_round,
    iconColor: const Color(
    0xFF7C3AED
    ),
    slot: DoseTimeSlot.bedtime,
    ),
    ],
    ),
    ),
    floatingActionButton: _buildAddMedicationFab(
    ),
    ),
    );
  }
  PreferredSizeWidget _buildAppBar(
  ) {
    return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: false,
    title: const Text(
    'جدول الأدوية والجرعات',
    style: TextStyle(
    color: Color(
    0xFF0F172A
    ),
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    actions: [ IconButton(
    icon: const Icon(
    Icons.history_rounded,
    color: Color(
    0xFF64748B
    )
    ),
    tooltip: 'سجل الالتزام الدوائي',
    onPressed: (
    ) {
    },
    ),
    IconButton(
    icon: const Icon(
    Icons.notifications_active_outlined,
    color: Color(
    0xFF64748B
    )
    ),
    tooltip: 'تنبيهات الجرعات',
    onPressed: (
    ) {
    },
    ),
    const SizedBox(
    width: 8
    ),
    ],
    );
  }
  Widget _buildViewTabs(
  ) {
    return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8
    ),
    child: Row(
    children: [ _buildTogglePill(
    'جدول اليوم',
    isSelected: _selectedTab == 'اليوم',
    onTap: (
    ) {
      setState(
      (
      ) => _selectedTab = 'اليوم'
      );
    }
    ),
    const SizedBox(
    width: 8
    ),
    _buildTogglePill(
    'جميع أدويتي (خزانة الأدوية)',
    isSelected: _selectedTab == 'الكل',
    onTap: (
    ) {
      setState(
      (
      ) => _selectedTab = 'الكل'
      );
    }
    ),
    ],
    ),
    );
  }
  Widget _buildTogglePill(
  String title,
  {
    required bool isSelected,
    required VoidCallback onTap
  }
  ) {
    return Expanded(
    child: InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(
    12
    ),
    child: AnimatedContainer(
    duration: const Duration(
    milliseconds: 200
    ),
    padding: const EdgeInsets.symmetric(
    vertical: 10
    ),
    alignment: Alignment.center,
    decoration: BoxDecoration(
    color: isSelected ? const Color(
    0xFF0D9488
    ) : const Color(
    0xFFF1F5F9
    ),
    borderRadius: BorderRadius.circular(
    12
    ),
    ),
    child: Text(
    title,
    style: TextStyle(
    fontSize: 13,
    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
    color: isSelected ? Colors.white : const Color(
    0xFF475569
    ),
    ),
    ),
    ),
    ),
    );
  }
  Widget _buildWeekCalendarStrip(
  ) {
    return Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(
    16,
    6,
    16,
    14
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
    _weekDays.length,
    (
    index
    ) {
      final item = _weekDays[index];
        final isSelected = _selectedDayIndex == index;
        final isToday = item['isToday'] == true;
        return InkWell(
      borderRadius: BorderRadius.circular(
      16
      ),
      onTap: (
      ) {
        setState(
        (
        ) {
          _selectedDayIndex = index;
        }
        );
      },
      child: AnimatedContainer(
      duration: const Duration(
      milliseconds: 200
      ),
      width: 44,
      padding: const EdgeInsets.symmetric(
      vertical: 10
      ),
      decoration: BoxDecoration(
      color: isSelected ? const Color(
      0xFF0D9488
      ) : isToday ? const Color(
      0xFFF0FDFA
      ) : Colors.transparent,
      borderRadius: BorderRadius.circular(
      16
      ),
      border: Border.all(
      color: isSelected ? const Color(
      0xFF0D9488
      ) : isToday ? const Color(
      0xFF99F6E4
      ) : const Color(
      0xFFE2E8F0
      ),
      ),
      ),
      child: Column(
      children: [ Text(
      item['day'] as String,
      style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: isSelected ? Colors.white.withOpacity(
      0.9
      ) : const Color(
      0xFF64748B
      ),
      ),
      ),
      const SizedBox(
      height: 6
      ),
      Text(
      item['date'] as String,
      style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: isSelected ? Colors.white : const Color(
      0xFF0F172A
      ),
      ),
      ),
      const SizedBox(
      height: 6
      ),
      Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isSelected ? Colors.white : const Color(
      0xFF0D9488
      ),
      ),
      ),
      ],
      ),
      ),
      );
    }
    ),
    ),
    );
  }
  Widget _buildAdherenceSummaryCard(
  ) {
    final percentInt = (
    _adherenceRatio * 100
    ).toInt(
    );
    return Container(
    margin: const EdgeInsets.fromLTRB(
    16,
    14,
    16,
    6
    ),
    padding: const EdgeInsets.all(
    16
    ),
    decoration: BoxDecoration(
    gradient: const LinearGradient(
    colors: [Color(
    0xFFF0FDFA
    ),
    Color(
    0xFFE0F2FE
    )],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    ),
    borderRadius: BorderRadius.circular(
    20
    ),
    border: Border.all(
    color: const Color(
    0xFF99F6E4
    )
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0D9488
    ).withOpacity(
    0.06
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: Row(
    children: [ Stack(
    alignment: Alignment.center,
    children: [ SizedBox(
    width: 60,
    height: 60,
    child: CircularProgressIndicator(
    value: _adherenceRatio,
    strokeWidth: 6,
    backgroundColor: const Color(
    0xFFCCFBF1
    ),
    color: const Color(
    0xFF0D9488
    ),
    strokeCap: StrokeCap.round,
    ),
    ),
    Text(
    '$percentInt%',
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Color(
    0xFF0F172A
    ),
    ),
    ),
    ],
    ),
    const SizedBox(
    width: 16
    ),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Row(
    children: [ const Text(
    'نسبة الالتزام اليوم',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Color(
    0xFF0F172A
    ),
    ),
    ),
    const SizedBox(
    width: 6
    ),
    Container(
    padding: const EdgeInsets.symmetric(
    horizontal: 6,
    vertical: 2
    ),
    decoration: BoxDecoration(
    color: const Color(
    0xFF0D9488
    ),
    borderRadius: BorderRadius.circular(
    8
    ),
    ),
    child: Text(
    '$_takenCount من $_totalCount جرعات',
    style: const TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ],
    ),
    const SizedBox(
    height: 4
    ),
    Text(
    _takenCount == _totalCount
          ? 'أحسنت! أتممت جميع جرعاتك المحددة لهذا اليوم 🌟'
          : 'متبقي لديك ${_totalCount - _takenCount} جرعات لتناولها اليوم.',
    style: const TextStyle(
    fontSize: 12,
    color: Color(
    0xFF475569
    ),
    height: 1.3
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildSlotGroup(
  {
    required String title,
    required String timeRange,
    required IconData icon,
    required Color iconColor,
    required DoseTimeSlot slot,
  }
  ) {
    final items = _medications.where(
    (
    m
    ) => m.slot == slot
    ).toList(
    );
    if (
    items.isEmpty
    ) return const SizedBox.shrink(
    );
    return Padding(
    padding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 10
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Row(
    children: [ Icon(
    icon,
    size: 18,
    color: iconColor
    ),
    const SizedBox(
    width: 8
    ),
    Text(
    title,
    style: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0F172A
    ),
    ),
    ),
    const SizedBox(
    width: 8
    ),
    Text(
    timeRange,
    style: const TextStyle(
    fontSize: 11,
    color: Color(
    0xFF94A3B8
    )
    ),
    ),
    ],
    ),
    const SizedBox(
    height: 10
    ),
    ...items.map(
    (
    item
    ) => _buildMedicationCard(
    item
    )
    ).toList(
    ),
    ],
    ),
    );
  }
  Widget _buildMedicationCard(
  MedicationItem med
  ) {
    return Container(
    margin: const EdgeInsets.only(
    bottom: 12
    ),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
    18
    ),
    border: Border.all(
    color: med.isTaken ? const Color(
    0xFFA7F3D0
    ) : const Color(
    0xFFE2E8F0
    ),
    width: med.isTaken ? 1.4 : 1.0,
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0F172A
    ).withOpacity(
    0.04
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: InkWell(
    borderRadius: BorderRadius.circular(
    18
    ),
    onTap: (
    ) {
    },
    child: Padding(
    padding: const EdgeInsets.all(
    14
    ),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [ Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
    color: med.iconBgColor,
    borderRadius: BorderRadius.circular(
    14
    ),
    ),
    child: Icon(
    med.icon,
    color: med.iconColor,
    size: 24
    ),
    ),
    const SizedBox(
    width: 14
    ),
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text(
    med.name,
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: med.isTaken ? const Color(
    0xFF64748B
    ) : const Color(
    0xFF0F172A
    ),
    decoration: med.isTaken ? TextDecoration.lineThrough : null,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    ),
    const SizedBox(
    height: 4
    ),
    Text(
    med.dosage,
    style: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Color(
    0xFF0D9488
    ),
    ),
    ),
    const SizedBox(
    height: 4
    ),
    Row(
    children: [ const Icon(
    Icons.info_outline_rounded,
    size: 12,
    color: Color(
    0xFF94A3B8
    )
    ),
    const SizedBox(
    width: 4
    ),
    Text(
    med.instruction,
    style: const TextStyle(
    fontSize: 11,
    color: Color(
    0xFF64748B
    )
    ),
    ),
    const SizedBox(
    width: 8
    ),
    Text(
    '• ${med.scheduledTime}',
    style: const TextStyle(
    fontSize: 11,
    color: Color(
    0xFF94A3B8
    ),
    fontWeight: FontWeight.w500
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    const SizedBox(
    width: 8
    ),
    InkWell(
    borderRadius: BorderRadius.circular(
    12
    ),
    onTap: (
    ) {
      setState(
      (
      ) {
        med.isTaken = !med.isTaken;
      }
      );
    },
    child: AnimatedContainer(
    duration: const Duration(
    milliseconds: 200
    ),
    padding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8
    ),
    decoration: BoxDecoration(
    color: med.isTaken ? const Color(
    0xFFECFDF5
    ) : const Color(
    0xFFF0FDFA
    ),
    borderRadius: BorderRadius.circular(
    12
    ),
    border: Border.all(
    color: med.isTaken ? const Color(
    0xFF059669
    ) : const Color(
    0xFF0D9488
    ),
    ),
    ),
    child: Row(
    children: [ Icon(
    med.isTaken
          ? Icons.check_circle_rounded
          : Icons.radio_button_unchecked_rounded,
    size: 16,
    color: med.isTaken ? const Color(
    0xFF059669
    ) : const Color(
    0xFF0D9488
    ),
    ),
    const SizedBox(
    width: 6
    ),
    Text(
    med.isTaken ? 'تم الأخذ' : 'تناول الآن',
    style: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: med.isTaken ? const Color(
    0xFF059669
    ) : const Color(
    0xFF0D9488
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    );
  }
  Widget _buildAddMedicationFab(
  ) {
    return Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
    30
    ),
    gradient: const LinearGradient(
    colors: [Color(
    0xFF0D9488
    ),
    Color(
    0xFF059669
    )],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0D9488
    ).withOpacity(
    0.35
    ),
    blurRadius: 16,
    offset: const Offset(
    0,
    6
    ),
    ),
    ],
    ),
    child: FloatingActionButton.extended(
    elevation: 0,
    backgroundColor: Colors.transparent,
    onPressed: (
    ) {
      Navigator.of(
      context
      ).push(
      MaterialPageRoute<void>(
      builder: (
      _
      ) => const AddMedicationScreen(
      )
      ),
      );
    },
    icon: const Icon(
    Icons.add_rounded,
    color: Colors.white,
    size: 22
    ),
    label: const Text(
    'إضافة دواء جديد',
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    ),
    ),
    ),
    );
  }
}
enum MedicationFormType {
  pill,
  capsule,
  syrup,
  injection,
  drops,
  inhaler
}
enum MealRelation {
  afterMeal,
  beforeMeal,
  withFood,
  emptyStomach,
  bedtime
}
class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen(
  {
    super.key
  }
  );
  @override State<AddMedicationScreen> createState(
  ) => _AddMedicationScreenState(
  );
}
class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final TextEditingController _nameController = TextEditingController(
  );
  final TextEditingController _strengthController = TextEditingController(
  );
  final TextEditingController _totalCountController = TextEditingController(
  text: '30'
  );
  final TextEditingController _refillThresholdController = TextEditingController(
  text: '5'
  );
  final TextEditingController _notesController = TextEditingController(
  );
  MedicationFormType _selectedForm = MedicationFormType.pill;
  MealRelation _selectedMealRelation = MealRelation.afterMeal;
  String _selectedFrequency = 'مرة واحدة يومياً';
  final List<String> _frequencies = [ 'مرة واحدة يومياً',
  'مرتان يومياً',
  '3 مرات يومياً',
  'كل 8 ساعات',
  'عند اللزوم / الحاجة',
  'أيام محددة في الأسبوع',
  ];
  List<TimeOfDay> _reminderTimes = [ const TimeOfDay(
  hour: 8,
  minute: 0
  ),
  ];
  bool _enableRefillAlert = true;
  @override void dispose(
  ) {
    _nameController.dispose(
    );
    _strengthController.dispose(
    );
    _totalCountController.dispose(
    );
    _refillThresholdController.dispose(
    );
    _notesController.dispose(
    );
    super.dispose(
    );
  }
  void _addReminderTime(
  ) async {
    final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: const TimeOfDay(
    hour: 14,
    minute: 0
    ),
    builder: (
    context,
    child
    ) {
      return Theme(
      data: Theme.of(
      context
      ).copyWith(
      colorScheme: const ColorScheme.light(
      primary: Color(
      0xFF0D9488
      ),
      onPrimary: Colors.white,
      onSurface: Color(
      0xFF0F172A
      ),
      ),
      ),
      child: child!,
      );
    },
    );
    if (
    picked != null && !_reminderTimes.contains(
    picked
    )
    ) {
      setState(
      (
      ) {
        _reminderTimes.add(
        picked
        );
      }
      );
    }
  }
  void _removeReminderTime(
  int index
  ) {
    if (
    _reminderTimes.length > 1
    ) {
      setState(
      (
      ) {
        _reminderTimes.removeAt(
        index
        );
      }
      );
    }
  }
  @override Widget build(
  BuildContext context
  ) {
    return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
    appBar: _buildAppBar(
    context
    ),
    body: SingleChildScrollView(
    padding: const EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ _buildBasicInfoSection(
    ),
    const SizedBox(
    height: 18
    ),
    _buildMedicationFormSelector(
    ),
    const SizedBox(
    height: 18
    ),
    _buildScheduleAndDosageSection(
    ),
    const SizedBox(
    height: 18
    ),
    _buildMealRelationSection(
    ),
    const SizedBox(
    height: 18
    ),
    _buildInventoryAndRefillSection(
    ),
    const SizedBox(
    height: 18
    ),
    _buildNotesSection(
    ),
    const SizedBox(
    height: 32
    ),
    _buildActionButtons(
    ),
    const SizedBox(
    height: 24
    ),
    ],
    ),
    ),
    ),
    );
  }
  PreferredSizeWidget _buildAppBar(
  BuildContext context
  ) {
    return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: IconButton(
    icon: const Icon(
    Icons.close_rounded,
    color: Color(
    0xFF334155
    ),
    size: 22
    ),
    onPressed: (
    ) => Navigator.maybePop(
    context
    ),
    ),
    title: const Text(
    'إضافة دواء جديد',
    style: TextStyle(
    color: Color(
    0xFF0F172A
    ),
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    actions: [ TextButton(
    onPressed: (
    ) {
    },
    child: const Row(
    children: [ Icon(
    Icons.qr_code_scanner_rounded,
    size: 18,
    color: Color(
    0xFF0D9488
    )
    ),
    SizedBox(
    width: 4
    ),
    Text(
    'مسح الباركود',
    style: TextStyle(
    color: Color(
    0xFF0D9488
    ),
    fontSize: 12,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    const SizedBox(
    width: 8
    ),
    ],
    );
  }
  Widget _buildBasicInfoSection(
  ) {
    return Container(
    padding: const EdgeInsets.all(
    16
    ),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
    18
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0F172A
    ).withOpacity(
    0.04
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ const Text(
    'معلومات الدواء الأساسية',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0F172A
    )
    ),
    ),
    const SizedBox(
    height: 12
    ),
    _buildInputField(
    label: 'اسم الدواء (تجاري أو علمي)',
    controller: _nameController,
    hint: 'مثال: أوجمنتين أو ميتفورمين',
    icon: Icons.medication_rounded,
    ),
    const SizedBox(
    height: 14
    ),
    _buildInputField(
    label: 'التركيز / القوة (اختياري)',
    controller: _strengthController,
    hint: 'مثال: 500 مجم أو 10 مل',
    icon: Icons.science_outlined,
    ),
    ],
    ),
    );
  }
  Widget _buildMedicationFormSelector(
  ) {
    final forms = [ {
      'type': MedicationFormType.pill,
      'label': 'أقراص / حبوب',
      'icon': Icons.circle_outlined
    },
    {
      'type': MedicationFormType.capsule,
      'label': 'كبسولات',
      'icon': Icons.medication_rounded
    },
    {
      'type': MedicationFormType.syrup,
      'label': 'شراب / سائل',
      'icon': Icons.local_drink_rounded
    },
    {
      'type': MedicationFormType.injection,
      'label': 'حقن',
      'icon': Icons.vaccines_rounded
    },
    {
      'type': MedicationFormType.drops,
      'label': 'قطرات',
      'icon': Icons.water_drop_rounded
    },
    {
      'type': MedicationFormType.inhaler,
      'label': 'بخاخ',
      'icon': Icons.air_rounded
    },
    ];
    return Container(
    padding: const EdgeInsets.all(
    16
    ),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
    18
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0F172A
    ).withOpacity(
    0.04
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ const Text(
    'شكل الجرعة',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0F172A
    )
    ),
    ),
    const SizedBox(
    height: 12
    ),
    GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(
    ),
    itemCount: forms.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 1.1,
    ),
    itemBuilder: (
    context,
    index
    ) {
      final form = forms[index];
        final isSelected = _selectedForm == form['type'];
        return InkWell(
      borderRadius: BorderRadius.circular(
      14
      ),
      onTap: (
      ) {
        setState(
        (
        ) {
          _selectedForm = form['type'] as MedicationFormType;
        }
        );
      },
      child: AnimatedContainer(
      duration: const Duration(
      milliseconds: 200
      ),
      padding: const EdgeInsets.all(
      8
      ),
      decoration: BoxDecoration(
      color: isSelected ? const Color(
      0xFFF0FDFA
      ) : const Color(
      0xFFF8FAFC
      ),
      borderRadius: BorderRadius.circular(
      14
      ),
      border: Border.all(
      color: isSelected ? const Color(
      0xFF0D9488
      ) : const Color(
      0xFFE2E8F0
      ),
      width: isSelected ? 1.6 : 1.0,
      ),
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [ Icon(
      form['icon'] as IconData,
      color: isSelected ? const Color(
      0xFF0D9488
      ) : const Color(
      0xFF64748B
      ),
      size: 24,
      ),
      const SizedBox(
      height: 6
      ),
      Text(
      form['label'] as String,
      style: TextStyle(
      fontSize: 11,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      color: isSelected ? const Color(
      0xFF0D9488
      ) : const Color(
      0xFF334155
      ),
      ),
      textAlign: TextAlign.center,
      ),
      ],
      ),
      ),
      );
    },
    ),
    ],
    ),
    );
  }
  Widget _buildScheduleAndDosageSection(
  ) {
    return Container(
    padding: const EdgeInsets.all(
    16
    ),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
    18
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0F172A
    ).withOpacity(
    0.04
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ const Text(
    'الجدول الزمني والتكرار',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0F172A
    )
    ),
    ),
    const SizedBox(
    height: 12
    ),
    const Text(
    'معدل التكرار',
    style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF475569
    )
    ),
    ),
    const SizedBox(
    height: 6
    ),
    Container(
    padding: const EdgeInsets.symmetric(
    horizontal: 14
    ),
    decoration: BoxDecoration(
    color: const Color(
    0xFFF8FAFC
    ),
    borderRadius: BorderRadius.circular(
    12
    ),
    border: Border.all(
    color: const Color(
    0xFFE2E8F0
    )
    ),
    ),
    child: DropdownButtonHideUnderline(
    child: DropdownButton<String>(
    value: _selectedFrequency,
    isExpanded: true,
    icon: const Icon(
    Icons.keyboard_arrow_down_rounded,
    color: Color(
    0xFF0D9488
    )
    ),
    items: _frequencies.map(
    (
    freq
    ) {
      return DropdownMenuItem(
      value: freq,
      child: Text(
      freq,
      style: const TextStyle(
      fontSize: 13,
      color: Color(
      0xFF0F172A
      )
      )
      ),
      );
    }
    ).toList(
    ),
    onChanged: (
    val
    ) {
      if (
      val != null
      ) setState(
      (
      ) => _selectedFrequency = val
      );
    },
    ),
    ),
    ),
    const SizedBox(
    height: 16
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [ const Text(
    'مواعيد التنبيه اليومية',
    style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF475569
    )
    ),
    ),
    InkWell(
    onTap: _addReminderTime,
    borderRadius: BorderRadius.circular(
    8
    ),
    child: const Padding(
    padding: EdgeInsets.symmetric(
    horizontal: 6,
    vertical: 2
    ),
    child: Row(
    children: [ Icon(
    Icons.add_circle_outline_rounded,
    size: 16,
    color: Color(
    0xFF0D9488
    )
    ),
    SizedBox(
    width: 4
    ),
    Text(
    'إضافة وقت آخر',
    style: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0D9488
    )
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    const SizedBox(
    height: 8
    ),
    Wrap(
    spacing: 8,
    runSpacing: 8,
    children: List.generate(
    _reminderTimes.length,
    (
    index
    ) {
      final time = _reminderTimes[index]; final formattedTime = time.format(
      context
      ); return Container(
      padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8
      ),
      decoration: BoxDecoration(
      color: const Color(
      0xFFF0FDFA
      ),
      borderRadius: BorderRadius.circular(
      12
      ),
      border: Border.all(
      color: const Color(
      0xFF99F6E4
      )
      ),
      ),
      child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [ const Icon(
      Icons.access_time_filled_rounded,
      size: 16,
      color: Color(
      0xFF0D9488
      )
      ),
      const SizedBox(
      width: 6
      ),
      Text(
      formattedTime,
      style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Color(
      0xFF0F172A
      )
      ),
      ),
      if (
      _reminderTimes.length > 1
      ) ...[ const SizedBox(
      width: 6
      ),
      InkWell(
      onTap: (
      ) => _removeReminderTime(
      index
      ),
      child: const Icon(
      Icons.cancel_rounded,
      size: 16,
      color: Color(
      0xFF94A3B8
      )
      ),
      ),
      ],
      ],
      ),
      );
    }
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildMealRelationSection(
  ) {
    final options = [ {
      'type': MealRelation.afterMeal,
      'label': 'بعد الأكل مباشرة'
    },
    {
      'type': MealRelation.beforeMeal,
      'label': 'قبل الأكل بنصف ساعة'
    },
    {
      'type': MealRelation.withFood,
      'label': 'مع وجبة الطعام'
    },
    {
      'type': MealRelation.bedtime,
      'label': 'قبل النوم'
    },
    {
      'type': MealRelation.emptyStomach,
      'label': 'على الريق (معدة فارغة)'
    },
    ];
    return Container(
    padding: const EdgeInsets.all(
    16
    ),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
    18
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0F172A
    ).withOpacity(
    0.04
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ const Text(
    'تعليمات تناول الجرعة بالنسبة للوجبات',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0F172A
    )
    ),
    ),
    const SizedBox(
    height: 10
    ),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    children: options.map(
    (
    opt
    ) {
      final isSelected = _selectedMealRelation == opt['type']; return Padding(
      padding: const EdgeInsets.only(
      left: 8.0
      ),
      child: InkWell(
      borderRadius: BorderRadius.circular(
      20
      ),
      onTap: (
      ) {
        setState(
        (
        ) {
          _selectedMealRelation = opt['type'] as MealRelation;
        }
        );
      },
      child: AnimatedContainer(
      duration: const Duration(
      milliseconds: 200
      ),
      padding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 8
      ),
      decoration: BoxDecoration(
      color: isSelected ? const Color(
      0xFF0D9488
      ) : const Color(
      0xFFF1F5F9
      ),
      borderRadius: BorderRadius.circular(
      20
      ),
      border: Border.all(
      color: isSelected ? const Color(
      0xFF0D9488
      ) : Colors.transparent,
      ),
      ),
      child: Text(
      opt['label'] as String,
      style: TextStyle(
      fontSize: 12,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      color: isSelected ? Colors.white : const Color(
      0xFF475569
      ),
      ),
      ),
      ),
      ),
      );
    }
    ).toList(
    ),
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildInventoryAndRefillSection(
  ) {
    return Container(
    padding: const EdgeInsets.all(
    16
    ),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
    18
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0F172A
    ).withOpacity(
    0.04
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [ const Text(
    'تتبع المخزون وتنبيه إعادة الشراء',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0F172A
    )
    ),
    ),
    Switch(
    value: _enableRefillAlert,
    activeColor: const Color(
    0xFF0D9488
    ),
    onChanged: (
    val
    ) {
      setState(
      (
      ) => _enableRefillAlert = val
      );
    },
    ),
    ],
    ),
    if (
    _enableRefillAlert
    ) ...[ const SizedBox(
    height: 12
    ),
    Row(
    children: [ Expanded(
    child: _buildInputField(
    label: 'الكمية المتوفرة حالياً',
    controller: _totalCountController,
    hint: '30 قرص',
    icon: Icons.inventory_2_outlined,
    keyboardType: TextInputType.number,
    ),
    ),
    const SizedBox(
    width: 12
    ),
    Expanded(
    child: _buildInputField(
    label: 'نبّهني عند تبقي',
    controller: _refillThresholdController,
    hint: '5 أقراص',
    icon: Icons.notification_important_outlined,
    keyboardType: TextInputType.number,
    ),
    ),
    ],
    ),
    ],
    ],
    ),
    );
  }
  Widget _buildNotesSection(
  ) {
    return Container(
    padding: const EdgeInsets.all(
    16
    ),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
    18
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0F172A
    ).withOpacity(
    0.04
    ),
    blurRadius: 10,
    offset: const Offset(
    0,
    3
    ),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ const Text(
    'ملاحظات وتوجيهات الطبيب (اختياري)',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF0F172A
    )
    ),
    ),
    const SizedBox(
    height: 10
    ),
    Container(
    decoration: BoxDecoration(
    color: const Color(
    0xFFF8FAFC
    ),
    borderRadius: BorderRadius.circular(
    12
    ),
    border: Border.all(
    color: const Color(
    0xFFE2E8F0
    )
    ),
    ),
    child: TextField(
    controller: _notesController,
    maxLines: 3,
    style: const TextStyle(
    fontSize: 13,
    color: Color(
    0xFF0F172A
    )
    ),
    decoration: const InputDecoration(
    hintText: 'اكتب أي تحذيرات أو تفاصيل خاصة بمدة الكورس العلاجي...',
    hintStyle: TextStyle(
    fontSize: 12,
    color: Color(
    0xFF94A3B8
    )
    ),
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(
    14
    ),
    ),
    ),
    ),
    ],
    ),
    );
  }
  Widget _buildInputField(
  {
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }
  ) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [ Text(
    label,
    style: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Color(
    0xFF475569
    )
    ),
    ),
    const SizedBox(
    height: 6
    ),
    Container(
    decoration: BoxDecoration(
    color: const Color(
    0xFFF8FAFC
    ),
    borderRadius: BorderRadius.circular(
    12
    ),
    border: Border.all(
    color: const Color(
    0xFFE2E8F0
    )
    ),
    ),
    child: TextField(
    controller: controller,
    keyboardType: keyboardType,
    style: const TextStyle(
    fontSize: 13,
    color: Color(
    0xFF0F172A
    ),
    fontWeight: FontWeight.w500
    ),
    decoration: InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
    fontSize: 12,
    color: Color(
    0xFF94A3B8
    )
    ),
    prefixIcon: Icon(
    icon,
    color: const Color(
    0xFF0D9488
    ),
    size: 18
    ),
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 12
    ),
    ),
    ),
    ),
    ],
    );
  }
  Widget _buildActionButtons(
  ) {
    return Column(
    children: [ Container(
    width: double.infinity,
    height: 52,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
    14
    ),
    gradient: const LinearGradient(
    colors: [Color(
    0xFF0D9488
    ),
    Color(
    0xFF059669
    )],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    ),
    boxShadow: [ BoxShadow(
    color: const Color(
    0xFF0D9488
    ).withOpacity(
    0.32
    ),
    blurRadius: 14,
    offset: const Offset(
    0,
    5
    ),
    ),
    ],
    ),
    child: ElevatedButton(
    onPressed: (
    ) {
      ScaffoldMessenger.of(
      context
      ).showSnackBar(
      const SnackBar(
      content: Text(
      'تمت إضافة الدواء بنجاح وضبط المواعيد والتنبيهات'
      ),
      backgroundColor: Color(
      0xFF0D9488
      ),
      ),
      ); Navigator.maybePop(
      context
      );
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
    14
    )
    ),
    ),
    child: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Icon(
    Icons.check_rounded,
    color: Colors.white,
    size: 20
    ),
    SizedBox(
    width: 8
    ),
    Text(
    'حفظ الدواء وتفعيل التنبيهات',
    style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white
    ),
    ),
    ],
    ),
    ),
    ),
    const SizedBox(
    height: 12
    ),
    SizedBox(
    width: double.infinity,
    height: 48,
    child: TextButton(
    onPressed: (
    ) => Navigator.maybePop(
    context
    ),
    child: const Text(
    'إلغاء والعودة',
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Color(
    0xFF64748B
    )
    ),
    ),
    ),
    ),
    ],
    );
  }
}
