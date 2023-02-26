const List<Map<String, dynamic>> surahData = [
  {
    'id': 1,
    'name': 'Al Fatiha',
    'aya': 7,
    'pages': [1],
    'arabic': 'الفاتحة'
  },
  {
    'id': 2,
    'name': 'Al Baqarah',
    'aya': 286,
    'pages': [2, 49],
    'arabic': 'البقرة'
  },
  {
    'id': 3,
    'name': 'Al Imran',
    'aya': 200,
    'pages': [50, 76],
    'arabic': 'آل عمران'
  },
  {
    'id': 4,
    'name': 'An Nisa',
    'aya': 176,
    'pages': [77, 106],
    'arabic': 'النساء'
  },
  {
    'id': 5,
    'name': "Al Ma'idah",
    'aya': 120,
    'pages': [106, 127],
    'arabic': 'المائدة'
  },
  {
    'id': 6,
    'name': "Al An'am",
    'aya': 165,
    'pages': [128, 150],
    'arabic': 'الأنعام'
  },
  {
    'id': 7,
    'name': "Al A'raf",
    'aya': 206,
    'pages': [151, 176],
    'arabic': 'الأعراف'
  },
  {
    'id': 8,
    'name': 'Al Anfal',
    'aya': 75,
    'pages': [177, 186],
    'arabic': 'الأنفال'
  },
  {
    'id': 9,
    'name': 'At Tawbah',
    'aya': 129,
    'pages': [187, 207],
    'arabic': 'التوبة'
  },
  {
    'id': 10,
    'name': 'Al Yunus',
    'aya': 109,
    'pages': [208, 221],
    'arabic': 'يونس'
  },
  {
    'id': 11,
    'name': 'Hud',
    'aya': 123,
    'pages': [221, 235],
    'arabic': 'هود'
  },
  {
    'id': 12,
    'name': 'Yusuf',
    'aya': 111,
    'pages': [235, 248],
    'arabic': 'يوسف'
  },
  {
    'id': 13,
    'name': "Ar Ra'd",
    'aya': 43,
    'pages': [249, 255],
    'arabic': 'الرعد'
  },
  {
    'id': 14,
    'name': 'Ibrahim',
    'aya': 52,
    'pages': [255, 261],
    'arabic': 'ابراهيم'
  },
  {
    'id': 15,
    'name': 'Al Hijr',
    'aya': 99,
    'pages': [262, 267],
    'arabic': 'الحجر'
  },
  {
    'id': 16,
    'name': 'An Nahl',
    'aya': 128,
    'pages': [267, 281],
    'arabic': 'النحل'
  },
  {
    'id': 17,
    'name': "Al Isra'",
    'aya': 111,
    'pages': [282, 293],
    'arabic': 'الإسراء'
  },
  {
    'id': 18,
    'name': 'Al Kahf',
    'aya': 110,
    'pages': [293, 304],
    'arabic': 'الكهف'
  },
  {
    'id': 19,
    'name': 'Maryam',
    'aya': 98,
    'pages': [305, 312],
    'arabic': 'مريم'
  },
  {
    'id': 20,
    'name': 'Ta Ha',
    'aya': 135,
    'pages': [312, 321],
    'arabic': 'طه'
  },
  {
    'id': 21,
    'name': 'Al Anbiya',
    'aya': 112,
    'pages': [322, 331],
    'arabic': 'الأنبياء'
  },
  {
    'id': 22,
    'name': 'Al Hajj',
    'aya': 78,
    'pages': [332, 341],
    'arabic': 'الحج'
  },
  {
    'id': 23,
    'name': 'Al Mu minun',
    'aya': 118,
    'pages': [342, 349],
    'arabic': 'المؤمنون'
  },
  {
    'id': 24,
    'name': 'An Nur',
    'aya': 64,
    'pages': [350, 359],
    'arabic': 'النور'
  },
  {
    'id': 25,
    'name': 'Al Furqan',
    'aya': 77,
    'pages': [359, 366],
    'arabic': 'الفرقان'
  },
  {
    'id': 26,
    'name': "As Su'ara",
    'aya': 227,
    'pages': [367, 376],
    'arabic': 'الشعراء'
  },
  {
    'id': 27,
    'name': 'An Naml',
    'aya': 93,
    'pages': [377, 385],
    'arabic': 'النمل'
  },
  {
    'id': 28,
    'name': 'Al Qasas',
    'aya': 88,
    'pages': [385, 396],
    'arabic': 'القصص'
  },
  {
    'id': 29,
    'name': 'Al Ankabut',
    'aya': 69,
    'pages': [396, 404],
    'arabic': 'العنكبوت'
  },
  {
    'id': 30,
    'name': 'Ar Rum',
    'aya': 60,
    'pages': [404, 410],
    'arabic': 'الروم'
  },
  {
    'id': 31,
    'name': 'Luqman',
    'aya': 34,
    'pages': [411, 414],
    'arabic': 'لقمان'
  },
  {
    'id': 32,
    'name': 'As Sajdah',
    'aya': 30,
    'pages': [415, 417],
    'arabic': 'السجدة'
  },
  {
    'id': 33,
    'name': 'Al Ahzab',
    'aya': 73,
    'pages': [418, 427],
    'arabic': 'الأحزاب'
  },
  {
    'id': 34,
    'name': "Saba'",
    'aya': 54,
    'pages': [428, 434],
    'arabic': 'سبإ'
  },
  {
    'id': 35,
    'name': 'Fatir',
    'aya': 45,
    'pages': [434, 440],
    'arabic': 'فاطر'
  },
  {
    'id': 36,
    'name': "Ya'sin",
    'aya': 83,
    'pages': [440, 445],
    'arabic': 'يس'
  },
  {
    'id': 37,
    'name': 'As Saffat',
    'aya': 182,
    'pages': [446, 452],
    'arabic': 'الصافات'
  },
  {
    'id': 38,
    'name': 'Saad',
    'aya': 88,
    'pages': [453, 458],
    'arabic': 'ص'
  },
  {
    'id': 39,
    'name': 'Az Zumar',
    'aya': 75,
    'pages': [458, 467],
    'arabic': 'الزمر'
  },
  {
    'id': 40,
    'name': 'Ghafir',
    'aya': 85,
    'pages': [467, 476],
    'arabic': 'غافر'
  },
  {
    'id': 41,
    'name': 'Fussilat',
    'aya': 54,
    'pages': [477, 482],
    'arabic': 'فصلت'
  },
  {
    'id': 42,
    'name': 'As Sura',
    'aya': 53,
    'pages': [483, 489],
    'arabic': 'الشورى'
  },
  {
    'id': 43,
    'name': 'Az Zukhruf',
    'aya': 89,
    'pages': [489, 495],
    'arabic': 'الزخرف'
  },
  {
    'id': 44,
    'name': 'Ad Dukhan',
    'aya': 59,
    'pages': [496, 498],
    'arabic': 'الدخان'
  },
  {
    'id': 45,
    'name': 'Al Jaathiyah',
    'aya': 37,
    'pages': [499, 502],
    'arabic': 'الجاثية'
  },
  {
    'id': 46,
    'name': 'Al Ahqaf',
    'aya': 35,
    'pages': [502, 506],
    'arabic': 'الأحقاف'
  },
  {
    'id': 47,
    'name': 'Muhammad',
    'aya': 38,
    'pages': [507, 510],
    'arabic': 'محمد'
  },
  {
    'id': 48,
    'name': 'Al Fath',
    'aya': 29,
    'pages': [511, 515],
    'arabic': 'الفتح'
  },
  {
    'id': 49,
    'name': 'Al Hujurut',
    'aya': 18,
    'pages': [515, 517],
    'arabic': 'الحجرات'
  },
  {
    'id': 50,
    'name': 'Qaaf',
    'aya': 45,
    'pages': [518, 520],
    'arabic': 'ق'
  },
  {
    'id': 51,
    'name': 'Ad Dariyat',
    'aya': 60,
    'pages': [520, 523],
    'arabic': 'الذاريات'
  },
  {
    'id': 52,
    'name': 'At Toor',
    'aya': 49,
    'pages': [523, 525],
    'arabic': 'الطور'
  },
  {
    'id': 53,
    'name': 'An Najm',
    'aya': 62,
    'pages': [526, 528],
    'arabic': 'النجم'
  },
  {
    'id': 54,
    'name': 'Al Qamar',
    'aya': 55,
    'pages': [528, 531],
    'arabic': 'القمر'
  },
  {
    'id': 55,
    'name': 'Ar Rahman',
    'aya': 78,
    'pages': [531, 534],
    'arabic': 'الرحمن'
  },
  {
    'id': 56,
    'name': 'Al Waqiah',
    'aya': 96,
    'pages': [534, 537],
    'arabic': 'الواقعة'
  },
  {
    'id': 57,
    'name': 'Al Hadeed',
    'aya': 29,
    'pages': [537, 541],
    'arabic': 'الحديد'
  },
  {
    'id': 58,
    'name': 'Al Mujadila',
    'aya': 22,
    'pages': [542, 545],
    'arabic': 'المجادلة'
  },
  {
    'id': 59,
    'name': 'Al Hashr',
    'aya': 24,
    'pages': [545, 548],
    'arabic': 'الحشر'
  },
  {
    'id': 60,
    'name': 'Al Mumtahanah',
    'aya': 13,
    'pages': [549, 551],
    'arabic': 'الممتحنة'
  },
  {
    'id': 61,
    'name': 'As Saff',
    'aya': 14,
    'pages': [551, 552],
    'arabic': 'الصف'
  },
  {
    'id': 62,
    'name': "Al Jumu'ah",
    'aya': 11,
    'pages': [553, 554],
    'arabic': 'الجمعة'
  },
  {
    'id': 63,
    'name': 'Al Munafiqoon',
    'aya': 11,
    'pages': [554, 555],
    'arabic': 'المنافقون'
  },
  {
    'id': 64,
    'name': 'At Taghabun',
    'aya': 18,
    'pages': [556, 557],
    'arabic': 'التغابن'
  },
  {
    'id': 65,
    'name': 'At Talaq',
    'aya': 12,
    'pages': [558, 559],
    'arabic': 'الطلاق'
  },
  {
    'id': 66,
    'name': 'At Tahreem',
    'aya': 12,
    'pages': [560, 561],
    'arabic': 'التحريم'
  },
  {
    'id': 67,
    'name': 'Al Mulk',
    'aya': 30,
    'pages': [562, 564],
    'arabic': 'الملك'
  },
  {
    'id': 68,
    'name': 'Al Qalam',
    'aya': 52,
    'pages': [564, 566],
    'arabic': 'القلم'
  },
  {
    'id': 69,
    'name': 'Al Haaqqah',
    'aya': 52,
    'pages': [566, 568],
    'arabic': 'الحاقة'
  },
  {
    'id': 70,
    'name': "Al Ma'arij",
    'aya': 44,
    'pages': [568, 570],
    'arabic': 'المعارج'
  },
  {
    'id': 71,
    'name': 'Nooh',
    'aya': 28,
    'pages': [570, 571],
    'arabic': 'نوح'
  },
  {
    'id': 72,
    'name': 'Al Jinn',
    'aya': 28,
    'pages': [572, 573],
    'arabic': 'الجن'
  },
  {
    'id': 73,
    'name': 'Al Muzammil',
    'aya': 20,
    'pages': [574, 575],
    'arabic': 'المزمل'
  },
  {
    'id': 74,
    'name': 'Al Muddathir',
    'aya': 56,
    'pages': [575, 577],
    'arabic': 'المدثر'
  },
  {
    'id': 75,
    'name': 'Al Qiyamah',
    'aya': 40,
    'pages': [577, 578],
    'arabic': 'القيامة'
  },
  {
    'id': 76,
    'name': 'Al Insaan',
    'aya': 31,
    'pages': [578, 580],
    'arabic': 'الانسان'
  },
  {
    'id': 77,
    'name': 'Al Mursalat',
    'aya': 50,
    'pages': [580, 581],
    'arabic': 'المرسلات'
  },
  {
    'id': 78,
    'name': 'An Naba',
    'aya': 40,
    'pages': [582, 583],
    'arabic': 'النبإ'
  },
  {
    'id': 79,
    'name': 'An Naaziat',
    'aya': 46,
    'pages': [583, 584],
    'arabic': 'النازعات'
  },
  {
    'id': 80,
    'name': 'Abasa',
    'aya': 42,
    'pages': [585],
    'arabic': 'عبس'
  },
  {
    'id': 81,
    'name': 'At Takweer',
    'aya': 29,
    'pages': [586],
    'arabic': 'التكوير'
  },
  {
    'id': 82,
    'name': 'Al Infitar',
    'aya': 19,
    'pages': [587],
    'arabic': 'الإنفطار'
  },
  {
    'id': 83,
    'name': 'Al Mutaffifin',
    'aya': 36,
    'pages': [587, 589],
    'arabic': 'المطففين'
  },
  {
    'id': 84,
    'name': 'Al Inshiqaaq',
    'aya': 25,
    'pages': [589],
    'arabic': 'الإنشقاق'
  },
  {
    'id': 85,
    'name': 'Al Burooj',
    'aya': 22,
    'pages': [590],
    'arabic': 'البروج'
  },
  {
    'id': 86,
    'name': 'At Taariq',
    'aya': 17,
    'pages': [591],
    'arabic': 'الطارق'
  },
  {
    'id': 87,
    'name': "Al A'laa",
    'aya': 19,
    'pages': [591, 592],
    'arabic': 'الأعلى'
  },
  {
    'id': 88,
    'name': 'Al Ghaashiyah',
    'aya': 26,
    'pages': [592],
    'arabic': 'الغاشية'
  },
  {
    'id': 89,
    'name': 'Al Fajr',
    'aya': 30,
    'pages': [593, 594],
    'arabic': 'الفجر'
  },
  {
    'id': 90,
    'name': 'Al Balad',
    'aya': 20,
    'pages': [594],
    'arabic': 'البلد'
  },
  {
    'id': 91,
    'name': 'Ash Shams',
    'aya': 15,
    'pages': [595],
    'arabic': 'الشمس'
  },
  {
    'id': 92,
    'name': 'Al Layl',
    'aya': 21,
    'pages': [595, 596],
    'arabic': 'الليل'
  },
  {
    'id': 93,
    'name': 'Ad Dhuha',
    'aya': 11,
    'pages': [596],
    'arabic': 'الضحى'
  },
  {
    'id': 94,
    'name': 'Ash Sharh',
    'aya': 8,
    'pages': [596],
    'arabic': 'الشرح'
  },
  {
    'id': 95,
    'name': 'At Teen',
    'aya': 8,
    'pages': [597],
    'arabic': 'التين'
  },
  {
    'id': 96,
    'name': 'Al Alaq',
    'aya': 19,
    'pages': [597],
    'arabic': 'العلق'
  },
  {
    'id': 97,
    'name': 'Al Qadr',
    'aya': 5,
    'pages': [598],
    'arabic': 'القدر'
  },
  {
    'id': 98,
    'name': 'Al Bayyinah',
    'aya': 8,
    'pages': [598, 599],
    'arabic': 'البينة'
  },
  {
    'id': 99,
    'name': 'Az Zalzalah',
    'aya': 8,
    'pages': [599],
    'arabic': 'الزلزلة'
  },
  {
    'id': 100,
    'name': 'Al Aadiyaat',
    'aya': 11,
    'pages': [599, 600],
    'arabic': 'العاديات'
  },
  {
    'id': 101,
    'name': "Al Qaari'ah",
    'aya': 11,
    'pages': [600],
    'arabic': 'القارعة'
  },
  {
    'id': 102,
    'name': 'At Takaathur',
    'aya': 8,
    'pages': [600],
    'arabic': 'التكاثر'
  },
  {
    'id': 103,
    'name': 'Al Asr',
    'aya': 3,
    'pages': [601],
    'arabic': 'العصر'
  },
  {
    'id': 104,
    'name': 'Al Humazah',
    'aya': 9,
    'pages': [601],
    'arabic': 'الهمزة'
  },
  {
    'id': 105,
    'name': 'Al Feel',
    'aya': 5,
    'pages': [601],
    'arabic': 'الفيل'
  },
  {
    'id': 106,
    'name': 'Quraysh',
    'aya': 4,
    'pages': [602],
    'arabic': 'قريش'
  },
  {
    'id': 107,
    'name': "Al Maa'oon",
    'aya': 7,
    'pages': [602],
    'arabic': 'الماعون'
  },
  {
    'id': 108,
    'name': 'Al Kawthar',
    'aya': 3,
    'pages': [602],
    'arabic': 'الكوثر'
  },
  {
    'id': 109,
    'name': 'Al Kaafiroon',
    'aya': 6,
    'pages': [603],
    'arabic': 'الكافرون'
  },
  {
    'id': 110,
    'name': 'An Nasr',
    'aya': 3,
    'pages': [603],
    'arabic': 'النصر'
  },
  {
    'id': 111,
    'name': 'Al Masad',
    'aya': 5,
    'pages': [603],
    'arabic': 'اللهب'
  },
  {
    'id': 112,
    'name': 'Al Ikhlaas',
    'aya': 4,
    'pages': [604],
    'arabic': 'الإخلاص'
  },
  {
    'id': 113,
    'name': 'Al Falaq',
    'aya': 5,
    'pages': [604],
    'arabic': 'الفلق'
  },
  {
    'id': 114,
    'name': 'An Naas',
    'aya': 6,
    'pages': [604],
    'arabic': 'الناس'
  }
];
