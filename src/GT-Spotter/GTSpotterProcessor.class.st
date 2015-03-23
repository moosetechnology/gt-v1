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

{ #category : #private }
GTSpotterProcessor >> actOn: anObject for: aStep [
	aStep exit.	
	anObject spotterActDefault.

]

{ #category : #public }
GTSpotterProcessor >> allFilteredCandidates [
	^ allFilteredCandidates ifNil: [ allFilteredCandidates := OrderedCollection new ]
]

{ #category : #private }
GTSpotterProcessor >> doFilterInContext: aSpotterContext [
	"override this method to:
	- add items to the stream
	- return all found items at the end"
	self subclassResponsibility
]

{ #category : #private }
GTSpotterProcessor >> filterInContext: aSpotterContext [
	
	self prepareProcessorInContext: aSpotterContext.
	(self shouldFilterInContext: aSpotterContext) ifTrue: [
		allFilteredCandidates := self doFilterInContext: aSpotterContext ].
	aSpotterContext stream 
		performSymbol: #onAmountChanged:in: 
		withArguments: { self allFilteredCandidates size . self }
]

{ #category : #private }
GTSpotterProcessor >> prepareProcessorInContext: aContext [
	allFilteredCandidates := nil
]

{ #category : #private }
GTSpotterProcessor >> render: anObject [
	^ GTSpotterItemBrick new
		icon: (nil);
		text: (anObject gtDisplayString)
]

{ #category : #testing }
GTSpotterProcessor >> shouldFilterInContext: aSpotterContext [
	^ aSpotterContext notEmpty 
		or: [ self wantsToDisplayOnEmptyQuery ]
]

{ #category : #accessing }
GTSpotterProcessor >> title [
	self subclassResponsibility
]

{ #category : #accessing }
GTSpotterProcessor >> wantsToDisplayOnEmptyQuery [
	^ true
]
