"
A GlobalIdentifierTest is a test class for testing the behavior of GlobalIdentifier
"
Class {
	#name : #GlobalIdentifierTest,
	#superclass : #TestCase,
	#instVars : [
		'disk',
		'preferences',
		'identifier',
		'persistence'
	],
	#category : #'GT-EventRecorder-Tests'
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
