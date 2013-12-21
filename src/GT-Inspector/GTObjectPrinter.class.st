"
This is a utility class for printing objects to Text or String
"
Class {
	#name : #GTObjectPrinter,
	#superclass : #Object,
	#category : #'GT-Inspector'
}

{ #category : #'as yet unclassified' }
GTObjectPrinter >> asSimpleTextFrom: anObject [
	^ [ Text fromString: ((anObject asString contractTo: 50) replaceAll: String cr with: String space) ] 
			on: Error 
			do: [ Text string: 'error printing' attribute: TextColor red ]
]
