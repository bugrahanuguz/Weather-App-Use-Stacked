import 'package:flutter/material.dart';
import 'package:mart_tech_test/features/weather/viewmodels/city_entry_view_model.dart';
import 'package:stacked/stacked.dart';

class CityChangedView extends StatelessWidget {
  final bool isDay;

  const CityChangedView({Key? key, required this.isDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CityEntryViewModel>.reactive(
      viewModelBuilder: () => CityEntryViewModel(),
      
      builder: (context, model, child) => Container(
        margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 50),
        padding: EdgeInsets.only(left: 5, top: 5, right: 20, bottom: 00),
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isDay ? Colors.orangeAccent.shade100 : Colors.blue.shade800,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                model.updateCity(model.cityEditController.text);
                model.refreshWeather(model.cityEditController.text, context);
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: model.cityEditController,
                decoration: const InputDecoration.collapsed(hintText: 'Enter City'),
                onSubmitted: (String city) {
                  model.refreshWeather(city, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
