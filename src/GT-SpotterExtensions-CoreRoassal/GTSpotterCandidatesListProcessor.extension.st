Extension { #name : #GTSpotterCandidatesListProcessor }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
GTSpotterCandidatesListProcessor >> matchSubstringByQueryParts [
	self filter: [ :originalQuery :stream | 
		| query queryFragments aCollection |
		query := originalQuery trimBoth asLowercase.
		query isEmpty 
			ifTrue: [ self streamAllCandidatesOn: stream ]
			ifFalse: [
					aCollection := OrderedCollection new.
					queryFragments := originalQuery trimBoth asLowercase splitOn: ' '.
					self allCandidates do: [ :each | 
						(each matchesQuery: queryFragments) 
							ifTrue: [ 
								aCollection add: each.
								aCollection size > 5 ifFalse: [ stream addObject: each inProcessor: self ] ] ] ].
		aCollection ]
]
