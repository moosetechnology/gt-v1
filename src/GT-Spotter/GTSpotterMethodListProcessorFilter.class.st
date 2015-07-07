"
I implement a filtering strategy for processors based on method signatures (method selector and class).

I only allow processor created by a method currently added to the filter.

For examples view my class side methods in teh category 'example'
"
Class {
	#name : #GTSpotterMethodListProcessorFilter,
	#superclass : #GTSpotterProcessorFilter,
	#instVars : [
		'selectedMethodSignatures'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleHelpSearch [
	"A spotter for searching through help pages.
	
	self exampleHelpSearch
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: (GTSpotter
			withProcessors: {
				GTSpotter>>#spotterForHelpTopicFor:.
				HelpTopic>>#spotterForHelpTopicFor:});
		openCenteredInWorld
]

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleWorldMenuSearch [
	"A spotter for searching through the world menu.
	
	self exampleWorldMenuSearch
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: (GTSpotter
			withProcessors: {
				GTSpotter>>#spotterWorldMenuFor:});
		openCenteredInWorld
]

{ #category : #adding }
GTSpotterMethodListProcessorFilter >> addSignatureFor: aMethod [
	|signature|
	
	signature := self signatureFor: aMethod.
	(selectedMethodSignatures includes: signature) ifFalse: [ selectedMethodSignatures add: signature ].
	
]

{ #category : #adding }
GTSpotterMethodListProcessorFilter >> addSignaturesFor: aMethodsList [
	
	aMethodsList do: [ :aMethod | self addSignatureFor: aMethod ]
]

{ #category : #initialization }
GTSpotterMethodListProcessorFilter >> initialize [
	super initialize.

	selectedMethodSignatures := OrderedCollection new.
]

{ #category : #printing }
GTSpotterMethodListProcessorFilter >> printSignature: aSignature [

	^ aSignature first name, '>>', aSignature second asString
]

{ #category : #testing }
GTSpotterMethodListProcessorFilter >> shouldEnableProcessorsCreateBy: aMethod [

	^ selectedMethodSignatures anySatisfy: [ :aSignature | 
		aSignature first = aMethod methodClass and: [ aSignature second = aMethod selector ] ]
]

{ #category : #accessing }
GTSpotterMethodListProcessorFilter >> signatureFor: aMethod [

	^ {aMethod methodClass . aMethod selector}
]
