Extension { #name : #RTView }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTView >> spotterElementsFor: aStep [
	<spotterOrder: 10>
	^ aStep listProcessor
		title: 'Elements';
		candidatesLimit: 100;
		allCandidates: [ self elements ];
		itemName: [ :each | each model gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTView >> spotterPreviewIn: aComposite [
	<spotterPreview: 10>
	
	self build.
	aComposite addBrickBack: self view setUpCanvas buildMorph

	
]
