//
//  Keys.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/18/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//
import UIKit
import Foundation

struct Keys {
    
    // MARK: - Move Keys
    static let specialKey = "special"
    static let statusKey = "status"
    static let physicalKey = "physical"
    
    // MARK: - Search Keys
    static let baseURLString = "https://pokeapi.co/api/v2"
    static let itemBaseURLString = "https://pokeapi.co/api/v2/item-attribute/holdable-active"
    static let allPokemonBaseURL = "https://pokeapi.co/api/v2/pokemon/?limit=1000"
    static let allPokemonURLKey = "url"
    static let searchTypeKey = "type"
    static let searchPokemonKey = "pokemon"
    static let allPokemonArrayKey = "results"
    static let allPokemonNameKey = "name"
    static let generationKey = "generation"
    static let itemsArrayKey = "items"
    static let itemAttributeKey = "item-attribute"
    static let holdableItemKey = "holdable-active"
    static let itemNameKey = "name"
    
    // MARK: - Type Keys
    static let typeNormalKey = "normal"
    static let typeFireKey = "fire"
    static let typeWaterKey = "water"
    static let typeElectricKey = "electric"
    static let typeGrassKey = "grass"
    static let typeIceKey = "ice"
    static let typeFightingKey = "fighting"
    static let typePoisonKey = "poison"
    static let typeGroundKey = "ground"
    static let typeFlyingKey = "flying"
    static let typePsychicKey = "psychic"
    static let typeBugKey = "bug"
    static let typeRockKey = "rock"
    static let typeGhostKey = "ghost"
    static let typeDragonKey = "dragon"
    static let typeDarkKey = "dark"
    static let typeSteelKey = "steel"
    static let typeFairyKey = "fairy"
    
    // MARK: - Moves Parsing JSON Keys
    static let moveIDKey = "id"
    static let moveKey = "move"
    static let namesArrayKey = "names"
    static let englishNameDictionaryKey = 2
    static let moveNameKey = "name"
    static let moveTypeDictionaryKey = "type"
    static let moveTypeKey = "name"
    static let catagoryDictionaryKey = "damage_class"
    static let catagoryNameKey = "name"
    static let movePowerKey = "power"
    static let moveAccuracyKey = "accuracy"
    static let movePPKey = "pp"
    static let effectArrayKey = "effect_entries"
    static let effectDictionaryKey = 0
    static let descriptionKey = "short_effect"
    static let moveEffectChancesKey = "effect_chance"
    
    // MARK: - Pokemon Parsing JSON Keys
    static let pokemonURLKey = "url"
    static let pokemonDictionaryKey = "pokemon"
    static let pokemonArrayKey = "pokemon"
    static let pokemonNameKey = "name"
    static let pokemonIDKey = "id"
    static let movesArrayKey = "moves"
    static let pokemonMoveURL = "url"
    static let typesArrayKey = "types"
    static let type1DictionaryInt = 0
    static let type2DictionaryInt = 1
    static let typeNameKey = "name"
    static let typeDictionaryKey = "type"
    static let pokemonAbilitiesKey = "abilities"
    static let pokemonAbilityKey = "ability"
    static let abilityNameKey = "name"
    static let statsArrayKey = "stats"
    static let speedStatKeyInt = 0
    static let spDefStatKeyInt = 1
    static let spAttStatKeyInt = 2
    static let defStatKeyInt = 3
    static let attStatKeyInt = 4
    static let hpStatKeyInt = 5
    static let baseStatKey = "base_stat"
    static let speedKey = "speed"
    static let spDefKey = "specialDefense"
    static let spAttKey = "specialAttack"
    static let defKey = "defense"
    static let attKey = "attack"
    static let hpKey = "hitPoints"
    static let spriteDictionaryKey = "sprites"
    static let spriteKey = "front_default"
    
    // MARK: - CloudKit Keys
    static let ckTeamRecordType = "PokemonTeam"
    static let ckPokemonRecordType = "Pokemon"
    static let ckPokemonTeamNameKey = "name"
    static let ckPokemonIDKey = "id"
    static let ckPokemonTeamRecordIDString = "recordIDString"
    static let ckSixPokemonKey = "sixPokemon"
    static let ckPokemonNameKey = "name"
    static let ckPokemonItemKey = "item"
    static let ckPokemonNatureKey = "nature"
    static let ckPokemonType1Key = "type1"
    static let ckPokemonType2Key = "type2"
    static let ckPokemonAbilitiesKey = "abilitiesData"
    static let ckPokemonAbilityKey = "chosenAbility"
    static let ckPokemonMovesKey = "movesData"
    static let ckPokemonMove1Key = "move1"
    static let ckPokemonMove2Key = "move2"
    static let ckPokemonMove3Key = "move3"
    static let ckPokemonMove4Key = "move4"
    static let ckPokemonRoleKey = "role"
    static let ckWeaknessDictionaryKey = "weaknessDictionary"
    static let ckPokemonImageData = "imageData"
    static let ckPokemonImageEndpoint = "imageEndpoint"
    static let ckEVHP = "evHP"
    static let ckEVAttack = "evAttack"
    static let ckEVDefense = "evDefense"
    static let ckEVSpAttack = "evSpecialAttack"
    static let ckEVSpDefense = "evSpecialDefense"
    static let ckEVSpeed = "evSpeed"
    static let ckIVHP = "ivHP"
    static let ckIVAttack = "ivAttack"
    static let ckIVDefense = "ivDefense"
    static let ckIVSpAttack = "ivSpecialAttack"
    static let ckIVSpDefense = "ivSpecialDefense"
    static let ckIVSpeed = "ivSpeed"
    static let ckHPStat = "hpStat"
    static let ckAttStat = "attackStat"
    static let ckDefStat = "defenseStat"
    static let ckSpAtkStat = "spAttackStat"
    static let ckSpDefStat = "spDefenseStat"
    static let ckSpeedStat = "speedStat"
    static let ckReferenceKey = "reference"
    static let ckPokemonPokemonTeamKey = "pokemonTeam"
    
    // MARK: - View and View Controller Keys
    static let pokemonTeamCellIdentifier = "pokemonTeamCell"
    static let pokemonCellIdentifier = "pokemonCell"
    static let itemCellIdentifier = "itemCell"
    static let defaultPokemonCellIdentifier = "defaultCell"
    static let searchResultsCellIdentifier = "searchResultsCell"
    static let searchTermCellIdentifier = "searchTermCell"
    static let moveCellIdentifier = "moveCell"
    static let teamWeaknessHeaderIdentifier = "headerCell"
    static let teamWeaknessTypeIdentifier = "weaknessTypeCell"
    static let pokemonTeamListTableViewSegueIdentifier = "toPokemonTeamTVC"
    static let pokemonTeamDetailSegueIdentifier = "toPokemonDetailVC"
    static let segueIdentifierToPokemonSearchVC = "toPokemonSearchVC"
    static let segueIdentiferToPokemonDetailVCFromSearch = "searchToPokemonDetailVC"
    static let segueIdentifierMove1ToMovesTVC = "move1ToMovesTVC"
    static let segueIdentifierMove2ToMovesTVC = "move2ToMovesTVC"
    static let segueIdentifierMove3ToMovesTVC = "move3ToMovesTVC"
    static let segueIdentifierMove4ToMovesTVC = "move4ToMovesTVC"
    static let segueIdentifierToStatsVC = "toPokemonStatsVC"
    static let segueIdentifierBackToPokemonDetailVC = "backToPokemonDetailVC"
    static let unwindSegueIdentifierToPokemonTeamVC = "unwindToPokemonTeamDetailVC"
    static let segueIdentifierToTeamWeaknessVC = "toTeamWeaknessVC"
    static let segueIdentifierToItemsTVC = "toItemTVC"
    
    // MARK: - UserDefault Keys
    static let isCopiedKey = "isCopied"
    
    // MARK: - Notification Names
    static let notificationToReloadTableView = Notification.Name("reloadTableView")
    
    // MARK: - isSaved
    static let notSaved = "None"
    static let saved = "Saved"
}




