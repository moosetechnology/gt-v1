Class {
	#name : #GTAbstractExampleNautilusMenu,
	#superclass : #Object,
	#instVars : [
		'lastItem'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTAbstractExampleNautilusMenu class >> menuFor: aBuilder [
	self subclassResponsibility 
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> browseAllExamples: aBuilder [
	(lastItem := aBuilder item: 'Browse all Examples')
		parent: #gte;
		keyText: 'e, a' if: Nautilus useOldStyleKeys not;
		action: [ GTExampleNavigation browseExamples ]

]

{ #category : #private }
GTAbstractExampleNautilusMenu >> browseAllExamplesIgnoredByTests: aBuilder [		
	(lastItem := aBuilder item: 'Browse all Examples ignored by Tests')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesIgnoredByTests ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> browseAllExamplesWithDependencies: aBuilder [
	(lastItem := aBuilder item: 'Browse all Examples with Dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithDependencies ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> browseAllExamplesWithProblems: aBuilder [		
	(lastItem := aBuilder item: 'Browse all Examples with Problems')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithProblems ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> browseExamplesReferencing: aLiteral builder: aBuilder [	
	(lastItem := aBuilder item: 'Browse all Examples referencing #' ,  aLiteral)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesReferencing: aLiteral ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> browseExamplesWithSubject: aLiteral builder: aBuilder [
	(lastItem := aBuilder item: 'Browse all Examples with subject #' ,  aLiteral asString)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithSubject: aLiteral ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> buildAllDependencies: aCollection builder: aBuilder with: aBlock [
	^ (aBuilder item: #'Browse all Dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependenciesOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> buildAllDependents: aCollection builder: aBuilder [
	^ (aBuilder item: #'Browse all Dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependentsOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> buildDependencies: aCollection builder: aBuilder [ 
	^ (aBuilder item: #'Browse Dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseDependenciesOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> buildDependents: aCollection builder: aBuilder [
	^ (aBuilder item: #'Browse Dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseDependentsOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> buildSeparator [
	lastItem ifNil: [ ^ self ].
	lastItem withSeparatorAfter
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> buildSubmenu: aBuilder [
	(lastItem := aBuilder item: #gte)
		order: -90000;
		label: 'GT Examples ...';
		withSeparatorAfter.
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> debugExamples: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Debug Examples')
		parent: #gte;
		keyText: 'e, d' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock do: #debug ]
]

{ #category : #utils }
GTAbstractExampleNautilusMenu >> examples: aBlock [
	^ aBlock value
]

{ #category : #utils }
GTAbstractExampleNautilusMenu >> examples: aBlock1 collect: aBlock2 [
	^ aBlock1 value 
		select: [ :each | each isGTExample ] 
		thenCollect: [ :example | example -> (aBlock2 value: example) ]
]

{ #category : #utils }
GTAbstractExampleNautilusMenu >> examples: aBlock1 do: aBlock2 [
	^ aBlock1 value 
		select: [ :each | each isGTExample ] 
		thenDo: aBlock2
]

{ #category : #utils }
GTAbstractExampleNautilusMenu >> examples: aBlock1 select: aBlock2 [
	^ aBlock1 value 
		select: [ :example | example isGTExample and: [ aBlock2 value: example ] ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> inspectExamples: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Inspect Examples')
		parent: #gte;
		keyText: 'e, i' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock) inspect ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> inspectProblems: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Inspect Problems')
		parent: #gte;
		action: [ (self examples: aBlock select: [ :example | example hasProblems ]) inspect ]
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> inspectResults: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Inspect Results (full)')
		parent: #gte;
		action: [ (self examples: aBlock collect: [ :example | example result ]) inspect ].
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> inspectReturnValue: aBlock builder: aBuilder [
	(lastItem := aBuilder item: #'Inspect Return-Values')
		parent: #gte;
		keyText: 'e, v' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock collect: [ :example | example returnValue ]) inspect ].
]

{ #category : #public }
GTAbstractExampleNautilusMenu >> menuFor: aBuilder [
]

{ #category : #private }
GTAbstractExampleNautilusMenu >> runExamples: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Run Examples')
		parent: #gte;
		keyText: 'e, r' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock do: #run ].
]
