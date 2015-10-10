Class {
	#name : #GlobalIdentifierWithSton,
	#superclass : #GlobalIdentifierTest,
	#category : #'GT-EventRecorder-Tests'
}

{ #category : #accessing }
GlobalIdentifierWithSton >> fileName [
	^ 'preferences.ston'
]

{ #category : #running }
GlobalIdentifierWithSton >> setUpPersistenceStrategy [
	identifier persistenceStrategy: GlobalIdentifierPersistence ston.
	identifier persistenceStrategy preferences: preferences
]
