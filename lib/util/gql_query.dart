mixin GqlQuery {
  static String pokemonQuery = """
  query (\$page: Int!){
    pokemons(first: \$page){
      id
      name
      number
      image
      classification
      types
      fleeRate
      maxCP
      maxHP
    }
  }
""";
}
