// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pontuacao.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPontuacaoCollection on Isar {
  IsarCollection<Pontuacao> get pontuacaos => this.collection();
}

const PontuacaoSchema = CollectionSchema(
  name: r'Pontuacao',
  id: -486976910787842909,
  properties: {
    r'dificuldade': PropertySchema(
      id: 0,
      name: r'dificuldade',
      type: IsarType.long,
    ),
    r'duracaoEmSegundos': PropertySchema(
      id: 1,
      name: r'duracaoEmSegundos',
      type: IsarType.long,
    ),
    r'nomeDoJogador': PropertySchema(
      id: 2,
      name: r'nomeDoJogador',
      type: IsarType.string,
    )
  },
  estimateSize: _pontuacaoEstimateSize,
  serialize: _pontuacaoSerialize,
  deserialize: _pontuacaoDeserialize,
  deserializeProp: _pontuacaoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _pontuacaoGetId,
  getLinks: _pontuacaoGetLinks,
  attach: _pontuacaoAttach,
  version: '3.1.0+1',
);

int _pontuacaoEstimateSize(
  Pontuacao object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nomeDoJogador.length * 3;
  return bytesCount;
}

void _pontuacaoSerialize(
  Pontuacao object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.dificuldade);
  writer.writeLong(offsets[1], object.duracaoEmSegundos);
  writer.writeString(offsets[2], object.nomeDoJogador);
}

Pontuacao _pontuacaoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Pontuacao();
  object.dificuldade = reader.readLong(offsets[0]);
  object.duracaoEmSegundos = reader.readLong(offsets[1]);
  object.id = id;
  object.nomeDoJogador = reader.readString(offsets[2]);
  return object;
}

P _pontuacaoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pontuacaoGetId(Pontuacao object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pontuacaoGetLinks(Pontuacao object) {
  return [];
}

void _pontuacaoAttach(IsarCollection<dynamic> col, Id id, Pontuacao object) {
  object.id = id;
}

extension PontuacaoQueryWhereSort
    on QueryBuilder<Pontuacao, Pontuacao, QWhere> {
  QueryBuilder<Pontuacao, Pontuacao, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PontuacaoQueryWhere
    on QueryBuilder<Pontuacao, Pontuacao, QWhereClause> {
  QueryBuilder<Pontuacao, Pontuacao, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PontuacaoQueryFilter
    on QueryBuilder<Pontuacao, Pontuacao, QFilterCondition> {
  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition> dificuldadeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dificuldade',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      dificuldadeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dificuldade',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition> dificuldadeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dificuldade',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition> dificuldadeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dificuldade',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      duracaoEmSegundosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duracaoEmSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      duracaoEmSegundosGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duracaoEmSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      duracaoEmSegundosLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duracaoEmSegundos',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      duracaoEmSegundosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duracaoEmSegundos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomeDoJogador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nomeDoJogador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nomeDoJogador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nomeDoJogador',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nomeDoJogador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nomeDoJogador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nomeDoJogador',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nomeDoJogador',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nomeDoJogador',
        value: '',
      ));
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterFilterCondition>
      nomeDoJogadorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nomeDoJogador',
        value: '',
      ));
    });
  }
}

extension PontuacaoQueryObject
    on QueryBuilder<Pontuacao, Pontuacao, QFilterCondition> {}

extension PontuacaoQueryLinks
    on QueryBuilder<Pontuacao, Pontuacao, QFilterCondition> {}

extension PontuacaoQuerySortBy on QueryBuilder<Pontuacao, Pontuacao, QSortBy> {
  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> sortByDificuldade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dificuldade', Sort.asc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> sortByDificuldadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dificuldade', Sort.desc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> sortByDuracaoEmSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracaoEmSegundos', Sort.asc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy>
      sortByDuracaoEmSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracaoEmSegundos', Sort.desc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> sortByNomeDoJogador() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeDoJogador', Sort.asc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> sortByNomeDoJogadorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeDoJogador', Sort.desc);
    });
  }
}

extension PontuacaoQuerySortThenBy
    on QueryBuilder<Pontuacao, Pontuacao, QSortThenBy> {
  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> thenByDificuldade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dificuldade', Sort.asc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> thenByDificuldadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dificuldade', Sort.desc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> thenByDuracaoEmSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracaoEmSegundos', Sort.asc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy>
      thenByDuracaoEmSegundosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracaoEmSegundos', Sort.desc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> thenByNomeDoJogador() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeDoJogador', Sort.asc);
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QAfterSortBy> thenByNomeDoJogadorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeDoJogador', Sort.desc);
    });
  }
}

extension PontuacaoQueryWhereDistinct
    on QueryBuilder<Pontuacao, Pontuacao, QDistinct> {
  QueryBuilder<Pontuacao, Pontuacao, QDistinct> distinctByDificuldade() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dificuldade');
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QDistinct> distinctByDuracaoEmSegundos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duracaoEmSegundos');
    });
  }

  QueryBuilder<Pontuacao, Pontuacao, QDistinct> distinctByNomeDoJogador(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nomeDoJogador',
          caseSensitive: caseSensitive);
    });
  }
}

extension PontuacaoQueryProperty
    on QueryBuilder<Pontuacao, Pontuacao, QQueryProperty> {
  QueryBuilder<Pontuacao, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Pontuacao, int, QQueryOperations> dificuldadeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dificuldade');
    });
  }

  QueryBuilder<Pontuacao, int, QQueryOperations> duracaoEmSegundosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duracaoEmSegundos');
    });
  }

  QueryBuilder<Pontuacao, String, QQueryOperations> nomeDoJogadorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomeDoJogador');
    });
  }
}
