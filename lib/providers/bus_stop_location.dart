import 'package:flutter/material.dart';

class BusStopLocation with ChangeNotifier {
  final List<Map> _locations = [
    {
      "id": "1",
      "address": "Koteshwor Bus Stop",
      "latitude": "27.6757134",
      "longitude": "85.3485996"
    },
    {
      "id": "2",
      "address": "Balkumari Bus Stop",
      "latitude": "27.6723024",
      "longitude": "85.3411323"
    },
    {
      "id": "3",
      "address": "Khari Ko Bot",
      "latitude": "27.67044",
      "longitude": "85.3375275"
    },
    {
      "id": "4",
      "address": "Gwarko Bus Stop",
      "latitude": "27.6661451",
      "longitude": "85.3308219"
    },
    {
      "id": "5",
      "address": "B And B",
      "latitude": "27.6661451",
      "longitude": "85.3308219"
    },
    {
      "id": "6",
      "address": "Bodhigram Bus Stop",
      "latitude": "27.6630474",
      "longitude": "85.3281397"
    },
    {
      "id": "7",
      "address": "Satdobato Bus Stop",
      "latitude": "27.6595694",
      "longitude": "85.3245348"
    },
    {
      "id": "8",
      "address": "Satdobato Bus Stop",
      "latitude": "27.6589898",
      "longitude": "85.3232152"
    },
    {
      "id": "9",
      "address": "Chakrapath Bus Stop",
      "latitude": "27.6581724",
      "longitude": "85.3199852"
    },
    {
      "id": "10",
      "address": "Talchikhela Choke",
      "latitude": "27.6581724",
      "longitude": "85.3199852"
    },
    {
      "id": "11",
      "address": "JRC Chowk Bus Stop",
      "latitude": "27.6581724",
      "longitude": "85.3199852"
    },
    {
      "id": "12",
      "address": "Mahalaxmisthan Chowk",
      "latitude": "27.6581724",
      "longitude": "85.3199852"
    },
    {
      "id": "13",
      "address": "Thasikhel Chowk",
      "latitude": "27.6636532",
      "longitude": "85.3118196"
    },
    {
      "id": "14",
      "address": "Kusunti Bus Stop",
      "latitude": "27.6636532",
      "longitude": "85.3118196"
    },
    {
      "id": "15",
      "address": "Ekantakuna Bus Station",
      "latitude": "27.6661506",
      "longitude": "85.3063461"
    },
    {
      "id": "16",
      "address": "Ring Road",
      "latitude": "27.6683419",
      "longitude": "85.331603"
    },
    {
      "id": "17",
      "address": "Balkhu Bus Stop",
      "latitude": "27.684341",
      "longitude": "85.299082"
    },
    {
      "id": "18",
      "address": "Kalanki Bus Stop",
      "latitude": "27.6938032",
      "longitude": "85.2819588"
    },
    {
      "id": "19",
      "address": "Sano",
      "latitude": "27.7110015",
      "longitude": "85.2806461"
    },
    {
      "id": "20",
      "address": "Swayambhunath Bus Stop",
      "latitude": "27.716083",
      "longitude": "85.2818156"
    },
    {
      "id": "21",
      "address": "Thulo Bharyang Bus  Stop",
      "latitude": "27.7204424",
      "longitude": "85.2862466"
    },
    {
      "id": "22",
      "address": "Sano Bharyang Bus Stop",
      "latitude": "27.7204424",
      "longitude": "85.2862466"
    },
    {
      "id": "23",
      "address": "Dhungedhara Bus Stop",
      "latitude": "27.7211737",
      "longitude": "85.2910853"
    },
    {
      "id": "24",
      "address": "Banasthali Chowk",
      "latitude": "27.7222374",
      "longitude": "85.294776"
    },
    {
      "id": "25",
      "address": "Balaju Chowk",
      "latitude": "27.7260933",
      "longitude": "85.3025437"
    },
    {
      "id": "26",
      "address": "Machha Pokhari",
      "latitude": "27.7331968",
      "longitude": "85.3059662"
    },
    {
      "id": "27",
      "address": "Gongabu Bus Stop",
      "latitude": "27.7331588",
      "longitude": "85.3104187"
    },
    {
      "id": "28",
      "address": "Samakhusi Chowk Bus Stop",
      "latitude": "27.7338939",
      "longitude": "85.3160209"
    },
    {
      "id": "29",
      "address": "Taalim Kendra Bus Stop",
      "latitude": "27.7348816",
      "longitude": "85.3203124"
    },
    {
      "id": "30",
      "address": "Basundhara Chowk Bus Stop",
      "latitude": "27.7383761",
      "longitude": "85.3256983"
    },
    {
      "id": "31",
      "address": "Sajha Bus Stop",
      "latitude": "27.7404937",
      "longitude": "85.3307408"
    },
    {
      "id": "32",
      "address": "Narayan Gopal Chowk Bus Stop",
      "latitude": "27.7387274",
      "longitude": "85.3344959"
    },
    {
      "id": "33",
      "address": "Chapal Karkhana Bus Stop",
      "latitude": "27.7365719",
      "longitude": "85.3367811"
    },
    {
      "id": "34",
      "address": "Dhumbarahi",
      "latitude": "27.7332387",
      "longitude": "85.3409869"
    },
    {
      "id": "35",
      "address": "Sukedhara Bus Stop",
      "latitude": "27.7268432",
      "longitude": "85.3425746"
    },
    {
      "id": "36",
      "address": "Gopikrishna",
      "latitude": "27.7193499",
      "longitude": "85.3445058"
    },
    {
      "id": "37",
      "address": "Chabahil",
      "latitude": "27.7193499",
      "longitude": "85.3445058"
    },
    {
      "id": "38",
      "address": "Mitrapark",
      "latitude": "27.7108777",
      "longitude": "85.3431004"
    },
    {
      "id": "39",
      "address": "Jay Bijeshwori",
      "latitude": "27.7108777",
      "longitude": "85.3431004"
    },
    {
      "id": "40",
      "address": "Gaushala",
      "latitude": "27.7050171",
      "longitude": "85.3395813"
    },
    {
      "id": "41",
      "address": "Pingalasthan Bus Stop",
      "latitude": "27.7035353",
      "longitude": "85.347231"
    },
    {
      "id": "42",
      "address": "Bamansthal",
      "latitude": "27.7023289",
      "longitude": "85.350235"
    },
    {
      "id": "43",
      "address": "Sinamangal Bus Stop",
      "latitude": "27.6952705",
      "longitude": "85.351193"
    },
    {
      "id": "44",
      "address": "Koteshwore Bus Stand",
      "latitude": "27.6796044",
      "longitude": "85.346365"
    },
    {
      "id": "45",
      "address": "Soaltee Dobato Chowk",
      "latitude": "27.7059275",
      "longitude": "85.282431"
    },
    {
      "id": "46",
      "address": "Manjushree Yatayat Sewa ",
      "latitude": "27.7145272",
      "longitude": "85.2833067"
    }
  ];

  List get locations {
    return [..._locations];
  }

  void addLocation() {
    //_locations.add(value);
    notifyListeners();
  }
}
