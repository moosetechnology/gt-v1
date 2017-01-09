Class {
	#name : #GlobalIdentifierWithSton,
	#superclass : #GlobalIdentifierTest,
	#category : #'GT-EventRecorder-Tests-Identifier'
}

{ #category : #accessing }
GlobalIdentifierWithSton >> actualPreferencesFileName [
	^ 'preferences.ston'
]

{ #category : #running }
GlobalIdentifierWithSton >> setUpPersistenceStrategy [
	identifier persistenceStrategy: GlobalIdentifierPersistence ston.
	identifier persistenceStrategy preferences: preferences
]
