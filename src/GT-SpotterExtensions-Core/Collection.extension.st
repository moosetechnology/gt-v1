Extension { #name : #Collection }

{ #category : #'*GT-SpotterExtensions-Core' }
Collection >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	| processor |
	self ifEmpty: [ ^ self ].
	processor := aStep previousProcessorFrom: self.
	^ aStep listProcessor
		title: processor title;
		candidatesLimit: 100;
		items: [ OrderedCollection newFrom: (self collect: [ :each | each asSpotterCandidateLink value]) ];
		itemName: processor itemName;
		itemFilterName: processor itemFilterName;
		filter: processor filter gtListFilter;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-Core' }
Collection >> spotterSelectFor: aStep [
	<spotterOrder: 40>
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Expression selection';
		filter: GTNullFilter item: [ :filter :context |
			self do: [ :each |
				[ (Smalltalk compiler 
						evaluate: '| each | each := self. ', context text 
						for: each asSpotterCandidateLink value
						notifying: nil
						logged: false) ifTrue: [ filter value: each ]  ] on: Exception do: [ " ignore this item, continue with the next one " ] ] ]
]
