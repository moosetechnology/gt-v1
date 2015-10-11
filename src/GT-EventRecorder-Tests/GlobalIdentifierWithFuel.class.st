Class {
	#name : #GlobalIdentifierWithFuel,
	#superclass : #GlobalIdentifierTest,
	#category : #'GT-EventRecorder-Tests-Identifier'
}

{ #category : #accessing }
GlobalIdentifierWithFuel >> fileName [
	^ 'preferences.fuel'
]

{ #category : #running }
GlobalIdentifierWithFuel >> setUpPersistenceStrategy [
	identifier persistenceStrategy: GlobalIdentifierPersistence fuel.
	identifier persistenceStrategy preferences: preferences
]
