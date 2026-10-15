import 'package:flutter/material.dart';

const Color shifaTeal = Color(0xFF0D9488);
const Color shifaGreen = Color(0xFF059669);
const Color shifaBg = Color(0xFFF8FAFC);
const Color shifaText = Color(0xFF0F172A);
const Color shifaMuted = Color(0xFF64748B);

void main() => runApp(const ShifaApp());

class ShifaApp extends StatelessWidget {
  const ShifaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shifa - شفاء',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: shifaBg,
        colorScheme: ColorScheme.fromSeed(seedColor: shifaTeal, primary: shifaTeal),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: shifaText,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: MedicalRecordsVaultScreen(),
      ),
    );
  }
}

enum RecordCategory { all, labTests, radiology, prescriptions, reports, other }

class MedicalRecord {
  final String id;
  final String title;
  final String facility;
  final String doctorName;
  final String date;
  final String fileType;
  final RecordCategory category;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String notes;

  const MedicalRecord({
    required this.id,
    required this.title,
    required this.facility,
    required this.doctorName,
    required this.date,
    required this.fileType,
    required this.category,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.notes = '',
  });
}

class MedicalRecordsVaultScreen extends StatefulWidget {
  const MedicalRecordsVaultScreen({super.key});

  @override
  State<MedicalRecordsVaultScreen> createState() => _MedicalRecordsVaultScreenState();
}

class _MedicalRecordsVaultScreenState extends State<MedicalRecordsVaultScreen> {
  RecordCategory _selectedCategory = RecordCategory.all;
  final TextEditingController _searchController = TextEditingController();
  final List<MedicalRecord> _records = [
    const MedicalRecord(
      id: 'REC-001', title: 'تحليل دم شامل (CBC & Lipid Profile)',
      facility: 'مختبرات البرج الطبية', doctorName: 'د. أحمد سمير - باطنة',
      date: '12 مايو 2024', fileType: 'PDF', category: RecordCategory.labTests,
      icon: Icons.biotech_rounded, iconColor: shifaTeal, iconBgColor: Color(0xFFCCFBF1),
    ),
    const MedicalRecord(
      id: 'REC-002', title: 'أشعة سينية على الصدر (Chest X-Ray)',
      facility: 'مركز السلام للأشعة', doctorName: 'د. سارة علي - أشعة تشخيصية',
      date: '10 مايو 2024', fileType: 'JPG', category: RecordCategory.radiology,
      icon: Icons.image_search_rounded, iconColor: Color(0xFF0284C7), iconBgColor: Color(0xFFE0F2FE),
    ),
    const MedicalRecord(
      id: 'REC-003', title: 'روشتة علاج السكر والضغط',
      facility: 'عيادات الشفاء التخصصية', doctorName: 'د. أحمد سمير',
      date: '01 مايو 2024', fileType: 'PDF', category: RecordCategory.prescriptions,
      icon: Icons.medication_rounded, iconColor: Color(0xFFF59E0B), iconBgColor: Color(0xFFFEF3C7),
    ),
    const MedicalRecord(
      id: 'REC-004', title: 'فحص وظائف الكبد والكلى',
      facility: 'مستشفى الشروق العام', doctorName: 'د. منى محمود',
      date: '28 أبريل 2024', fileType: 'PDF', category: RecordCategory.labTests,
      icon: Icons.science_rounded, iconColor: shifaTeal, iconBgColor: Color(0xFFCCFBF1),
    ),
    const MedicalRecord(
      id: 'REC-005', title: 'تقرير الاستشارة الطبية الدورية',
      facility: 'عيادات الشفاء التخصصية', doctorName: 'د. أحمد سمير',
      date: '15 أبريل 2024', fileType: 'DOCX', category: RecordCategory.reports,
      icon: Icons.description_rounded, iconColor: Color(0xFF6366F1), iconBgColor: Color(0xFFEEF2FF),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MedicalRecord> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();
    return _records.where((record) {
      final categoryMatch = _selectedCategory == RecordCategory.all || record.category == _selectedCategory;
      final textMatch = query.isEmpty ||
          record.title.toLowerCase().contains(query) ||
          record.doctorName.toLowerCase().contains(query) ||
          record.facility.toLowerCase().contains(query);
      return categoryMatch && textMatch;
    }).toList();
  }

  Future<void> _openUpload() async {
    final record = await Navigator.of(context).push<MedicalRecord>(
      MaterialPageRoute(builder: (_) => const Directionality(
        textDirection: TextDirection.rtl,
        child: UploadMedicalRecordScreen(),
      )),
    );
    if (record != null && mounted) {
      setState(() => _records.insert(0, record));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تمت إضافة المستند إلى السجل الطبي'), backgroundColor: shifaTeal),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;
    return Scaffold(
      appBar: AppBar(
        title: const Text('السجل الطبي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          IconButton(
            tooltip: 'معلومات',
            onPressed: () => showAboutDialog(context: context, applicationName: 'شفاء Shifa', applicationVersion: '1.0.0'),
            icon: const Icon(Icons.info_outline_rounded, color: shifaMuted),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(children: [
        _buildSearchAndFilters(),
        _buildStatsCard(),
        Expanded(
          child: records.isEmpty
              ? const Center(child: Text('لا توجد سجلات مطابقة', style: TextStyle(color: shifaMuted)))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  itemCount: records.length,
                  itemBuilder: (_, index) => _buildRecordCard(records[index]),
                ),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openUpload,
        backgroundColor: shifaTeal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_photo_alternate_rounded),
        label: const Text('رفع فحص جديد', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSearchAndFilters() => Container(
    color: Colors.white,
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    child: Column(children: [
      TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'ابحث عن فحص، تحليل أو طبيب...',
          hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
          prefixIcon: const Icon(Icons.search_rounded, color: shifaTeal),
          filled: true, fillColor: const Color(0xFFF1F5F9),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          _categoryChip('الكل', RecordCategory.all),
          _categoryChip('تحاليل مخبرية', RecordCategory.labTests),
          _categoryChip('أشعة وتصوير', RecordCategory.radiology),
          _categoryChip('روشتات', RecordCategory.prescriptions),
          _categoryChip('تقارير طبية', RecordCategory.reports),
          _categoryChip('أخرى', RecordCategory.other),
        ]),
      ),
    ]),
  );

  Widget _categoryChip(String label, RecordCategory category) {
    final selected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ChoiceChip(
        label: Text(label), selected: selected,
        onSelected: (_) => setState(() => _selectedCategory = category),
        selectedColor: shifaTeal,
        labelStyle: TextStyle(color: selected ? Colors.white : const Color(0xFF475569), fontWeight: FontWeight.w600, fontSize: 12),
        backgroundColor: const Color(0xFFF1F5F9),
        side: BorderSide(color: selected ? shifaTeal : Colors.transparent),
        showCheckmark: false,
      ),
    );
  }

  Widget _buildStatsCard() => Container(
    margin: const EdgeInsets.fromLTRB(16, 12, 16, 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFF0FDFA), Color(0xFFE0F2FE)], begin: Alignment.topRight, end: Alignment.bottomLeft),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF99F6E4)),
    ),
    child: Row(children: [
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: shifaTeal.withOpacity(.12), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.folder_copy_rounded, color: shifaTeal, size: 24)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('إجمالي المستندات: ${_records.length}', style: const TextStyle(fontWeight: FontWeight.bold, color: shifaText, fontSize: 14)),
        const SizedBox(height: 3),
        const Text('احتفظ بفحوصاتك وتقاريرك في مكان واحد', style: TextStyle(color: shifaMuted, fontSize: 11)),
      ])),
      const Icon(Icons.verified_user_outlined, color: shifaTeal),
    ]),
  );

  Widget _buildRecordCard(MedicalRecord record) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: shifaText.withOpacity(.04), blurRadius: 10, offset: const Offset(0, 4))]),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _showRecordDetails(record),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: record.iconBgColor, borderRadius: BorderRadius.circular(14)), child: Icon(record.icon, color: record.iconColor, size: 26)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(record.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: shifaText), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 5),
            Text('${record.facility} • ${record.doctorName}', style: const TextStyle(fontSize: 11, color: shifaMuted), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Wrap(spacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)), child: Text(record.fileType, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569)))),
              Text(record.date, style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ]),
          ])),
          IconButton(onPressed: () => _showRecordDetails(record), icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF94A3B8), size: 20)),
        ]),
      ),
    ),
  );

  void _showRecordDetails(MedicalRecord record) {
    showModalBottomSheet<void>(
      context: context, showDragHandle: true, isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(record.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: shifaText)),
          const SizedBox(height: 14),
          _detailLine('المستشفى / المختبر', record.facility),
          _detailLine('الطبيب', record.doctorName),
          _detailLine('التاريخ', record.date),
          _detailLine('نوع الملف', record.fileType),
          if (record.notes.isNotEmpty) _detailLine('ملاحظات', record.notes),
          const SizedBox(height: 10),
          const Text('ملاحظة: البيانات المعروضة تجريبية، ولا يتم رفع الملفات إلى خادم في هذه النسخة.', style: TextStyle(fontSize: 12, color: shifaMuted)),
        ]),
      ),
    );
  }

  Widget _detailLine(String title, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 130, child: Text(title, style: const TextStyle(color: shifaMuted))), Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: shifaText))) ]),
  );
}

enum DocumentCategory { labTest, radiology, prescription, report, other }

class UploadMedicalRecordScreen extends StatefulWidget {
  const UploadMedicalRecordScreen({super.key});

  @override
  State<UploadMedicalRecordScreen> createState() => _UploadMedicalRecordScreenState();
}

class _UploadMedicalRecordScreenState extends State<UploadMedicalRecordScreen> {
  DocumentCategory _selectedCategory = DocumentCategory.labTest;
  final _titleController = TextEditingController(text: 'تحليل وظائف كبد وكلى دوري');
  final _facilityController = TextEditingController(text: 'مختبرات البرج الطبية');
  final _doctorController = TextEditingController(text: 'د. أحمد سمير');
  final _notesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _aiExtractionEnabled = true;
  String _selectedSource = 'PDF';

  @override
  void dispose() {
    _titleController.dispose();
    _facilityController.dispose();
    _doctorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context, initialDate: _selectedDate,
      firstDate: DateTime(2000), lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: shifaTeal, onPrimary: Colors.white, onSurface: shifaText)),
        child: child!,
      ),
    );
    if (picked != null && mounted) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رفع فحص أو تقرير طبي', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18), onPressed: () => Navigator.maybePop(context)),
        actions: [IconButton(icon: const Icon(Icons.help_outline_rounded), onPressed: _showHelp)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildUploadBox(),
          const SizedBox(height: 16),
          _buildAiBadge(),
          const SizedBox(height: 24),
          const Text('نوع المستند / الفحص', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: shifaText)),
          const SizedBox(height: 10),
          SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
            _categoryChip('تحليل مخبري', DocumentCategory.labTest, Icons.biotech_rounded),
            _categoryChip('أشعة وتصوير', DocumentCategory.radiology, Icons.image_search_rounded),
            _categoryChip('روشتة دواء', DocumentCategory.prescription, Icons.medication_rounded),
            _categoryChip('تقرير طبي', DocumentCategory.report, Icons.description_rounded),
            _categoryChip('أخرى', DocumentCategory.other, Icons.more_horiz_rounded),
          ])),
          const SizedBox(height: 20),
          _buildMetadataForm(),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 52, child: FilledButton.icon(
            onPressed: _saveRecord,
            icon: const Icon(Icons.check_circle_outline_rounded),
            label: const Text('حفظ في السجل الطبي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            style: FilledButton.styleFrom(backgroundColor: shifaTeal, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          )),
          const SizedBox(height: 10),
          SizedBox(width: double.infinity, height: 48, child: TextButton(onPressed: () => Navigator.maybePop(context), child: const Text('إلغاء والعودة'))),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _buildUploadBox() => Container(
    width: double.infinity, padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: const Color(0xFFF0FDFA), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF99F6E4), width: 1.5)),
    child: Column(children: [
      Container(padding: const EdgeInsets.all(14), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.cloud_upload_outlined, color: shifaTeal, size: 36)),
      const SizedBox(height: 14),
      const Text('اختر طريقة إضافة المستند', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: shifaText)),
      const SizedBox(height: 6),
      const Text('واجهة تجريبية — لا يتم اختيار ملف فعلي في هذه النسخة', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: shifaMuted)),
      const SizedBox(height: 16),
      Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
        _sourceButton('مسح ضوئي', 'Scan', Icons.document_scanner_rounded),
        _sourceButton('معرض الصور', 'JPG', Icons.photo_library_outlined),
        _sourceButton('ملف PDF', 'PDF', Icons.picture_as_pdf_outlined),
      ]),
      const SizedBox(height: 12),
      Text('المصدر المحدد: $_selectedSource', style: const TextStyle(color: shifaTeal, fontSize: 12, fontWeight: FontWeight.bold)),
    ]),
  );

  Widget _sourceButton(String label, String source, IconData icon) {
    final selected = _selectedSource == source;
    return OutlinedButton.icon(
      onPressed: () => setState(() => _selectedSource = source),
      icon: Icon(icon, size: 17), label: Text(label, style: const TextStyle(fontSize: 12)),
      style: OutlinedButton.styleFrom(
        foregroundColor: selected ? Colors.white : shifaTeal,
        backgroundColor: selected ? shifaTeal : Colors.white,
        side: const BorderSide(color: Color(0xFFCCFBF1)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  Widget _buildAiBadge() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF0FDF4), Color(0xFFECFDF5)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFA7F3D0))),
    child: Row(children: [
      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: shifaGreen.withOpacity(.12), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.auto_awesome_rounded, color: shifaGreen, size: 20)),
      const SizedBox(width: 10),
      const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('التعرّف الذكي على النتائج (Shifa AI)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF065F46))),
        SizedBox(height: 3),
        Text('تصميم توضيحي؛ استخراج البيانات بالذكاء الاصطناعي غير متصل حالياً.', style: TextStyle(fontSize: 11, color: Color(0xFF047857))),
      ])),
      Switch(value: _aiExtractionEnabled, activeColor: shifaGreen, onChanged: (value) => setState(() => _aiExtractionEnabled = value)),
    ]),
  );

  Widget _categoryChip(String label, DocumentCategory category, IconData icon) {
    final selected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ChoiceChip(
        selected: selected, showCheckmark: false,
        onSelected: (_) => setState(() => _selectedCategory = category),
        avatar: Icon(icon, size: 16, color: selected ? Colors.white : shifaMuted),
        label: Text(label), selectedColor: shifaTeal, backgroundColor: Colors.white,
        labelStyle: TextStyle(fontSize: 12, color: selected ? Colors.white : const Color(0xFF334155), fontWeight: selected ? FontWeight.bold : FontWeight.normal),
        side: BorderSide(color: selected ? shifaTeal : const Color(0xFFE2E8F0)),
      ),
    );
  }

  Widget _buildMetadataForm() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: shifaText.withOpacity(.04), blurRadius: 10, offset: const Offset(0, 3))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _textField(label: 'عنوان الفحص / الوصف', controller: _titleController, hint: 'مثال: تحليل دم شامل CBC', icon: Icons.title_rounded),
      const SizedBox(height: 14),
      _textField(label: 'المختبر أو المستشفى', controller: _facilityController, hint: 'مثال: مستشفى دار الفؤاد', icon: Icons.local_hospital_outlined),
      const SizedBox(height: 14),
      _textField(label: 'اسم الطبيب المعالج', controller: _doctorController, hint: 'د. فلان', icon: Icons.person_outline_rounded),
      const SizedBox(height: 14),
      const Text('تاريخ الفحص', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
      const SizedBox(height: 6),
      InkWell(
        onTap: _selectDate, borderRadius: BorderRadius.circular(12),
        child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), decoration: BoxDecoration(color: shifaBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE2E8F0))), child: Row(children: [const Icon(Icons.calendar_month_outlined, size: 18, color: shifaTeal), const SizedBox(width: 8), Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: shifaText))])),
      ),
      const SizedBox(height: 14),
      _textField(label: 'ملاحظات إضافية (اختياري)', controller: _notesController, hint: 'أضف أي تفاصيل أو أعراض رافقت هذا الفحص...', icon: Icons.edit_note_rounded, maxLines: 3),
    ]),
  );

  Widget _textField({required String label, required TextEditingController controller, required String hint, required IconData icon, int maxLines = 1}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
      const SizedBox(height: 6),
      TextField(
        controller: controller, maxLines: maxLines,
        style: const TextStyle(fontSize: 13, color: shifaText),
        decoration: InputDecoration(
          hintText: hint, hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
          prefixIcon: Icon(icon, color: shifaTeal, size: 18), filled: true, fillColor: shifaBg,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: shifaTeal)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    ],
  );

  void _saveRecord() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('من فضلك اكتب عنوان الفحص')));
      return;
    }
    final categoryData = switch (_selectedCategory) {
      DocumentCategory.labTest => (RecordCategory.labTests, Icons.biotech_rounded, shifaTeal, const Color(0xFFCCFBF1)),
      DocumentCategory.radiology => (RecordCategory.radiology, Icons.image_search_rounded, const Color(0xFF0284C7), const Color(0xFFE0F2FE)),
      DocumentCategory.prescription => (RecordCategory.prescriptions, Icons.medication_rounded, const Color(0xFFF59E0B), const Color(0xFFFEF3C7)),
      DocumentCategory.report => (RecordCategory.reports, Icons.description_rounded, const Color(0xFF6366F1), const Color(0xFFEEF2FF)),
      DocumentCategory.other => (RecordCategory.other, Icons.insert_drive_file_rounded, shifaMuted, const Color(0xFFF1F5F9)),
    };
    final record = MedicalRecord(
      id: 'REC-${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(), facility: _facilityController.text.trim().isEmpty ? 'غير محدد' : _facilityController.text.trim(),
      doctorName: _doctorController.text.trim().isEmpty ? 'غير محدد' : _doctorController.text.trim(),
      date: '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
      fileType: _selectedSource == 'Scan' ? 'SCAN' : _selectedSource,
      category: categoryData.$1, icon: categoryData.$2, iconColor: categoryData.$3, iconBgColor: categoryData.$4,
      notes: _notesController.text.trim(),
    );
    Navigator.of(context).pop(record);
  }

  void _showHelp() => showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('معلومات عن رفع المستند'),
      content: const Text('هذه نسخة واجهة تجريبية. خيارات المسح الضوئي والصور وPDF توضح نوع المصدر فقط، ولا تفتح الكاميرا أو تختار ملفاً فعلياً. البيانات تحفظ مؤقتاً أثناء تشغيل التطبيق.'),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً'))],
    ),
  );
}
