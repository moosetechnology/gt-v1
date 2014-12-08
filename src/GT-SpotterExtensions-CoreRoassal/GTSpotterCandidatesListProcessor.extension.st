Extension { #name : #GTSpotterCandidatesListProcessor }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
GTSpotterCandidatesListProcessor >> matchSubstringByQueryParts [
	self filter: [ :originalQuery :stream | | query aCollection|
				query := originalQuery trimBoth asLowercase.
				query isEmpty 
					ifTrue: [ self streamAllCandidatesOn: stream ]
					ifFalse: [
							aCollection := OrderedCollection new.
							self allCandidates do: [ :each | 
								(each matchesQuery: (originalQuery trimBoth asLowercase splitOn: ' ')) 
									ifTrue: [ 
										aCollection add: each.
										aCollection size > 5 ifFalse: [ stream addObject: each inProcessor: self ] ] ] ].
				aCollection ]
]
