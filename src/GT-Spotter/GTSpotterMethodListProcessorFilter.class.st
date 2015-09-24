"
I implement a filtering strategy for processors based on method signatures (method selector and class).

I only allow processors created by a method currently added to the filter.

I can attach to each processor a configuration block.

For examples view my class side methods in teh category 'example'
"
Class {
	#name : #GTSpotterMethodListProcessorFilter,
	#superclass : #GTSpotterProcessorFilter,
	#instVars : [
		'selectedMethodSignatures',
		'configurationBlocks'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleCustomImplementorsSearch [
	"A spotter for searching through the implementors of a method that 
	overrides properties of the search step.
	
	self exampleCustomImplementorsSearch
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: ((GTSpotter on: Object>>#copy) 
			processorsFilter: (GTSpotterMethodListProcessorFilter new 
				allowProcessorsFrom: CompiledMethod>>#spotterForImplementorsFor: 
				configuredWith: [ :aProcessor | aProcessor
					actLogic: [ :aMethod :step | 
						step exit.
						aMethod inform: aMethod name ];
					candidatesLimit: 50 ]));
		openCenteredInWorld
]

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleCustomImplementorsSearchWithNavigation [
	"A spotter for searching through the implementors of a method that 
	overrides properties of the search step and enables the Collection 
	processor (to allow dive in).
	
	self exampleCustomImplementorsSearchWithNavigation
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: ((GTSpotter on: Object>>#copy) 
			processorsFilter: (GTSpotterMethodListProcessorFilter new 
				allowProcessorsFrom: Collection>>#spotterItemsFor:;
				allowProcessorsFrom: CompiledMethod>>#spotterForImplementorsFor: 
				configuredWith: [ :aProcessor | aProcessor
					actLogic: [ :aMethod :step | 
						step exit.
						aMethod inform: aMethod name ];
					candidatesLimit: 50 ]));
		openCenteredInWorld
]

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleHelpSearch [
	"A spotter for searching through help pages.
	
	self exampleHelpSearch
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: (GTSpotter new
			filterByMethods: {
				GTSpotter>>#spotterForHelpTopicFor:.
				HelpTopic>>#spotterForHelpTopicFor:});
		openCenteredInWorld
]

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleImplementorsSearch [
	"A spotter for searching through the implementors of a method.
	
	self exampleImplementorsSearch
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: ((GTSpotter on: Object>>#copy) 
			filterByMethods: {
				CompiledMethod>>#spotterForImplementorsFor:});
		openCenteredInWorld
]

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleMenuMorphSearch [
	"A spotter for searching through the menu morphs.
	
	self exampleMenuMorphSearch
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: ((GTSpotter on: World worldMenu) 
			filterByMethods: {
				MenuMorph>>#spotterItemsFor:});
		openCenteredInWorld
]

{ #category : #examples }
GTSpotterMethodListProcessorFilter class >> exampleWorldMenuSearch [
	"A spotter for searching through the world menu.
	
	self exampleWorldMenuSearch
	"
	
	GTSpotterMorph new
		extent: 400@500;
		spotterModel: (GTSpotter new
			filterByMethods: {
				GTSpotter>>#spotterWorldMenuFor:});
		openCenteredInWorld
]

{ #category : #adding }
GTSpotterMethodListProcessorFilter >> allowProcessorsFrom: aMethod [
	|signature|
	
	signature := self signatureFor: aMethod.
	(selectedMethodSignatures includes: signature) ifFalse: [ selectedMethodSignatures add: signature ].
	
]

{ #category : #adding }
GTSpotterMethodListProcessorFilter >> allowProcessorsFrom: aMethod configuredWith: aBlock [
	
	self allowProcessorsFrom: aMethod.
	configurationBlocks at: aMethod name put: aBlock.
	
]

{ #category : #accessing }
GTSpotterMethodListProcessorFilter >> configurationBlockForProcessorsCreatedBy: aMethod [
	
	^ configurationBlocks at: aMethod name ifAbsent: [ self nullConfigurationBlock ]
]

{ #category : #initialization }
GTSpotterMethodListProcessorFilter >> initialize [
	super initialize.

	selectedMethodSignatures := OrderedCollection new.
	configurationBlocks := Dictionary new.
]

{ #category : #accessing }
GTSpotterMethodListProcessorFilter >> nullConfigurationBlock [

	^ [ :processor | ]
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
