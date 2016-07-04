Class {
	#name : #GTExampleMethodSubject,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Utils'
}

{ #category : #ui }
GTExampleMethodSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	aSelectorEnvironment addClass: self methodClass selector: self selector
]

{ #category : #'accessing-dynamic' }
GTExampleMethodSubject >> asGTExampleSubject [
	^ self
]

{ #category : #ui }
GTExampleMethodSubject >> forNautilus: aBlock [
	aBlock
		value: #'Browse method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #ui }
GTExampleMethodSubject >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 102>
	aStep listProcessor
		title: 'Examples with Subject ', self gtDisplayString;
		filter: GTNullFilter item: [ :filter :context | 
			GTExampleOrganizer instance examplesDo: [ :cn :s :example |
				(example hasSubject: self) ifTrue: [ filter value: example ] ] ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #ui }
GTExampleMethodSubject >> gtSpotterPreviewIn: aComposite [
	<spotterPreview: 1>
	self hasMethod ifFalse: [ ^ self ].
	aComposite pharoMethod
		title: [ self gtDisplayString ]; 
		display: [ :entity | entity method sourceCode ];
		smalltalkClass: [ self method methodClass ];
		entity: self
]

{ #category : #testing }
GTExampleMethodSubject >> hasLiteralThorough: aLiteral [
	^ self selector = aLiteral
		or: [ self hasMethod
			and: [ self method hasLiteralThorough: aLiteral ] ]
]
