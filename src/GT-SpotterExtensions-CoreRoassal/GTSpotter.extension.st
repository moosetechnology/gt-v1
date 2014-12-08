Extension { #name : #GTSpotter }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
GTSpotter >> spotterRoassalExamplesFor: aStep [
	<spotterOrder: 500>
	aStep listProcessor 
			allCandidates: [ (RTAbstractExample allSubclasses collect: #new) 
				flatCollect: [ :each | each gtExamples ] ];
			title: 'Roassal Examples';
			itemName: [ :example | example selector ];
			itemIcon: [ :example | example iconForm ];
			matchSubstringByQueryParts;
			wantsToDisplayOnEmptyQuery: false
]
