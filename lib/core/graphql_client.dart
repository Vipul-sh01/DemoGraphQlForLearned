import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    'https://countries.trevorblades.com/graphql', // Public GraphQL API for demo
  );

  static GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );

  static ValueNotifier<GraphQLClient> clientNotifier = ValueNotifier(client);
}
