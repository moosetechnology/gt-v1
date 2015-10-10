Class {
	#name : #GlobalIdentifierStonPersistence,
	#superclass : #GlobalIdentifierPersistence,
	#category : #'GT-EventRecorder-Identifiers'
}

{ #category : #initialization }
GlobalIdentifierStonPersistence >> initilizePreferences [
	^ FileLocator preferences / 'org.pharo.global-identifiers.ston'
]
