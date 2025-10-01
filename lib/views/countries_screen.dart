import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphqldemo/controllers/countries_controller.dart';
import 'package:graphqldemo/views/country_detail_screen.dart';

class CountriesScreen extends StatelessWidget {
  CountriesScreen({super.key});

  final CountriesController controller = Get.put(CountriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries GraphQL Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshData,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Field
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by country code, name, or capital...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (value) {
                controller.setSearchQuery(value);
              },
            ),
          ),

          // Continent Filter Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(() {
              return DropdownButton<String>(
                value: controller.selectedContinent.value,
                isExpanded: true,
                hint: const Text('Select Continent'),
                items: controller.continents.map((String continent) {
                  return DropdownMenuItem<String>(
                    value: continent,
                    child: Text(continent),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.filterByContinent(newValue);
                  }
                },
              );
            }),
          ),

          // Countries List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.error.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${controller.error.value}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: controller.refreshData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final countries = controller.filteredCountries;

              if (countries.isEmpty) {
                return const Center(
                  child: Text('No countries found'),
                );
              }

              return ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: ListTile(
                      leading: Text(
                        country.emoji ?? '🏳️',
                        style: const TextStyle(fontSize: 32),
                      ),
                      title: Text(
                        country.name ?? 'Unknown',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Capital: ${country.capital ?? 'N/A'}'),
                          Text('Currency: ${country.currency ?? 'N/A'}'),
                          if (country.continent?.name != null)
                            Text('Continent: ${country.continent!.name}'),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => CountryDetailScreen(country: country));
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
