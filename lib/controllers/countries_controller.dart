import 'package:get/get.dart';
import 'package:graphqldemo/models/country.dart';
import 'package:graphqldemo/services/countries_service.dart';

class CountriesController extends GetxController {
  final CountriesService _countriesService = CountriesService();

  // Observable variables
  final RxList<Country> countries = <Country>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxString selectedContinent = 'All'.obs;
  final RxString searchQuery = ''.obs;

  // Observable list of continents for filtering
  final RxList<String> continents = <String>['All'].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await _countriesService.getCountries();

      countries.assignAll(result);

      // Extract unique continents
      final uniqueContinents = <String>{'All'};
      for (var country in result) {
        if (country.continent?.name != null) {
          uniqueContinents.add(country.continent!.name!);
        }
      }
      continents.assignAll(uniqueContinents.toList());

    } catch (e) {
      error.value = e.toString();
      print('Error fetching countries: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCountriesByContinent(String continentName) async {
    try {
      isLoading.value = true;
      error.value = '';

      if (continentName == 'All') {
        await fetchCountries();
      } else {
        // Get all countries first, then filter client-side
        final allCountries = await _countriesService.getCountries();
        final filteredCountries = allCountries.where((country) =>
          country.continent?.name == continentName
        ).toList();
        countries.assignAll(filteredCountries);
      }
    } catch (e) {
      error.value = e.toString();
      print('Error fetching countries by continent: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterByContinent(String continent) {
    selectedContinent.value = continent;
    fetchCountriesByContinent(continent);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query.toLowerCase().trim();
  }

  List<Country> get filteredCountries {
    List<Country> filteredList;

    // First filter by continent
    if (selectedContinent.value == 'All') {
      filteredList = countries;
    } else {
      filteredList = countries.where((country) =>
        country.continent?.name == selectedContinent.value
      ).toList();
    }

    // Then filter by search query if there's a search term
    if (searchQuery.value.isNotEmpty) {
      filteredList = filteredList.where((country) {
        // Search in country code, name, and capital
        return (country.code?.toLowerCase().contains(searchQuery.value) ?? false) ||
               (country.name?.toLowerCase().contains(searchQuery.value) ?? false) ||
               (country.capital?.toLowerCase().contains(searchQuery.value) ?? false);
      }).toList();
    }

    return filteredList;
  }

  Country? getCountryByCode(String code) {
    try {
      return countries.firstWhere((country) => country.code == code);
    } catch (e) {
      return null;
    }
  }

  void refreshData() {
    fetchCountries();
  }
}
