Class {
	#name : #GlobalIdentifierWithDefaultConfiguration,
	#superclass : #GlobalIdentifierTest,
	#instVars : [
		'oldPreferences'
	],
	#category : #'GT-EventRecorder-Tests-Identifier'
}

{ #category : #accessing }
GlobalIdentifierWithDefaultConfiguration >> oldPreferencesFileName [
	^ identifier persistenceStrategy previous fileName
]

{ #category : #initialization }
GlobalIdentifierWithDefaultConfiguration >> setUpPersistenceStrategy [
	oldPreferences := FileLocator workingDirectory / self folderName / 'pharoX' / self oldPreferencesFileName.
	oldPreferences ensureDelete.
	identifier persistenceStrategy preferences: preferences.
	identifier persistenceStrategy previous preferences: oldPreferences
]

{ #category : #running }
GlobalIdentifierWithDefaultConfiguration >> tearDown [
	oldPreferences ensureDelete.
	super tearDown
]

{ #category : #tests }
GlobalIdentifierWithDefaultConfiguration >> testEnsure [
	| stored |
	super testEnsure.
	self assert: oldPreferences exists description: 'The old preferences should be stored now.'.
	stored := identifier persistenceStrategy previous load.
	self assert: stored equals: identifier persistedInformation.
]
