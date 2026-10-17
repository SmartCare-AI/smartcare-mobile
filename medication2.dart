import 'package:flutter/material.dart';
void main() {
  runApp(
    const ShifaApp()
  );
}
class ShifaApp extends StatelessWidget {
  const ShifaApp(
     {
      super.key
    }
  );
  @override
  Widget build(
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
      home: const MedicationDetailScreen(),
      routes: {
        '/reminder': (
          context
        ) =>
        const MedicationReminderScreen(),
      },
    );
  }
}
class MedicationDetailScreen extends StatefulWidget {
  const MedicationDetailScreen(
     {
      super.key
    }
  );
  @override
State<MedicationDetailScreen> createState() => _MedicationDetailScreenState();
}
class _MedicationDetailScreenState extends State<MedicationDetailScreen> {
  bool _doseTakenToday = false;
  int _remainingPills = 14;
  final int _totalPills = 28;
  final double _adherenceRate = 0.92;
  @override
Widget build(
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
            children: [
              _buildHeroMedicationCard(),
              const SizedBox(
                height: 16
              ),
              _buildQuickActionButtons(),
              const SizedBox(
                height: 16
              ),
              _buildScheduleAndDosageCard(),
              const SizedBox(
                height: 16
              ),
              _buildInventoryAndAdherenceCard(),
              const SizedBox(
                height: 16
              ),
              _buildClinicalInfoCard(),
              const SizedBox(
                height: 16
              ),
              _buildPrescribingDoctorCard(),
              const SizedBox(
                height: 24
              ),
              _buildBottomActions(),
              const SizedBox(
                height: 32
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
          Icons.arrow_forward_ios_rounded,
          color: Color(
            0xFF334155
          ),
          size: 18
        ),
        onPressed: () => Navigator.maybePop(
          context
        ),
      ),
      title: const Text(
        'تفاصيل الدواء',
        style: TextStyle(
          color: Color(
            0xFF0F172A
          ),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.alarm_rounded,
            color: Color(
              0xFF0D9488
            ),
          ),
          tooltip: 'فتح تنبيه الدواء',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/reminder'
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.edit_outlined,
            color: Color(
              0xFF64748B
            )
          ),
          tooltip: 'تعديل الدواء',
          onPressed: () {
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.share_outlined,
            color: Color(
              0xFF64748B
            )
          ),
          tooltip: 'مشاركة الوصفة',
          onPressed: () {
          },
        ),
        const SizedBox(
          width: 8
        ),
      ],
    );
  }
  Widget _buildHeroMedicationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        20
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF0F172A
            ).withOpacity(
              0.04
            ),
            blurRadius: 12,
            offset: const Offset(
              0,
              4
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(
                        0xFFCCFBF1
                      ),
                      Color(
                        0xFFE0F2FE
                      )
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    18
                  ),
                ),
                child: const Icon(
                  Icons.medication_rounded,
                  color: Color(
                    0xFF0D9488
                  ),
                  size: 32
                ),
              ),
              const SizedBox(
                width: 14
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'أموكسيسيلين (Amoxicillin)',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(
                                0xFF0F172A
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFECFDF5
                            ),
                            borderRadius: BorderRadius.circular(
                              20
                            ),
                            border: Border.all(
                              color: const Color(
                                0xFFA7F3D0
                              )
                            ),
                          ),
                          child: const Text(
                            'نشط ومستمر',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(
                                0xFF059669
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4
                    ),
                    const Text(
                      'مضاد حيوي واسع المجال • كبسولات 500 مجم',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(
                          0xFF64748B
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: Color(
                            0xFF0D9488
                          )
                        ),
                        const SizedBox(
                          width: 4
                        ),
                        const Text(
                          'الجرعة التالية: اليوم 02:00 م',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(
                              0xFF0D9488
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildQuickActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                14
              ),
              gradient: LinearGradient(
                colors: _doseTakenToday ? [
                  const Color(
                    0xFF059669
                  ),
                  const Color(
                    0xFF047857
                  )
                ] : [
                  const Color(
                    0xFF0D9488
                  ),
                  const Color(
                    0xFF0F766E
                  )
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFF0D9488
                  ).withOpacity(
                    0.25
                  ),
                  blurRadius: 10,
                  offset: const Offset(
                    0,
                    4
                  ),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(
                  () {
                    _doseTakenToday = !_doseTakenToday;
                    if (
                      _doseTakenToday && _remainingPills > 0
                    ) {
                      _remainingPills--;
                    }
                    else if (
                      !_doseTakenToday
                    ) {
                      _remainingPills++;
                    }
                  }
                );
                ScaffoldMessenger.of(
                  context
                ).showSnackBar(
                  SnackBar(
                    content: Text(
                      _doseTakenToday ? 'تم تسجيل تناول الجرعة بنجاح أحسنت!' : 'تم التراجع عن أخذ الجرعة',
                    ),
                    backgroundColor: const Color(
                      0xFF0D9488
                    ),
                    duration: const Duration(
                      seconds: 2
                    ),
                  ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _doseTakenToday ? Icons.check_circle_rounded : Icons.radio_button_checked_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8
                  ),
                  Text(
                    _doseTakenToday ? 'تم أخذ الجرعة' : 'تناول الجرعة الآن',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10
        ),
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                14
              ),
              border: Border.all(
                color: const Color(
                  0xFFE2E8F0
                )
              ),
            ),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'تم تأجيل التنبيه لمدة 30 دقيقة'
                    ),
                    duration: Duration(
                      seconds: 2
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    14
                  )
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.snooze_rounded,
                    color: Color(
                      0xFF475569
                    ),
                    size: 18
                  ),
                  SizedBox(
                    width: 4
                  ),
                  Text(
                    'تأجيل',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFF475569
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildScheduleAndDosageCard() {
    return Container(
      padding: const EdgeInsets.all(
        18
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          18
        ),
        boxShadow: [
          BoxShadow(
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
        children: [
          const Text(
            'تعليمات الجرعة والجدول الزمني',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(
                0xFF0F172A
              )
            ),
          ),
          const SizedBox(
            height: 14
          ),
          _buildInfoRow(
            icon: Icons.repeat_rounded,
            title: 'معدل التكرار',
            value: '3 مرات يومياً (كل 8 ساعات)',
          ),
          const Divider(
            height: 20,
            color: Color(
              0xFFF1F5F9
            )
          ),
          _buildInfoRow(
            icon: Icons.access_time_filled_rounded,
            title: 'مواعيد التنبيه',
            value: '08:00 ص • 02:00 م • 10:00 م',
          ),
          const Divider(
            height: 20,
            color: Color(
              0xFFF1F5F9
            )
          ),
          _buildInfoRow(
            icon: Icons.restaurant_rounded,
            title: 'إرشادات الأكل',
            value: 'بعد الأكل مباشرة مع كوب ماء وفير',
          ),
          const Divider(
            height: 20,
            color: Color(
              0xFFF1F5F9
            )
          ),
          _buildInfoRow(
            icon: Icons.date_range_rounded,
            title: 'مدة العلاج المتبقية',
            value: '7 أيام متبقية (ينتهي في 25 مايو)',
          ),
        ],
      ),
    );
  }
  Widget _buildInfoRow(
     {
      required IconData icon,
      required String title,
      required String value,
    }
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(
            8
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFFF0FDFA
            ),
            borderRadius: BorderRadius.circular(
              10
            ),
          ),
          child: Icon(
            icon,
            size: 18,
            color: const Color(
              0xFF0D9488
            )
          ),
        ),
        const SizedBox(
          width: 12
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(
                    0xFF64748B
                  )
                ),
              ),
              const SizedBox(
                height: 2
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF0F172A
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildInventoryAndAdherenceCard() {
    final progress = _remainingPills / _totalPills;
    return Container(
      padding: const EdgeInsets.all(
        18
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          18
        ),
        boxShadow: [
          BoxShadow(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'المخزون والالتزام الدوائي',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF0F172A
                  )
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFF0FDFA
                  ),
                  borderRadius: BorderRadius.circular(
                    8
                  ),
                ),
                child: Text(
                  'التزام ${(_adherenceRate * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xFF0D9488
                    )
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المتبقي في العلبة: $_remainingPills من $_totalPills كبسولة',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xFF334155
                  )
                ),
              ),
              Text(
                'يكفي لـ 5 أيام',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _remainingPills < 8 ? const Color(
                    0xFFDC2626
                  ) : const Color(
                    0xFF64748B
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              8
            ),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(
                0xFFF1F5F9
              ),
              color: progress > 0.3 ? const Color(
                0xFF0D9488
              ) : const Color(
                0xFFF59E0B
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(
            height: 12
          ),
          InkWell(
            onTap: () {
            },
            borderRadius: BorderRadius.circular(
              10
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8
              ),
              decoration: BoxDecoration(
                color: const Color(
                  0xFFF8FAFC
                ),
                borderRadius: BorderRadius.circular(
                  10
                ),
                border: Border.all(
                  color: const Color(
                    0xFFE2E8F0
                  )
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.local_pharmacy_outlined,
                    size: 16,
                    color: Color(
                      0xFF0D9488
                    )
                  ),
                  SizedBox(
                    width: 8
                  ),
                  Expanded(
                    child: Text(
                      'طلب إعادة صرف أو شراء من الصيدلية الشريكة',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          0xFF0D9488
                        )
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Color(
                      0xFF94A3B8
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildClinicalInfoCard() {
    return Container(
      padding: const EdgeInsets.all(
        18
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          18
        ),
        boxShadow: [
          BoxShadow(
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
        children: [
          const Text(
            'معلومات الاستخدام والتحذيرات',
            style: TextStyle(
              fontSize: 15,
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
            'دواعي الاستعمال:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(
                0xFF334155
              )
            ),
          ),
          const SizedBox(
            height: 4
          ),
          const Text(
            'علاج عدوى الجهاز التنفسي العلوي والتهاب الجيوب الأنفية والتهاب الحلق.',
            style: TextStyle(
              fontSize: 12,
              color: Color(
                0xFF64748B
              ),
              height: 1.4
            ),
          ),
          const SizedBox(
            height: 12
          ),
          const Text(
            'الآثار الجانبية الشائعة:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(
                0xFF334155
              )
            ),
          ),
          const SizedBox(
            height: 8
          ),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _buildWarningChip(
                'غثيان خفيف'
              ),
              _buildWarningChip(
                'اضطراب بسيط بالمعدة'
              ),
              _buildWarningChip(
                'طفح جلدي (نادر)'
              ),
            ],
          ),
          const SizedBox(
            height: 12
          ),
          Container(
            padding: const EdgeInsets.all(
              12
            ),
            decoration: BoxDecoration(
              color: const Color(
                0xFFFEF2F2
              ),
              borderRadius: BorderRadius.circular(
                12
              ),
              border: Border.all(
                color: const Color(
                  0xFFFECACA
                )
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Color(
                    0xFFDC2626
                  ),
                  size: 18
                ),
                SizedBox(
                  width: 8
                ),
                Expanded(
                  child: Text(
                    'يجب إكمال الكورس العلاجي بالكامل حتى نهايته، وتجنب التوقف بمجرد الشعور بالتحسن لتفادي مقاومة البكتيريا.',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(
                        0xFFB91C1C
                      ),
                      height: 1.4
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildWarningChip(
    String text
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF1F5F9
        ),
        borderRadius: BorderRadius.circular(
          8
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: Color(
            0xFF475569
          )
        ),
      ),
    );
  }
  Widget _buildPrescribingDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(
        16
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          18
        ),
        boxShadow: [
          BoxShadow(
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
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Color(
              0xFFE2E8F0
            ),
            child: Icon(
              Icons.person_rounded,
              color: Color(
                0xFF64748B
              ),
              size: 28
            ),
          ),
          const SizedBox(
            width: 14
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'د. أحمد سمير محمود',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xFF0F172A
                    ),
                  ),
                ),
                SizedBox(
                  height: 2
                ),
                Text(
                  'استشاري الأمراض الباطنة • مستشفى الشفاء',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(
                      0xFF64748B
                    )
                  ),
                ),
                SizedBox(
                  height: 2
                ),
                Text(
                  'تاريخ الوصفة: 12 مايو 2024',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(
                      0xFF94A3B8
                    )
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.chat_bubble_outline_rounded,
              color: Color(
                0xFF0D9488
              ),
              size: 20
            ),
            tooltip: 'مراسلة الطبيب',
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
  Widget _buildBottomActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () {
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              size: 18
            ),
            label: const Text(
              'تعديل تنبيهات مواعيد الجرعات'
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(
                0xFF0D9488
              ),
              side: const BorderSide(
                color: Color(
                  0xFF0D9488
                )
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  14
                )
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10
        ),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (
                  ctx
                ) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: const Text(
                      'إيقاف أو حذف الدواء؟'
                    ),
                    content: const Text(
                      'هل ترغب في أرشفة الدواء عند انتهاء الكورس، أم حذفه بالكامل من جدولك؟'
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(
                          ctx
                        ),
                        child: const Text(
                          'إلغاء'
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            ctx
                          );
                          Navigator.maybePop(
                            context
                          );
                        },
                        child: const Text(
                          'إيقاف الدواء',
                          style: TextStyle(
                            color: Color(
                              0xFFDC2626
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.archive_outlined,
              size: 18,
              color: Color(
                0xFF94A3B8
              )
            ),
            label: const Text(
              'أرشفة أو إيقاف هذا الدواء',
              style: TextStyle(
                color: Color(
                  0xFF94A3B8
                ),
                fontSize: 13
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class MedicationReminderScreen extends StatefulWidget {
  const MedicationReminderScreen(
     {
      super.key
    }
  );
  @override
State<MedicationReminderScreen> createState() => _MedicationReminderScreenState();
}
class _MedicationReminderScreenState extends State<MedicationReminderScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isTaken = false;
  int _selectedSnoozeMinutes = 15;
  final int _remainingPills = 18;
  @override
void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2
      ),
    )..repeat(
      reverse: true
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut
      ),
    );
  }
  @override
void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
  void _markAsTaken() {
    setState(
      () {
        _isTaken = true;
      }
    );
    ScaffoldMessenger.of(
      context
    ).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.white
            ),
            SizedBox(
              width: 8
            ),
            Text(
              'أحسنت! تم تسجيل تناول الجرعة بنجاح وتحديث نسبة الالتزام.'
            ),
          ],
        ),
        backgroundColor: Color(
          0xFF0D9488
        ),
        duration: Duration(
          seconds: 3
        ),
      ),
    );
  }
  void _snoozeReminder(
    int minutes
  ) {
    ScaffoldMessenger.of(
      context
    ).showSnackBar(
      SnackBar(
        content: Text(
          'تم تأجيل المنبه بنجاح لمدة $minutes دقيقة'
        ),
        backgroundColor: const Color(
          0xFF475569
        ),
      ),
    );
    Navigator.maybePop(
      context
    );
  }
  void _showSkipDialog() {
    showDialog(
      context: context,
      builder: (
        ctx
      ) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              20
            )
          ),
          title: const Text(
            'تخطي هذه الجرعة؟',
            style: TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'سيتم تسجيل تخطي الجرعة في سجل التزامك الدوائي. يرجى تحديد السبب:'
              ),
              const SizedBox(
                height: 12
              ),
              _buildSkipReasonOption(
                'أشعر بأعراض جانبية'
              ),
              _buildSkipReasonOption(
                'الدواء غير متوفر حالياً'
              ),
              _buildSkipReasonOption(
                'بأمر أو استشارة الطبيب'
              ),
              _buildSkipReasonOption(
                'صائم / سبب آخر'
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(
                ctx
              ),
              child: const Text(
                'إلغاء',
                style: TextStyle(
                  color: Color(
                    0xFF64748B
                  )
                )
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  ctx
                );
                Navigator.maybePop(
                  context
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFFDC2626
                ),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10
                  )
                ),
              ),
              child: const Text(
                'تأكيد التخطي'
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildSkipReasonOption(
    String reason
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          8
        ),
        onTap: () {
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 8
          ),
          child: Row(
            children: [
              const Icon(
                Icons.radio_button_unchecked,
                size: 16,
                color: Color(
                  0xFF94A3B8
                )
              ),
              const SizedBox(
                width: 8
              ),
              Text(
                reason,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(
                    0xFF334155
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
Widget build(
    BuildContext context
  ) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: Color(
                0xFF475569
              )
            ),
            onPressed: () => Navigator.maybePop(
              context
            ),
          ),
          title: const Text(
            'تنبيه موعد الدواء',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(
                0xFF0F172A
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.volume_up_rounded,
                color: Color(
                  0xFF0D9488
                )
              ),
              tooltip: 'إيقاف نغمة التنبيه',
              onPressed: () {
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10
              ),
              _buildPulsingAlarmHeader(),
              const SizedBox(
                height: 24
              ),
              _buildMedicationCard(),
              const SizedBox(
                height: 20
              ),
              _buildInstructionsNotice(),
              const SizedBox(
                height: 28
              ),
              _buildActionButtons(),
              const SizedBox(
                height: 24
              ),
              _buildSnoozeQuickRow(),
              const SizedBox(
                height: 16
              ),
              _buildNextDoseFooter(),
              const SizedBox(
                height: 20
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildPulsingAlarmHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _pulseAnimation,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(
                    0xFF0D9488
                  ).withOpacity(
                    0.12
                  ),
                ),
              ),
            ),
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(
                      0xFF0D9488
                    ),
                    Color(
                      0xFF059669
                    )
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xFF0D9488
                    ).withOpacity(
                      0.35
                    ),
                    blurRadius: 18,
                    offset: const Offset(
                      0,
                      6
                    ),
                  ),
                ],
              ),
              child: const Icon(
                Icons.alarm_on_rounded,
                color: Colors.white,
                size: 38,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFFF0FDFA
            ),
            borderRadius: BorderRadius.circular(
              20
            ),
            border: Border.all(
              color: const Color(
                0xFF99F6E4
              )
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.access_time_filled_rounded,
                color: Color(
                  0xFF0D9488
                ),
                size: 16
              ),
              SizedBox(
                width: 6
              ),
              Text(
                '08:00 صباحاً • جرعة الصباح',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF0D9488
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8
        ),
        const Text(
          'حان الآن موعد جرعتك المقررة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(
              0xFF0F172A
            ),
          ),
        ),
        const SizedBox(
          height: 4
        ),
        const Text(
          'الالتزام بمواعيد الدواء يحميك ويسرّع من وتيرة تعافيك',
          style: TextStyle(
            fontSize: 13,
            color: Color(
              0xFF64748B
            )
          ),
        ),
      ],
    );
  }
  Widget _buildMedicationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        20
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          22
        ),
        border: Border.all(
          color: _isTaken ? const Color(
            0xFFA7F3D0
          ) : const Color(
            0xFFE2E8F0
          ),
          width: _isTaken ? 1.6 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF0F172A
            ).withOpacity(
              0.05
            ),
            blurRadius: 14,
            offset: const Offset(
              0,
              4
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFCCFBF1
                  ),
                  borderRadius: BorderRadius.circular(
                    16
                  ),
                ),
                child: const Icon(
                  Icons.medication_rounded,
                  color: Color(
                    0xFF0D9488
                  ),
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 14
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ميتفورمين (Metformin)',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(
                          0xFF0F172A
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4
                    ),
                    const Text(
                      '500 مجم • قرص واحد (Tablet)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(
                          0xFF0D9488
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFEF3C7
                            ),
                            borderRadius: BorderRadius.circular(
                              6
                            ),
                          ),
                          child: const Text(
                            'بعد الأكل مباشرة',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(
                                0xFFD97706
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8
                        ),
                        Text(
                          'المخزون: $_remainingPills قرص',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(
                              0xFF64748B
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 24,
            color: Color(
              0xFFF1F5F9
            )
          ),
          Row(
            children: [
              const Icon(
                Icons.medical_services_outlined,
                size: 16,
                color: Color(
                  0xFF64748B
                )
              ),
              const SizedBox(
                width: 6
              ),
              const Text(
                'وصفة الطبيب: د. أحمد سمير - عيادة الباطنة',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(
                    0xFF475569
                  )
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
                child: const Text(
                  'تفاصيل أكثر',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xFF0D9488
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildInstructionsNotice() {
    return Container(
      padding: const EdgeInsets.all(
        14
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF0FDFA
        ),
        borderRadius: BorderRadius.circular(
          16
        ),
        border: Border.all(
          color: const Color(
            0xFF99F6E4
          )
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(
              0xFF0D9488
            ),
            size: 20
          ),
          SizedBox(
            width: 10
          ),
          Expanded(
            child: Text(
              'يُفضّل بلع القرص مع كوب ماء وفير بعد الانتهاء من تناول وجبة الإفطار لتجنب أي اضطراب بالمعدة.',
              style: TextStyle(
                fontSize: 12,
                color: Color(
                  0xFF0F766E
                ),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              16
            ),
            gradient: LinearGradient(
              colors: _isTaken ? [
                const Color(
                  0xFF059669
                ),
                const Color(
                  0xFF047857
                )
              ] : [
                const Color(
                  0xFF0D9488
                ),
                const Color(
                  0xFF0F766E
                )
              ],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF0D9488
                ).withOpacity(
                  0.35
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
            onPressed: _markAsTaken,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16
                )
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isTaken ? Icons.check_circle_rounded : Icons.check_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(
                  width: 8
                ),
                Text(
                  _isTaken ? 'تم تسجيل الجرعة بنجاح' : 'تناولت الدواء الآن',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
          height: 46,
          child: TextButton(
            onPressed: _showSkipDialog,
            child: const Text(
              'تخطي هذه الجرعة اليوم',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(
                  0xFF94A3B8
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSnoozeQuickRow() {
    final snoozeMinutes = [
      10,
      15,
      30,
      60
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
        boxShadow: [
          BoxShadow(
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
        children: [
          const Row(
            children: [
              Icon(
                Icons.snooze_rounded,
                size: 18,
                color: Color(
                  0xFF475569
                )
              ),
              SizedBox(
                width: 6
              ),
              Text(
                'تأجيل التنبيه مؤقتاً (غفوة):',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(
                    0xFF0F172A
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12
          ),
          Row(
            children: snoozeMinutes.map(
              (
                mins
              ) {
                final isSelected = _selectedSnoozeMinutes == mins;
                final label = mins == 60 ? 'ساعة' : '$mins د';
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        12
                      ),
                      onTap: () {
                        setState(
                          () {
                            _selectedSnoozeMinutes = mins;
                          }
                        );
                        _snoozeReminder(
                          mins
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 200
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(
                            0xFFF0FDFA
                          ) : const Color(
                            0xFFF8FAFC
                          ),
                          borderRadius: BorderRadius.circular(
                            12
                          ),
                          border: Border.all(
                            color: isSelected ? const Color(
                              0xFF0D9488
                            ) : const Color(
                              0xFFE2E8F0
                            ),
                          ),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? const Color(
                              0xFF0D9488
                            ) : const Color(
                              0xFF475569
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            ).toList(),
          ),
        ],
      ),
    );
  }
  Widget _buildNextDoseFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10
      ),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF1F5F9
        ),
        borderRadius: BorderRadius.circular(
          14
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 16,
            color: Color(
              0xFF64748B
            )
          ),
          SizedBox(
            width: 6
          ),
          Text(
            'الجرعة القادمة: أتورفاستاتين 20 مجم الساعة 10:00 مساءً',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(
                0xFF475569
              ),
            ),
          ),
        ],
      ),
    );
  }
}
