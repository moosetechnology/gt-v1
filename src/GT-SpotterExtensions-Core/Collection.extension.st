Extension { #name : #Collection }

{ #category : #'*GT-SpotterExtensions-Core' }
Collection >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	| processor |
	self isEmpty ifTrue: [ ^ self ].
	(self allSatisfy: [ :each | 
		each class = GTSpotterCandidateLink ])
		ifFalse: [ ^ self ].
	processor := aStep previousProcessorFrom: self.
	^ aStep listProcessor
		title: processor title;
		candidatesLimit: 100;
		allCandidates: [ OrderedCollection newFrom: (self collect: #value)];
		itemName: processor itemName;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
Collection >> spotterSelectFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
		title: 'Expression selection';
		filter: [ :context | 
			[
				| result |
				Transcript show: self; cr.
				Transcript show: context text; cr.
				result := self select: [ :each |
					Smalltalk compiler 
						evaluate: '| each | each := self. ', context text 
						for: each 
						logged: false ].
				Transcript show: result; cr.
				context addItems: result.
				result
			] on: Error do: [ #() ] ]
]
