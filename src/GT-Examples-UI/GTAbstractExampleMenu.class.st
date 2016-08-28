Class {
	#name : #GTAbstractExampleMenu,
	#superclass : #Object,
	#instVars : [
		'lastItem'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTAbstractExampleMenu class >> menuFor: aBuilder [
	self subclassResponsibility 
]

{ #category : #private }
GTAbstractExampleMenu >> browseAllExamples: aBuilder [
	(lastItem := aBuilder item: 'Browse all examples')
		parent: #gte;
		keyText: 'e, a' if: Nautilus useOldStyleKeys not;
		action: [ GTExampleNavigation browseExamples ];
		icon: Smalltalk ui icons nautilus

]

{ #category : #private }
GTAbstractExampleMenu >> browseAllExamplesIgnoredByTests: aBuilder [		
	(lastItem := aBuilder item: 'Browse all examples ignored by tests')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesIgnoredByTests ]
]

{ #category : #private }
GTAbstractExampleMenu >> browseAllExamplesWithDependencies: aBuilder [
	(lastItem := aBuilder item: 'Browse all examples with dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithDependencies ]
]

{ #category : #private }
GTAbstractExampleMenu >> browseAllExamplesWithProblems: aBuilder [		
	(lastItem := aBuilder item: 'Browse all examples with problems')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithProblems ];
		icon: Smalltalk ui icons smallError.
]

{ #category : #private }
GTAbstractExampleMenu >> browseExamplesReferencing: aLiteral builder: aBuilder [	
	(lastItem := aBuilder item: 'Browse examples referencing "' ,  aLiteral , '"')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesReferencing: aLiteral ]
]

{ #category : #private }
GTAbstractExampleMenu >> browseExamplesWithSubject: aLiteral builder: aBuilder [
	(lastItem := aBuilder item: 'Browse examples with subject "' ,  aLiteral gtDisplayString , '"')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithSubject: aLiteral ]
]

{ #category : #private }
GTAbstractExampleMenu >> buildAllDependencies: aCollection builder: aBuilder with: aBlock [
	^ (aBuilder item: #'Browse all dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependenciesOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleMenu >> buildAllDependents: aCollection builder: aBuilder [
	^ (aBuilder item: #'Browse all dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependentsOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleMenu >> buildDependencies: aCollection builder: aBuilder [ 
	^ (aBuilder item: #'Browse dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseDependenciesOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleMenu >> buildDependents: aCollection builder: aBuilder [
	^ (aBuilder item: #'Browse dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseDependentsOf: aCollection ]
]

{ #category : #private }
GTAbstractExampleMenu >> buildSeparator [
	lastItem ifNil: [ ^ self ].
	lastItem withSeparatorAfter
]

{ #category : #private }
GTAbstractExampleMenu >> buildSubmenu: aBuilder [
	(lastItem := aBuilder item: #gte)
		order: self submenuOrder;
		label: 'GT Examples';
		withSeparatorAfter.
]

{ #category : #private }
GTAbstractExampleMenu >> debugExamples: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Debug examples')
		parent: #gte;
		keyText: 'e, d' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock withProgressCollect: [ :each | each debug ] ];
		icon: Smalltalk ui icons smallDebug.
]

{ #category : #utils }
GTAbstractExampleMenu >> examples: aBlock [
	self examples: aBlock select: [ :each | true ]
]

{ #category : #utils }
GTAbstractExampleMenu >> examples: aBlock1 collect: aBlock2 [
	self examples: aBlock1 select: [ :each | true ] collect: [ :each | aBlock2 value: each ]
]

{ #category : #utils }
GTAbstractExampleMenu >> examples: aCollection do: aBlock1 progress: aBlock2 [
	| progress |
	aCollection size < 2 ifTrue: [ ^ aCollection do: aBlock1 ].
	aBlock2 ifNil: [ ^ aCollection do: aBlock1 ].
	(progress := aBlock2 value: aCollection) isEmptyOrNil ifTrue: [ ^ aCollection do: aBlock1 ].
	aCollection do: aBlock1 displayingProgress: progress
]

{ #category : #utils }
GTAbstractExampleMenu >> examples: aBlock1 select: aBlock2 [
	(aBlock1 value select: [ :example | 
		example isGTExample 
			and: [ aBlock2 value: example ] ])
				ifNotEmpty: [ :examples | 
					(examples size = 1 
						ifTrue: [ examples anyOne ]
						ifFalse: [ examples ]) inspect ]
				ifEmpty: [ self notifyNoExamples ]
]

{ #category : #utils }
GTAbstractExampleMenu >> examples: aBlock1 select: aBlock2 collect: aBlock3 [
	| examples |
	examples := Dictionary new.
	aBlock1 value 
		select: [ :each | each isGTExample and: [ aBlock2 value: each ] ] 
		thenDo: [ :each | examples at: each put: (aBlock3 value: each) ].
	examples
		ifNotEmpty: [ examples inspect ]
		ifEmpty: [ self notifyNoExamples ]
]

{ #category : #utils }
GTAbstractExampleMenu >> examples: aBlock1 select: aBlock2 collect: aBlock3 progress: aBlock4 [
	| results |
	results := Dictionary new.
	self examples: (aBlock1 value select: [ :each | each isGTExample and: [ aBlock2 value: each ] ]) 
		do: [ :each | results at: each put: (aBlock3 value: each) ]
		progress: aBlock4.
	results
		ifNotEmpty: [ 
			(results size = 1
				ifTrue: [ results anyOne ]
				ifFalse: [ results ]) inspect ]
		ifEmpty: [ self notifyNoExamples ]
]

{ #category : #utils }
GTAbstractExampleMenu >> examples: aBlock1 withProgressCollect: aBlock2 [
	self examples: aBlock1 
		select: [ :each | true ] 
		collect: [ :each | aBlock2 value: each ] 
		progress: [ :examples | 'Processing ' , examples size asString , ' examples ...' ]
]

{ #category : #private }
GTAbstractExampleMenu >> inspectExamples: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Inspect examples')
		parent: #gte;
		keyText: 'e, i' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock ];
		icon: Smalltalk ui icons glamorousInspect.
]

{ #category : #private }
GTAbstractExampleMenu >> inspectProblems: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Inspect problems')
		parent: #gte;
		action: [ self examples: aBlock select: [ :each | each hasProblems ] collect: [ :each | each problems ] ];
		icon: Smalltalk ui icons smallError
]

{ #category : #private }
GTAbstractExampleMenu >> inspectResults: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Inspect results (full)')
		parent: #gte;
		action: [ self examples: aBlock withProgressCollect: [ :example | example result ] ].
]

{ #category : #private }
GTAbstractExampleMenu >> inspectReturnValue: aBlock builder: aBuilder [
	(lastItem := aBuilder item: #'Inspect return-values')
		parent: #gte;
		keyText: 'e, v' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock withProgressCollect: [ :example | example returnValue ] ].
]

{ #category : #public }
GTAbstractExampleMenu >> menuFor: aBuilder [
]

{ #category : #utils }
GTAbstractExampleMenu >> notifyNoExamples [
	GrowlMorph 
		openWithLabel: 'GT Examples'
		contents: 'No examples found within the current selection' 
]

{ #category : #private }
GTAbstractExampleMenu >> runExamples: aBlock builder: aBuilder [
	(lastItem := aBuilder item: 'Run examples')
		parent: #gte;
		keyText: 'e, r' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock withProgressCollect: [ :each | each run ] ];
		icon: Smalltalk ui icons smallDoIt.
]

{ #category : #private }
GTAbstractExampleMenu >> submenuOrder [
	^ -9999
]
