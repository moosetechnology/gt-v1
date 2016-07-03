Class {
	#name : #GTCurrentExampleContext,
	#superclass : #Notification,
	#category : #'GT-Examples-Tools'
}

{ #category : #'accessing-defaults' }
GTCurrentExampleContext class >> defaultValue [
	^ nil
]

{ #category : #evaluating }
GTCurrentExampleContext class >> use: anObject during: aBlock [
	^ aBlock 
		on: self 
		do: [ :notification | notification resume: anObject ]
]

{ #category : #evaluating }
GTCurrentExampleContext class >> value [
	^ self signal
]

{ #category : #'accessing-defaults' }
GTCurrentExampleContext >> defaultAction [
	^ self class defaultValue
]
