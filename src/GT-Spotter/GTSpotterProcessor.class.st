"
This is the abstract class that models a processor that is associated with a spotter category. It can spot items to be displayed in that category by reacting to a filter: message. 
"
Class {
	#name : #GTSpotterProcessor,
	#superclass : #Object,
	#instVars : [
		'allFilteredCandidates'
	],
	#category : #'GT-Spotter-Processors'
}

{ #category : #public }
GTSpotterProcessor >> actOn: anObject for: aStep [
	aStep exit.	
	anObject spotterActDefault.

]

{ #category : #public }
GTSpotterProcessor >> allFilteredCandidates [
	^ allFilteredCandidates ifNil: [ allFilteredCandidates := OrderedCollection new ]
]

{ #category : #public }
GTSpotterProcessor >> doFilter: aStringQuery on: aStream [
	"override this method to:
	- add items to the stream
	- return all found items at the end"
	self subclassResponsibility
]

{ #category : #public }
GTSpotterProcessor >> filter: aStringQuery on: aStream [
	
	allFilteredCandidates := nil.
	(aStringQuery notEmpty or: [ self wantsToDisplayOnEmptyQuery ]) ifTrue: [
		allFilteredCandidates := self doFilter: aStringQuery on: aStream ].
	aStream 
		performSymbol: #onAmountChanged:in: 
		withArguments: { self allFilteredCandidates size . self }
]

{ #category : #ui }
GTSpotterProcessor >> render: anObject [
	^ GTSpotterItemBrick new
		icon: (nil);
		text: (anObject gtDisplayString)
]

{ #category : #accessing }
GTSpotterProcessor >> title [
	self subclassResponsibility
]

{ #category : #testing }
GTSpotterProcessor >> wantsToDisplayOnEmptyQuery [
	^ true
]
