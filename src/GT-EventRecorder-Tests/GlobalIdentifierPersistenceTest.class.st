"
A GlobalIdentifierPersistenceTest is a test class for testing the behavior of GlobalIdentifierPersistence
"
Class {
	#name : #GlobalIdentifierPersistenceTest,
	#superclass : #TestCase,
	#instVars : [
		'preferences',
		'persistence'
	],
	#category : #'GT-EventRecorder-Tests-Identifier'
}

{ #category : #testing }
GlobalIdentifierPersistenceTest class >> isAbstract [
	^ self name = GlobalIdentifierPersistenceTest name
]

{ #category : #accessing }
GlobalIdentifierPersistenceTest >> folderName [
	^ 'pharoPreferencesTestFolder'
]

{ #category : #accessing }
GlobalIdentifierPersistenceTest >> persistenceClass [
	^ self subclassResponsibility
]

{ #category : #running }
GlobalIdentifierPersistenceTest >> setUp [
	super setUp.
	self setUpPreferences.
	persistence := self persistenceClass new preferences: preferences; yourself.
]

{ #category : #running }
GlobalIdentifierPersistenceTest >> setUpPreferences [
	self subclassResponsibility
]

{ #category : #running }
GlobalIdentifierPersistenceTest >> tearDown [
	super tearDown.
	preferences ensureDelete.

]

{ #category : #tests }
GlobalIdentifierPersistenceTest >> testDefault [
	self deny: preferences exists description: 'The preference file should not exists by default.'.
	self deny: preferences parent exists description: 'The preference directory should not exists by default.'
]

{ #category : #tests }
GlobalIdentifierPersistenceTest >> testDelete [
	preferences parent ensureCreateDirectory.
	preferences ensureCreateFile.
	self assert: preferences exists.
	persistence delete.
	self deny: preferences exists.
	
]

{ #category : #tests }
GlobalIdentifierPersistenceTest >> testEnsureDirectory [
	persistence ensureDirectory.
	self assert: preferences parent exists.
	self deny: preferences exists.
	
]

{ #category : #tests }
GlobalIdentifierPersistenceTest >> testLoad [
	"Load when nothing is stored."
	| values |
	values := Dictionary new.
	values at: #a put: 42.
	persistence load: values.
	self assert: values size equals: 1.
	self assert: (values at: #a) equals: 42.
	self assert: preferences exists.
]

{ #category : #tests }
GlobalIdentifierPersistenceTest >> testLoad2 [
	"Load stored values."
	| values loaded |
	values := Dictionary new.
	values at: #a put: 42.
	persistence save: values.
	loaded := Dictionary new.
	persistence load: loaded.
	self assert: loaded equals: values.

]

{ #category : #tests }
GlobalIdentifierPersistenceTest >> testSave [
	| values |
	values := Dictionary new.
	values at: #a put: 42.
	persistence save: values.
	self assert: preferences exists.
]
