"
This is a utility class for printing objects to Text or String
"
Class {
	#name : #GTObjectPrinter,
	#superclass : #Object,
	#category : #'GT-Inspector'
}

{ #category : #printing }
GTObjectPrinter >> asFullTextFrom: anObject [
	^ [ Text fromString: (anObject asString replaceAll: String cr with: String space) ] 
			on: Error 
			do: [ Text string: 'error printing' attribute: TextColor red ]
]

{ #category : #printing }
GTObjectPrinter >> asTruncatedTextFrom: anObject [
	^ self asTruncatedTextTo: 50 from: anObject
]

{ #category : #printing }
GTObjectPrinter >> asTruncatedTextTo: anInteger from: anObject [
	^ [ Text fromString: ((anObject asString contractTo: anInteger) replaceAll: String cr with: String space) ] 
			on: Error 
			do: [ Text string: 'error printing' attribute: TextColor red ]
]
