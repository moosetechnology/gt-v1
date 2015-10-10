"
A GlobalIdentifierFuelPersistenceTest is a test class for testing the behavior of GlobalIdentifierFuelPersistence
"
Class {
	#name : #GlobalIdentifierFuelPersistenceTest,
	#superclass : #GlobalIdentifierPersistenceTest,
	#category : #'GT-EventRecorder-Tests'
}

{ #category : #accessing }
GlobalIdentifierFuelPersistenceTest >> folderName [
	^ 'pharoPreferencesTestFolder'
]

{ #category : #accessing }
GlobalIdentifierFuelPersistenceTest >> persistenceClass [
	^ GlobalIdentifierFuelPersistence
]

{ #category : #running }
GlobalIdentifierFuelPersistenceTest >> setUpPreferences [
	preferences := FileLocator workingDirectory / self folderName / 'pharoX' / 'preferences.fuel'.
	preferences ensureDelete.
]

{ #category : #running }
GlobalIdentifierFuelPersistenceTest >> tearDown [
	(FileLocator workingDirectory / self folderName) 
		ensureDeleteAllChildren; 
		ensureDelete.
]
