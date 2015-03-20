Class {
	#name : #GTImplementorsSpotterTest,
	#superclass : #TestCase,
	#instVars : [
		'stream',
		'processor',
		'spotter',
		'context'
	],
	#category : #'GT-Tests-Spotter'
}

{ #category : #helpers }
GTImplementorsSpotterTest >> assertFinds: aMethod [
	self resetStream.
	spotter find.
	self assert: (stream objects includes: aMethod)
]

{ #category : #helpers }
GTImplementorsSpotterTest >> assertIncludes [
	self shouldBeImplemented.
]

{ #category : #helpers }
GTImplementorsSpotterTest >> assertIncludes: aMethod [
	self should: [ stream objects anySatisfy: [ :each | each methodClass = aMethod methodClass and: [ each selector = aMethod selector ]] ]
]

{ #category : #helpers }
GTImplementorsSpotterTest >> assertSpotterFinds: anObject withQuery: aQuery restrictingTo: behaviors [ 
	context := self contextWithQuery: aQuery.
	spotter := GTImplementorsSpotter new 
		behaviors: behaviors; 
		limit: 5; 
		context: context; 
		yourself.
	self assertFinds: anObject
]

{ #category : #helpers }
GTImplementorsSpotterTest >> contextWithQuery: aString [
	^ GTSpotterContext new 
		text: aString;
		stream: stream;
		yourself
]

{ #category : #helpers }
GTImplementorsSpotterTest >> contextWithoutQuery [
	^ self contextWithQuery: nil
]

{ #category : #helpers }
GTImplementorsSpotterTest >> denyIncludes: aMethod [
	self shouldnt: [ stream objects anySatisfy: [ :each | each methodClass = aMethod methodClass and: [ each selector = aMethod selector ] ] ]
]

{ #category : #helpers }
GTImplementorsSpotterTest >> findWithQuery: aQuery [
	self resetStream.
	spotter find: (self contextWithQuery: aQuery)
]

{ #category : #helpers }
GTImplementorsSpotterTest >> resetStream [
	stream := GTSpotterStreamMock new.
	context ifNotNil: [ context stream: stream ]
]

{ #category : #tests }
GTImplementorsSpotterTest >> testCaseInsensitivity [
	self
		assertSpotterFinds: GTImplementorsSpotterMock1 >> #doSomething
		withQuery: 'dosomething'
		restrictingTo: {GTImplementorsSpotterMock1}
]

{ #category : #tests }
GTImplementorsSpotterTest >> testNonPrefixMatch [
	self
		assertSpotterFinds: GTImplementorsSpotterMock1 >> #doSomethingElse
		withQuery: 'somethingElse'
		restrictingTo: {GTImplementorsSpotterMock1}
]

{ #category : #tests }
GTImplementorsSpotterTest >> testPrefixMatchComeFirst [
	spotter := GTImplementorsSpotter new
		behaviors: {GTImplementorsSpotterMock1};
		yourself.
		
	"There are 5 methods GTImplementsSpotterMock1>>something.*"
	spotter limit: 5.
	self findWithQuery: 'doSomething'.
	self assertIncludes: GTImplementorsSpotterMock1 >> #doSomething.
	
	self findWithQuery: 'something'.
	"In this case, #doSomething is not included because there are already 5 answers with the 'something' prefix"
	self denyIncludes: GTImplementorsSpotterMock1 >> #doSomething.
	
	"#doSomething is included again because the spotter's limit is greater than the number of methods with the 'something' prefix"
	spotter limit: 7.
	self findWithQuery: 'something'.
	self assertIncludes: GTImplementorsSpotterMock1 >> #doSomething
]
