import 'package:flop_edt_app/models/groups.dart';

Map<String, List<Group>> GROUPES = {
  'INFO1': [
    Group(groupe: '1A', parent: '1'),
    Group(groupe: '1B', parent: '1'),
    Group(groupe: '2A', parent: '2'),
    Group(groupe: '2B', parent: '2'),
    Group(groupe: '3A', parent: '3'),
    Group(groupe: '3B', parent: '3'),
    Group(groupe: '4A', parent: '4'),
    Group(groupe: '4B', parent: '4'),
  ],
  'INFO2': [
    Group(groupe: '1A', parent: '1'),
    Group(groupe: '1B', parent: '1'),
    Group(groupe: '2A', parent: '2'),
    Group(groupe: '2B', parent: '2'),
    Group(groupe: '3A', parent: '3'),
    Group(groupe: '3B', parent: '3'),
    Group(groupe: '4', parent: '4'),
  ],
  'GIM1': [
    Group(groupe: '1AA', parent: '1AA'),
    Group(groupe: '1AM', parent: '1AM'),
    Group(groupe: 'TPA', parent: 'TD1'),
    Group(groupe: 'TPB', parent: 'TD1'),
    Group(groupe: 'TPC', parent: 'TD2'),
    Group(groupe: 'TPD', parent: 'TD2'),
  ],
  'GIM2': [
    Group(groupe: 'TPA', parent: 'TD1'),
    Group(groupe: 'TPB1', parent: 'TD1'),
    Group(groupe: 'TPB2', parent: 'TD2'),
    Group(groupe: 'TPC', parent: 'TD2'),
  ],
  'CS1': [
    Group(groupe: '1G1', parent: '1G1'),
    Group(groupe: '1G2', parent: '1G2'),
  ],
  'CS2': [
    Group(groupe: '2G1', parent: '2G1'),
    Group(groupe: '2G2', parent: '2G2'),
  ],
  'RT1': [
    Group(groupe: '1GA', parent: '1G1'),
    Group(groupe: '1GB', parent: '1G1'),
    Group(groupe: '1GB', parent: '1G2'),
    Group(groupe: '1GC', parent: '1G2'),
    Group(groupe: '1GE', parent: '1GE'),
    Group(groupe: '1GF', parent: '1GF'),
  ],
  'RT2': [
    Group(groupe: '2GA', parent: '2G1'),
    Group(groupe: '2GB', parent: '2G1'),
  ],
  'RT2A': [
    Group(groupe: '2GAa', parent: '2G1a'),    
    Group(groupe: '2GBa', parent: '2G1a'), 
    ]
};

const DEPARTEMENTS = [
  'INFO1',
  'INFO2',
  'GIM1',
  'GIM2',
  'RT1',
  'RT2',
  'RT2A',
  'CS1',
  'CS2'
];

const AUTHOR = 'Thomas Gouveia';
const VERSION = 'v0.1 bêta';
const HELPER_EMAIL = 'xflop.dev@gmail.com';