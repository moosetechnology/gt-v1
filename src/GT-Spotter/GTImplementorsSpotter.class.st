Class {
	#name : #GTImplementorsSpotter,
	#superclass : #Object,
	#instVars : [
		'query',
		'stream',
		'processor',
		'behaviors',
		'limit'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #accessing }
GTImplementorsSpotter >> behaviors: aCollection [ 
	behaviors := aCollection
]

{ #category : #action }
GTImplementorsSpotter >> find [
	| prefixMatchers rest |
	query isEmpty
		ifFalse: [ 
			prefixMatchers := OrderedCollection new.
			rest := OrderedCollection new.
			behaviors
				do: [ :class | 
					class
						selectorsDo: [ :selector | 
							| index |
							index := selector findString: query startingAt: 1 caseSensitive: false.
							index >= 1
								ifTrue: [ 
									| method |
									method := class >> selector.
									index = 1
										ifTrue: [ 
											prefixMatchers add: method.
											prefixMatchers size > limit
												ifFalse: [ stream addObject: method inProcessor: processor ] ]
										ifFalse: [ rest add: method ] ] ] ].
			prefixMatchers size < limit
				ifTrue: [ (rest first: (limit - prefixMatchers size min: rest size)) do: [ :each | stream addObject: each inProcessor: processor ] ].
			prefixMatchers , rest ]
]

{ #category : #action }
GTImplementorsSpotter >> find: aString [ 
	query := aString.
	self find
]

{ #category : #initialization }
GTImplementorsSpotter >> initialize [
	super initialize.
	limit := 5
]

{ #category : #accessing }
GTImplementorsSpotter >> limit: aNumber [
	limit := aNumber
]

{ #category : #accessing }
GTImplementorsSpotter >> processor: aProcessor [
	processor := aProcessor
]

{ #category : #accessing }
GTImplementorsSpotter >> query: aString [ 
	query := aString
]

{ #category : #accessing }
GTImplementorsSpotter >> stream: aGTSpotterStream [
	stream := aGTSpotterStream
]
