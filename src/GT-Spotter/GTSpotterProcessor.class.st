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
	anObject spotterActDefault: aStep
]

{ #category : #public }
GTSpotterProcessor >> allFilteredCandidates [
	^ allFilteredCandidates ifNil: [ allFilteredCandidates := OrderedCollection new ]
]

{ #category : #private }
GTSpotterProcessor >> basicFilterInContext: aSpotterContext [
	
	self prepareProcessorInContext: aSpotterContext.
	(self shouldFilterInContext: aSpotterContext) ifTrue: [
		allFilteredCandidates := self doFilterInContext: aSpotterContext ].
	aSpotterContext stream 
		performSymbol: #onAmountChanged:in: 
		withArguments: { self allFilteredCandidates size . self }
]

{ #category : #private }
GTSpotterProcessor >> doFilterInContext: aSpotterContext [
	"override this method to:
	- add items to the stream
	- return all found items at the end"
	self subclassResponsibility
]

{ #category : #'accessing-dynamic' }
GTSpotterProcessor >> exceptionHandler [
	self flag: 'Bloc -> overrides doesNotUnderstand discarding the current exception context'.
	^ GTCurrentSpotterExceptionHandler value ifNil: [ GTSpotterExceptionHandlerNotFound signal ]
]

{ #category : #private }
GTSpotterProcessor >> filterInContext: aSpotterContext [
	[ self basicFilterInContext: aSpotterContext ]
		on: Error 
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ ('[Spotter] Exception in processor <', self title asString, '>: ', exception asString) logCr ] ]
]

{ #category : #printing }
GTSpotterProcessor >> gtDisplayOn: stream [
	stream 
		nextPutAll: 'Processor: ';
		nextPutAll: self title asString
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
