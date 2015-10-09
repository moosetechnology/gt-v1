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
	#category : #'GT-EventRecorder-Tests'
}

{ #category : #running }
GlobalIdentifierTest >> setUp [
	super setUp.
	"disk := FileSystem memory."
	preferences := FileLocator workingDirectory / self testFolderName / 'pharoX' / 'preferences.fuel'.
	preferences ensureDelete.
	identifier := GlobalIdentifier basicNew initialize preferences: preferences; yourself.
]

{ #category : #running }
GlobalIdentifierTest >> tearDown [
	super tearDown.
	"disk := FileSystem memory."
	preferences ensureDelete.
	(FileLocator workingDirectory / self testFolderName) 
		ensureDeleteAllChildren; 
		ensureDelete.
]

{ #category : #tests }
GlobalIdentifierTest >> testComputerUUID [
	"The computer UUID is not stored immediately because the Pharo Integration Server
	raised building errors when storing the computer UUID on the CI server."
	self assert: identifier computerUUID notNil.
	self assert: (identifier computerUUID isKindOf: UUID).
	self testDefault.
]

{ #category : #tests }
GlobalIdentifierTest >> testDefault [
	self deny: preferences exists description: 'The preference file should not exists by default.'.
	self deny: preferences parent exists description: 'The preference directory should not exists by default.'
]

{ #category : #tests }
GlobalIdentifierTest >> testDeletePreferences [
	preferences parent ensureCreateDirectory.
	preferences ensureCreateFile.
	self assert: preferences exists.
	identifier deletePreferences.
	self deny: preferences exists.
	
]

{ #category : #tests }
GlobalIdentifierTest >> testEnsureComputerUUID [
	"The computer UUID is not stored immediately because the Pharo Integration Server
	raised building errors when storing the computer UUID on the CI server."
	| stored |
	identifier ensureComputerUUID.
	self assert: preferences exists description: 'The preferences should be stored now.'.
	stored := identifier newInstanceFromPreferences.
	self assert: stored persistedInformation equals: identifier persistedInformation.
]

{ #category : #tests }
GlobalIdentifierTest >> testEnsureCreateDirectory [
	identifier ensurePreferencesDirectory.
	self assert: preferences parent exists.
	self deny: preferences exists.
	
]

{ #category : #accessing }
GlobalIdentifierTest >> testFolderName [
	^ 'pharoPreferencesTestFolder'
]
