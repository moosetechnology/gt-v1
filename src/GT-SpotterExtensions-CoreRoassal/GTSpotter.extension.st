Extension { #name : #GTSpotter }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
GTSpotter >> spotterRoassalExamplesFor: aStep [
	<spotterOrder: 500>
	| processor |
	processor := aStep listProcessor.
	processor 
			allCandidates: [ (RTAbstractExample allSubclasses collect: #new) 
				flatCollect: [ :each | each gtExamples ] ];
			title: 'Roassal Examples';
			itemName: [ :example | example selector ];
			itemIcon: [ :example ||icon64Mime|
				icon64Mime := example exampleObject perform: (example selector, 'Icon') asSymbol.
				Form fromBinaryStream: 
							(Base64MimeConverter mimeDecodeToBytes: icon64Mime readStream) ];
			filter: [ :originalQuery :stream | | query aCollection|
				query := originalQuery trimBoth asLowercase.
				query isEmpty 
					ifTrue: [ processor streamAllCandidatesOn: stream ]
					ifFalse: [
							aCollection := OrderedCollection new.
							processor allCandidates do: [ :each | 
								(each matchesQuery: (originalQuery trimBoth asLowercase splitOn: ' ')) 
									ifTrue: [ 
										aCollection add: each.
										aCollection size > 5 ifFalse: [ stream addObject: each inProcessor: processor ] ] ] ].
				aCollection ];
			wantsToDisplayOnEmptyQuery: true
]
