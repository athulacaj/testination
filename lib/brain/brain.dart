Map openRoom = {
  'categories': ['UPSC', 'KPSC', 'IAS', 'JEE', 'NEET', 'GATE'],
  'trending': [
    {'tile': 'UPSC by Race', 'image': null, 'amount': 50}
  ],
};

//openRoom/upsc/all/race solution

Map<String, dynamic> uPSCRACESOLUTIONS = {
  'name': 'Race solutions',
  'author': 'race solutions',
  'amount': 1,
  'category': 'UPSC',
  'tests': [
    {
      'name': 'Mock Test 1',
      'free': true,
      'questions': 20,
      'duration': 7200,
      'test': mockTest1
    },
    {'name': 'Mock Test 2', 'free': false, 'questions': 20, 'duration': 7200},
  ],
};
Map<String, dynamic> adminUPSCRACESOLUTIONS = {
  'name': 'Race solutions',
  'author': 'race solutions',
  'amount': 1,
  'category': 'UPSC',
  'tests': [
    {
      'name': 'Mock Test 1',
      'free': true,
      'questions': 20,
      'duration': 1000,
      'test': mockTest1
    },
    {'name': 'Mock Test 2', 'free': true, 'questions': 20, 'duration': 7200},
  ],
};

List<Map> mockTest1 = [
  {
    'question': '1+2+3+4',
    'options': ['5', '8', '12', '10'],
    'answerIndex': '3,4',
    'mark': 2
  },
  {
    'question': '10+2+3+4',
    'options': ['15', '18', '19', '16'],
    'answerIndex': '2,1',
  },
  {
    'question': '10+8+2+4',
    'options': ['24', '18', '19', '22'],
    'answerIndex': '0',
  },
];
