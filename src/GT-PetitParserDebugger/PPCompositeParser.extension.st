Extension { #name : #PPCompositeParser }

{ #category : #'*GT-PetitParserDebugger' }
PPCompositeParser classSide >> productionSelectors [

	^ (((self allInstVarNames copyWithoutAll: self ignoredNames)
		collect: [ :each | each asSymbol ])
			select: [ :each | self includesSelector: each ]) asSortedCollection add: #start; yourself
]
