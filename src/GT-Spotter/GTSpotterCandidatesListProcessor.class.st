"
This is a candidates processor that can be parameterized via blocks.
"
Class {
	#name : #GTSpotterCandidatesListProcessor,
	#superclass : #GTSpotterCandidatesProcessor,
	#instVars : [
		'allCandidatesBlock',
		'candidatesLimit',
		'queryMatchingBlock',
		'title',
		'itemNameBlock',
		'itemIconBlock',
		'actBlock',
		'wantsToDisplayOnEmptyQuery',
		'filterBlock'
	],
	#category : #'GT-Spotter-Processors'
}

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> actLogic: aBlockWithTwoArguments [

	actBlock := aBlockWithTwoArguments
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> actOn: anObject for: aStep [
	
	actBlock
		ifNil: [ super actOn: anObject for: aStep ]
		ifNotNil: [ actBlock cull: anObject cull: aStep ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> allCandidates: aBlockWithOneArgument [
	allCandidatesBlock := aBlockWithOneArgument 
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> candidatesLimit [
	^ candidatesLimit ifNil: [ 5 ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> candidatesLimit: anInteger [
	candidatesLimit := anInteger
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> computeCandidates [
	^ allCandidatesBlock cull: self origin
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> doFilter: aStringQuery on: aStream [
	<todo: #filterRefactoring description: 'remove nil check - use default empty filter'>
	^ filterBlock isNil
		ifTrue: [ 
			Transcript show:'obsolete behaviour ??? '; show: aStringQuery; show: ' '; show: self class name; cr.
			super doFilter: aStringQuery on: aStream ]
		ifFalse: [ filterBlock value: aStringQuery value: aStream ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> filter: aBlockWithTwoArguments [
	filterBlock := aBlockWithTwoArguments 
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> filter: aStringQuery on: aStream [
	<hack: 'is there a better way to debug gt/spotter? it is very hard to detect exceptions and to debug them - this is just a very dirty hack'>
	[ super filter: aStringQuery on: aStream ]
		on: Error 
		do: [ :e | ('[Spotter] Exception in processor <', self title asString, '>: ', e asString) logCr ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> filterUsing: aFilterObject [
	self filter: (aFilterObject model: self)
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> is: anObject matching: aString [
	^ queryMatchingBlock 
		value: anObject
		value: aString
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> itemIcon: aBlockWithOneArgument [
	itemIconBlock := aBlockWithOneArgument
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> itemIconFor: anObject [
	^ itemIconBlock isNil
		ifTrue: [ super itemIconFor: anObject ]
		ifFalse: [ itemIconBlock cull: anObject ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> itemName: aBlockWithOneArgument [
	itemNameBlock := aBlockWithOneArgument
]

{ #category : #private }
GTSpotterCandidatesListProcessor >> itemNameFor: anObject [
	^ itemNameBlock isNil
		ifTrue: [ super itemNameFor: anObject ]
		ifFalse: [ itemNameBlock cull: anObject ]
]

{ #category : #OBSOLETE }
GTSpotterCandidatesListProcessor >> matchAlike [
	<demoOnly: 'filtering is not very nice yet - all filters duplicate one another - this should be refactored into a more moldable approach / maybe even a default filter action, so it could be configured globally ?'>
	<magicNumber: 0.33 description: 'lower threshold: to cut off the large irrelevent chunk before sorting/filtering is appplied' author: 'StefanReichhart'>
	<magicNumber: 0.45 description: 'upper threshold: to keep a reasonably sized set of interesting matches' author: 'StefanReichhart'>
	self filter: [ :originalQuery :stream |
		| prefixMatchers rest query lowerThreshold allCandidatesPreprocessed threshold |
		"if filter is empty we stream all candidates"
		query := originalQuery trimBoth asLowercase.
		query isEmpty 
			ifTrue: [ self streamAllCandidatesOn: stream ]
			ifFalse: [
				prefixMatchers := OrderedCollection  new.
				rest := OrderedCollection new.				
				allCandidatesPreprocessed := OrderedCollection streamContents: [ :candidates | 
					lowerThreshold := 0.33 * query size.
					self allCandidates do: [ :each | 
						| weight |
						(weight := (self itemNameFor: each) alike: query) > lowerThreshold ifTrue: [
							candidates nextPut: (Array with: weight with: each) ] ] ].
				threshold := allCandidatesPreprocessed isEmpty 
					ifTrue: [ 0.45 ]
					ifFalse: [
						allCandidatesPreprocessed := allCandidatesPreprocessed asSortedCollection: [ :a :b | a first > b first ].
						(allCandidatesPreprocessed collect: [ :each | each first ]) median " try an adaptive threshold (slow) " ].
				allCandidatesPreprocessed do: [ :each | 
					each first >= threshold 
						ifTrue: [
							prefixMatchers add: each last.
							prefixMatchers size > self candidatesLimit ifFalse: [ 
								stream addObject: each last inProcessor: self ] ]
						ifFalse:[ rest add: each last ] ].
				(prefixMatchers size < self candidatesLimit) ifTrue: [ 
					(rest first: ((self candidatesLimit - prefixMatchers size) min: rest size)) do: [ :each |
						stream addObject: each inProcessor: self ] ].
				prefixMatchers , rest ] ] 
]

{ #category : #OBSOLETE }
GTSpotterCandidatesListProcessor >> matchLogic: aBlockWithTwoArguments [
	queryMatchingBlock := aBlockWithTwoArguments
]

{ #category : #OBSOLETE }
GTSpotterCandidatesListProcessor >> matchMultipleSubstrings [
	<demoOnly: 'filtering is not very nice yet - all filters duplicate one another - this should be refactored into a more moldable approach / maybe even a default filter action, so it could be configured globally ?'>
	self filter: [ :originalQuery :stream |
		| prefixMatchers rest candidateItemName query queryFragments |
		"if filter is empty we stream all candidates"
		query := originalQuery trimBoth asLowercase.
		query isEmpty 
			ifTrue: [ self streamAllCandidatesOn: stream ]
			ifFalse: [
				queryFragments := query substrings: ' '.
				prefixMatchers := OrderedCollection  new.
				rest := OrderedCollection new.
				self allCandidates do: [:each | 
					candidateItemName := self itemNameFor: each.
					(queryFragments allSatisfy: [ :fragment | candidateItemName includesSubstring: fragment  caseSensitive: false ])
							ifTrue: [ 
									prefixMatchers add: each.
									prefixMatchers size > self candidatesLimit ifFalse: [ 
										stream addObject: each inProcessor: self ]]
							ifFalse: [ rest add: each ] ] ].
				(prefixMatchers size < self candidatesLimit) ifTrue: [ 
					(rest first: ((self candidatesLimit - prefixMatchers size) min: rest size)) do: [ :each |
						stream addObject: each inProcessor: self ] ].
				prefixMatchers , rest ]
]

{ #category : #OBSOLETE }
GTSpotterCandidatesListProcessor >> matchRegex [
	<demoOnly: 'filtering is not very nice yet - all filters duplicate one another - this should be refactored into a more moldable approach / maybe even a default filter action, so it could be configured globally ?'>
	self filter: [ :originalQuery :stream |
		| prefixMatchers rest candidateItemName query regex |
		"if filter is empty we stream all candidates"
		query := originalQuery trimBoth.
		query isEmpty 
			ifTrue: [ self streamAllCandidatesOn: stream ]
			ifFalse: [
				regex := [ query asRegexIgnoringCase ] on: Error do: [ ^ #() ].
				prefixMatchers := OrderedCollection  new.
				rest := OrderedCollection new.
				self allCandidates do: [:each | 
					candidateItemName := self itemNameFor: each.
					(regex matches: candidateItemName)
							ifTrue: [ 
									prefixMatchers add: each.
									prefixMatchers size > self candidatesLimit ifFalse: [ 
										stream addObject: each inProcessor: self ]]
							ifFalse: [ rest add: each ] ] ].
				(prefixMatchers size < self candidatesLimit) ifTrue: [ 
					(rest first: ((self candidatesLimit - prefixMatchers size) min: rest size)) do: [ :each |
						stream addObject: each inProcessor: self ] ].
				prefixMatchers , rest ]
]

{ #category : #OBSOLETE }
GTSpotterCandidatesListProcessor >> matchSubstring [
	self filter: [ :originalQuery :stream |
		| prefixMatchers rest query |
		"if filter is empty we stream all candidates"
		query := originalQuery trimBoth asLowercase.
		query isEmpty 
			ifTrue: [ self streamAllCandidatesOn: stream ]
			ifFalse: [
				prefixMatchers := OrderedCollection  new.
				rest := OrderedCollection new.
				self allCandidates do: [:each | 
					| index |
					index := (self itemNameFor: each) findString: query startingAt: 1 caseSensitive: false.
					index >= 1 ifTrue: [
						index = 1 
							ifTrue: [ 
									prefixMatchers add: each.
									prefixMatchers size > self candidatesLimit ifFalse: [ 
										stream addObject: each inProcessor: self ]]
							ifFalse: [ rest add: each ]]].
				(prefixMatchers size < self candidatesLimit) ifTrue: [ 
					(rest first: ((self candidatesLimit - prefixMatchers size) min: rest size)) do: [ :each |
						stream addObject: each inProcessor: self ] ].
				prefixMatchers , rest ] ]
]

{ #category : #accessing }
GTSpotterCandidatesListProcessor >> title [
	^ title ifNil: [ super title ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> title: aString [
	title := aString
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery [
	^ wantsToDisplayOnEmptyQuery ifNil: [ super wantsToDisplayOnEmptyQuery ]
]

{ #category : #scripting }
GTSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery: anObject [
	wantsToDisplayOnEmptyQuery := anObject
]
