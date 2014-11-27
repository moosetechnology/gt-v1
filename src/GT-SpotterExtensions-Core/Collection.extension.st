Extension { #name : #Collection }

{ #category : #'*GT-SpotterExtensions-Core' }
Collection >> spotterItemsFor: aStep [
	<spotterOrder: 10>
	^ aStep listProcessor
		title: 'Items';
		allCandidates: [ self ];
		itemName: [ :each | each gtDisplayString ];
		matchSubstring;
		wantsToDisplayOnEmptyQuery: true
]
