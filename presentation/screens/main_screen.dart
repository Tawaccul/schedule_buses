import 'package:flutter/material.dart';
import 'package:testappflutter/presentation/consts/colors.dart';
import '../viewmodels/main_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime selectedDate = DateTime.now();
  String departureCity = 'Казань';
  String destinationCity = 'Уфа';
  final RefreshController _refreshController = RefreshController();
  bool isGreen = false;
  bool isSearched = true;
  bool isDateSelected = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainViewModel(),
      child: Consumer<MainViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: mainGreyColor,
              title: const Text('Поиск поездок'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                  color: Colors.black,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0),
                    child: Column(
                      children: [
                        ImageSlider(),
                        Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 140,
                                  width: 20,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.location_on_rounded, color: mainGreenColor),
                                      Icon(Icons.more_vert_rounded, color: mainGreenColor),
                                      Icon(Icons.airport_shuttle, color: mainGreenColor),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: mainGreyColor,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: DropdownButton<String>(
                                          alignment: Alignment.centerLeft,
                                          underline: Container(),
                                          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                                          isExpanded: true,
                                          icon: const Icon(Icons.location_searching_rounded),
                                          value: departureCity,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              departureCity = newValue!;
                                            });
                                          },
                                          items: <String>['Казань', 'Москва', 'Уфа']
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: mainGreyColor,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: DropdownButton<String>(
                                          alignment: Alignment.centerLeft,
                                          underline: Container(),
                                          padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                                          icon: const Icon(Icons.location_searching_rounded),
                                          isExpanded: true,
                                          value: destinationCity,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              destinationCity = newValue!;
                                            });
                                          },
                                          items: <String>['Казань', 'Москва', 'Уфа']
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: mainGreyColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(6),
                                  child: TextButton.icon(
                            onPressed: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      // Настройте цвета календаря
                                      colorScheme: const ColorScheme.light(
                                        primary: mainGreenColor, // Цвет основных элементов
                                        onPrimary: Colors.white, // Цвет текста на основных элементах
                                        surface: mainGreyColor, // Цвет фона
                                        onSurface: Colors.black, // Цвет текста на фоне
                                      ),
                                      // Настройте стиль текста
                                      textTheme: const TextTheme(
                                        titleMedium: TextStyle(color: mainGreenColor), // Стиль текста месяца и года
                                        bodyLarge: TextStyle(color: mainGreenColor), // Стиль текста чисел
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null && picked != selectedDate) {
                                setState(() {
                                  selectedDate = picked;
                                  isDateSelected = true;
                                });
                              }
                            },
                            icon: const Icon(Icons.date_range, color: mainGreenColor),
                            label: isDateSelected
                                ? Text("${selectedDate.day.toString().padLeft(2, '0')}.${selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}", style: const TextStyle(color: mainGreenColor, fontSize: 16))
                                : const Text("Выбрать дату", style: TextStyle(color: mainGreenColor, fontSize: 16)),
                          ),
                          
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: mainGreenColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(6),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSearched = !isSearched;
                                      });
                                      viewModel.fetchBuses(departureCity, destinationCity, selectedDate);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Text('Найти', style: TextStyle(color: Colors.white, fontSize: 16)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (viewModel.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              viewModel.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Divider( color: mainGreenColor, height: 1),
                  Expanded(
  child: Container(
    decoration: BoxDecoration(
      color: mainGreyColor,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      child: isSearched
          ? Center(
              child: Text(
                viewModel.buses.isEmpty
                    ? 'На выбранную дату нет рейсов'
                    : 'Здесь будет расписание автобусов.\n По умолчанию сегодняшняя дата: \n ${('${DateTime.now().day.toString().padLeft(2, '0')}.${DateTime.now().month.toString().padLeft(2, '0')}.${DateTime.now().year}')}',
                style: const TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            )
          : viewModel.isLoading
              ? const Center(child: CircularProgressIndicator(color: mainGreenColor))
              : SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    viewModel.refreshBuses(departureCity, destinationCity, selectedDate);
                    _refreshController.refreshCompleted();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: viewModel.buses.length,
                    itemBuilder: (context, index) {
                      final bus = viewModel.buses[index];
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                        boxShadow:const [
                             BoxShadow(
                               color: Color.fromRGBO(0, 0, 0, 0.16),
                              blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(
                                0,
                                1,
                            ),
                          ),
                        ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          title: Text('${bus.departureCity} -> ${bus.destinationCity}',
                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                          subtitle: Text(
                              'Дата: ${bus.date.day.toString().padLeft(2, '0')}.${bus.date.month.toString().padLeft(2, '0')}.${bus.date.year.toString().substring(2)}  Время: ${bus.date.hour.toString().padLeft(2, '0')}:${bus.date.minute.toString().padLeft(2, '0')}'),
                          leading: const Icon(Icons.directions_bus, color: mainGreenColor),
                        ),
                      );
                    },
                  ),
                ),
    ),
  ),
),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1557223562-6c77ef16210f?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1577701517740-ad4aa1fc1000?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDl8fHxlbnwwfHx8fHw%3D',
    'https://images.unsplash.com/photo-1571046314604-e32adfc8e11e?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1569135218372-6f7f6f3d7e55?q=80&w=1372&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?q=80&w=1421&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ];

   ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrls[index],
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}