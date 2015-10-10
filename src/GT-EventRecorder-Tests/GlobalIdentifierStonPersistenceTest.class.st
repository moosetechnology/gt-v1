Class {
	#name : #GlobalIdentifierStonPersistenceTest,
	#superclass : #GlobalIdentifierPersistenceTest,
	#category : #'GT-EventRecorder-Tests'
}

{ #category : #accessing }
GlobalIdentifierStonPersistenceTest >> persistenceClass [
	^ GlobalIdentifierStonPersistence
]

{ #category : #running }
GlobalIdentifierStonPersistenceTest >> setUpPreferences [
	| memory |
	memory := FileSystem memory.
	preferences := memory workingDirectory / self folderName / 'pharoX' / 'preferences.ston'.
	preferences ensureDelete.
]
