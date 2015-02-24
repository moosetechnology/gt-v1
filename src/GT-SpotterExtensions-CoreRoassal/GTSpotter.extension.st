Extension { #name : #GTSpotter }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
GTSpotter >> spotterRoassalExamplesFor: aStep [
	<spotterOrder: 500>
	aStep listProcessor 
			allCandidates: [ (RTAbstractExample allSubclasses collect: #new) 
				flatCollect: [ :each | each gtExamples ] ];
			title: 'Roassal Examples';
			itemName: [ :example | example selector ];
			itemIcon: [ :example | [example iconForm] on: Error do: [ Form extent: 16@16  ] ];
			filter: (GTFilterBlock new 
				matcher: [ :item :context |
					item matchesQuery: (context cacheAt: #queryForRoassalExamples ifAbsentPut: [ context textLowercase splitOn: ' ' ]) ];
				yourself);
			wantsToDisplayOnEmptyQuery: false
]
