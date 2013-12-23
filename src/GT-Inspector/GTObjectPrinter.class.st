"
This is a utility class for printing objects to Text or String
"
Class {
	#name : #GTObjectPrinter,
	#superclass : #Object,
	#category : #'GT-Inspector'
}

{ #category : #printing }
GTObjectPrinter >> asNonTruncatedTextFrom: anObject [
	^ [ Text fromString: (anObject asString replaceAll: String cr with: String space) ] 
			on: Error 
			do: [ Text string: 'error printing' attribute: TextColor red ]
]

{ #category : #printing }
GTObjectPrinter >> asTruncatedTextFrom: anObject [
	^ [ Text fromString: ((anObject gtDisplayString contractTo: 50) replaceAll: String cr with: String space) ]
		on: Error
		do: [ Text string: 'error printing' attribute: TextColor red ]
]
