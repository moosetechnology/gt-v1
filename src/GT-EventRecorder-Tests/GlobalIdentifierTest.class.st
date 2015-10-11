"
A GlobalIdentifierTest is a test class for testing the behavior of GlobalIdentifier
"
Class {
	#name : #GlobalIdentifierTest,
	#superclass : #TestCase,
	#instVars : [
		'disk',
		'preferences',
		'identifier'
	],
	#category : #'GT-EventRecorder-Tests-Identifier'
}

{ #category : #accessing }
GlobalIdentifierTest >> fileName [
	^ identifier persistenceStrategy fileName
]

{ #category : #accessing }
GlobalIdentifierTest >> folderName [
	^ 'pharoPreferencesTestFolder'
]

{ #category : #running }
GlobalIdentifierTest >> setUp [
	super setUp.
	identifier := GlobalIdentifier basicNew initialize.
	preferences := FileLocator workingDirectory / self folderName / 'pharoX' / self fileName.
	preferences ensureDelete.
	self setUpPersistenceStrategy
]

{ #category : #running }
GlobalIdentifierTest >> setUpPersistenceStrategy [
	identifier persistenceStrategy preferences: preferences
]

{ #category : #running }
GlobalIdentifierTest >> tearDown [
	super tearDown.
	"disk := FileSystem memory."
	preferences ensureDelete.
	(FileLocator workingDirectory / self folderName) 
		ensureDeleteAllChildren; 
		ensureDelete.
]

{ #category : #tests }
GlobalIdentifierTest >> testBackwardCompatibility [
	"Let's say that we have information stored using FUEL, but we use STON.
	We do not have any STON stored value.
	Let's check that we load the FUEL, then stores it as STON."
	| fuelPersistence fuelPrefereces fuelDictionary  |
	fuelPersistence := GlobalIdentifierPersistence fuel.
	fuelPrefereces := preferences parent / 'old-preferences.fuel'.
	fuelPersistence preferences: fuelPrefereces.
	fuelDictionary := Dictionary new.
	fuelDictionary at: #computerUUID put: 42.
	fuelPersistence save: fuelDictionary.
	identifier persistenceStrategy previous: fuelPersistence.
	self deny: identifier computerUUID = 42.
	self assert: fuelPersistence preferences exists.
	identifier ensure.
	self assert: identifier computerUUID equals: 42 asString.
	self assert: identifier persistenceStrategy preferences exists.
]

{ #category : #tests }
GlobalIdentifierTest >> testBackwardCompatibility2 [
	"Let's say that we have information stored using both FUEL and STON, and we use STON.
	We will ingnore FUEL file and load STON."
	| fuelPersistence fuelPrefereces fuelDictionary  stonDictionary |
	fuelPersistence := GlobalIdentifierPersistence fuel.
	fuelPrefereces := preferences parent / 'old-preferences.fuel'.
	fuelPersistence preferences: fuelPrefereces.
	fuelDictionary := Dictionary new.
	fuelDictionary at: #computerUUID put: 42.
	fuelPersistence save: fuelDictionary.
	identifier persistenceStrategy previous: fuelPersistence.
	stonDictionary := Dictionary new.
	stonDictionary at: #computerUUID put: 21.
	identifier persistenceStrategy save: stonDictionary.
	self deny: identifier computerUUID = 42.
	self deny: identifier computerUUID = 21.
	self assert: fuelPersistence preferences exists.
	self assert: identifier persistenceStrategy preferences exists.
	identifier ensure.
	self assert: identifier computerUUID equals: 21 asString.

]

{ #category : #tests }
GlobalIdentifierTest >> testComputerUUID [
	"The computer UUID is not stored immediately because the Pharo Integration Server
	raised building errors when storing the computer UUID on the CI server."
	self assert: identifier computerUUID notNil.
	self assert: identifier computerUUID isString.
	self testDefault.
]

{ #category : #tests }
GlobalIdentifierTest >> testDefault [
	self deny: preferences exists description: 'The preference file should not exists by default.'.
	self deny: preferences parent exists description: 'The preference directory should not exists by default.'
]

{ #category : #tests }
GlobalIdentifierTest >> testEnsure [
	"The computer UUID is not stored immediately because the Pharo Integration Server
	raised building errors when storing the computer UUID on the CI server."
	| stored |
	identifier ensure.
	self assert: preferences exists description: 'The preferences should be stored now.'.
	stored := identifier persistenceStrategy load.
	self assert: stored equals: identifier persistedInformation.
]
