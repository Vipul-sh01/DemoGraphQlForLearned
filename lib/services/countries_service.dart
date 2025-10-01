import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqldemo/core/graphql_client.dart';
import 'package:graphqldemo/models/country.dart';

class CountriesService {
  final GraphQLClient _client = GraphQLConfig.client;

  Future<List<Country>> getCountries() async {
    const String getCountriesQuery = '''
      query GetCountries {
        countries {
          code
          name
          capital
          emoji
          currency
          languages {
            code
            name
            native
            rtl
          }
          continent {
            code
            name
          }
        }
      }
    ''';

    final QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getCountriesQuery),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('GraphQL Error: ${result.exception.toString()}');
    }

    final data = result.data?['countries'];
    if (data == null) {
      return [];
    }

    return (data as List)
        .map((countryJson) => Country.fromJson(countryJson))
        .toList();
  }


  Future<Country?> getCountryByCode(String code) async {
    const String getCountryByCodeQuery = '''
      query GetCountryByCode(\$code: ID!) {
        country(code: \$code) {
          code
          name
          capital
          emoji
          currency
          languages {
            code
            name
            native
            rtl
          }
          continent {
            code
            name
          }
        }
      }
    ''';

    final QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getCountryByCodeQuery),
        variables: {'code': code},
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw Exception('GraphQL Error: ${result.exception.toString()}');
    }

    final data = result.data?['country'];
    if (data == null) {
      return null;
    }

    return Country.fromJson(data);
  }

  Future<List<String>> getContinents() async {
    const String getContinentsQuery = '''
      query GetContinents {
        continents {
          code
          name
        }
      }
    ''';

    final QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getContinentsQuery),
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );

    if (result.hasException) {
      throw Exception('GraphQL Error: ${result.exception.toString()}');
    }

    final data = result.data?['continents'];
    if (data == null) {
      return [];
    }

    return (data as List)
        .map((continentJson) => continentJson['name'] as String)
        .toList();
  }
}
