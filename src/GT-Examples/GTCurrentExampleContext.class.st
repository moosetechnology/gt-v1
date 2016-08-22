"
I model a dynamic variable to keep track of the example that is being processed right now. I am particurly useful to allow after methods to utilize information from this context.
"
Class {
	#name : #GTCurrentExampleContext,
	#superclass : #Notification,
	#category : #'GT-Examples-Runtime'
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
