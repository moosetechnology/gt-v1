Class {
	#name : #GTExampleNautilus,
	#superclass : #Object,
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleNautilus class >> browse: aString examples: aCollection [
	| env |
	env := RBSelectorEnvironment new.
	aCollection do: [ :example |
		env addClass: example methodClass selector: example selector ].
	env isEmpty 
		ifTrue: [ ^ UIManager default inform: 'No examples found' ].
	^ env gtBrowseFor: aString
]

{ #category : #public }
GTExampleNautilus class >> browseAllExampleAfterMethods: aCollectionOfExamples [
	" self browseAllExampleAfterMethods: GTExample "
	| env |
	env := RBSelectorEnvironment new.
	aCollectionOfExamples do: [ :example | 
		example after ifNotNil: [
			example after addToSelectorEnvironment: env ] ].
	^ env gtBrowseFor: 'After Methods'
]

{ #category : #public }
GTExampleNautilus class >> browseAllExampleSubjects: aCollectionOfExamples [
	" self browseAllExamplesWithSubject: GTExample "
	| env |
	env := RBSelectorEnvironment new.
	aCollectionOfExamples do: [ :example | 
		example subjects do: [ :subject | 
			subject ifNotNil: [ 
				subject addToSelectorEnvironment: env ] ] ].
	^ env gtBrowseFor: 'Subjects'
]

{ #category : #public }
GTExampleNautilus class >> browseAllExamples [
	" self browseAllExamples "
	self browseExamples: 'Examples' select: [ :example | true ]
]

{ #category : #public }
GTExampleNautilus class >> browseAllExamplesIgnoredByTests [
	" self browseAllExamplesIgnoredByTests "
	self browseExamples: 'Examples ignored by Tests' select: [ :example | 
		example ignoreTest 
			or: [ example ignoreTestReport ] ]
]

{ #category : #public }
GTExampleNautilus class >> browseAllExamplesReferencing: aLiteral [
	" self browseAllExamplesReferencing: #and: "
	self browseExamples: 'Examples referencing #', aLiteral asString select: [ :example | 
		example isReferencing: aLiteral ]
]

{ #category : #public }
GTExampleNautilus class >> browseAllExamplesWithDependencies [
	" self browseAllExamplesWithDependencies "
	self browseExamples: 'Examples with Dependencies' select: [ :example | 
		example hasArguments ]
]

{ #category : #public }
GTExampleNautilus class >> browseAllExamplesWithProblems [
	" self browseAllExamplesWithProblems "
	self browseExamples: 'Examples with Problems' select: [ :example | 
		example hasProblems ]
]

{ #category : #public }
GTExampleNautilus class >> browseAllExamplesWithSubject: aGTExampleSubject [
	" self browseAllExamplesWithSubject: GTExample "
	self browseExamples: 'Examples with Subject ', aGTExampleSubject gtDisplayString select: [ :example | 
		example hasSubject: aGTExampleSubject ]
]

{ #category : #private }
GTExampleNautilus class >> browseExamples: aString select: aBlock [
	^ self browse: aString examples: (Smalltalk gtExamplesContained select: [ :example | aBlock value: example ])
]

{ #category : #private }
GTExampleNautilus >> examples: aBlock [
	^ aBlock value
]

{ #category : #private }
GTExampleNautilus >> examples: aBlock1 collect: aBlock2 [
	^ aBlock1 value 
		select: [ :each | each isGTExample ] 
		thenCollect: [ :example | example -> (aBlock2 value: example) ]
]

{ #category : #private }
GTExampleNautilus >> examples: aBlock1 do: aBlock2 [
	^ aBlock1 value 
		select: [ :each | each isGTExample ] 
		thenDo: aBlock2
]

{ #category : #private }
GTExampleNautilus >> examples: aBlock1 select: aBlock2 [
	^ aBlock1 value 
		select: [ :example | example isGTExample and: [ aBlock2 value: example ] ]
]

{ #category : #private }
GTExampleNautilus >> onAfter: examples builder: aBuilder [
	| afters |
	examples isEmptyOrNil ifTrue: [ ^ self ].
	(afters := (examples collect: [ :each | each after ]) reject: [ :each | each isNil ]) ifEmpty: [ ^ self ].
	
	afters withIndexDo: [ :after :index | 
		after forNautilus: [ :title :action | 
			| item |
			(item := aBuilder item: title)
				parent: #gte;
				action: [ action value ].
			index = afters size ifTrue: [ item withSeparatorAfter ] ] ]
]

{ #category : #public }
GTExampleNautilus >> onClass: aBuilder [
	| target class |
	
	target := aBuilder model.
	(class := target selectedClass) ifNil: [ ^ self ].
	
	self onDefault: aBuilder.
	self onExamples: [ (class isMeta 
		ifTrue: [ class ] 
		ifFalse: [ class theNonMetaClass ]) gtExamplesContained ] if: true builder: aBuilder.
	self onReferences: class theNonMetaClass name builder: aBuilder
]

{ #category : #public }
GTExampleNautilus >> onCompiledMethod: aBuilder [
	| target method examples |
	
	target := aBuilder model.
	(method := target selectedMethod) ifNil: [ ^ self ].
	examples := method gtExamples.
	
	self onDefault: aBuilder.
	self onExamples: examples if: examples isEmptyOrNil not builder: aBuilder.
	self onDependencies: examples builder: aBuilder.
	self onDependents: examples builder: aBuilder.
	self onAfter: examples builder: aBuilder.
	self onSubjects: examples builder: aBuilder.
	self onReferences: method selector builder: aBuilder.
]

{ #category : #private }
GTExampleNautilus >> onDefault: aBuilder [
	(aBuilder item: #gte)
		order: -90000;
		label: 'Examples ...';
		withSeparatorAfter.
]

{ #category : #private }
GTExampleNautilus >> onDependencies: examples builder: aBuilder [
	examples isEmptyOrNil ifTrue: [ ^ self ].
	
	(aBuilder item: #'Browse Dependencies')
		parent: #gte;
		action: [ self class browse: 'Dependencies' examples: (examples gather: [ :each | each dependencies ]) ].
	
	(aBuilder item: #'Browse all Dependencies')
		parent: #gte;
		action: [ self class browse: 'All Dependencies' examples: (examples gather: [ :each | each allDependencies ]) ];
		withSeparatorAfter
]

{ #category : #private }
GTExampleNautilus >> onDependents: examples builder: aBuilder [
	examples isEmptyOrNil ifTrue: [ ^ self ].

	(aBuilder item: #'Browse Dependents')
		parent: #gte;
		action: [ self class browse: 'Dependents' examples: (examples gather: [ :each | each directDependents ]) ].
	
	(aBuilder item: #'Browse all Dependents')
		parent: #gte;
		action: [ self class browse: 'All Dependents' examples: (examples gather: [ :each | each allDependents ]) ];
		withSeparatorAfter
]

{ #category : #private }
GTExampleNautilus >> onExamples: aBlock if: aBoolean builder: aBuilder [
	aBoolean value ifFalse: [ ^ self ].
	
	(aBuilder item: #'Inspect Examples')
		parent: #gte;
		keyText: 'e, i' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock) inspect ];
		withSeparatorAfter.
		
	(aBuilder item: #'Inspect Return-Values')
		parent: #gte;
		keyText: 'e, v' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock collect: [ :example | example returnValue ]) inspect ].
		
	(aBuilder item: #'Inspect Results (full)')
		parent: #gte;
		action: [ (self examples: aBlock collect: [ :example | example result ]) inspect ].
		
	(aBuilder item: #'Inspect Problems')
		parent: #gte;
		action: [ (self examples: aBlock select: [ :example | example hasProblems ]) inspect ];
		withSeparatorAfter.
		
	(aBuilder item: #'Run Examples')
		parent: #gte;
		keyText: 'e, r' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock do: #run ].
		
	(aBuilder item: 'Debug Examples')
		parent: #gte;
		keyText: 'e, d' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock do: #debug ];
		withSeparatorAfter.
]

{ #category : #public }
GTExampleNautilus >> onPackage: aBuilder [
	| target package |
	
	target := aBuilder model.
	(package := target selectedPackage) ifNil: [ ^ self ].
	package item ifNil: [ ^ self ].
	
	self onDefault: aBuilder.
	self onExamples: [ package gtExamplesContained ] if: true builder: aBuilder.
	self onReferences: package packageName builder: aBuilder	
]

{ #category : #private }
GTExampleNautilus >> onReferences: aLiteral builder: aBuilder [		
	(aBuilder item: #'Browse all Examples referencing #' ,  aLiteral)
		parent: #gte;
		action: [ self class browseAllExamplesReferencing: aLiteral ].
		
	(aBuilder item: #'Browse all Examples with subject #' ,  aLiteral asString)
		parent: #gte;
		action: [ self class browseAllExamplesWithSubject: aLiteral ];
		withSeparatorAfter.	
			
	(aBuilder item: #'Browse all Examples')
		parent: #gte;
		keyText: 'e, a' if: Nautilus useOldStyleKeys not;
		action: [ self class browseAllExamples ].
		
	(aBuilder item: 'Browse all Examples with Problems')
		parent: #gte;
		action: [ self class browseAllExamplesWithProblems ].

	(aBuilder item: 'Browse all Examples with Dependencies')
		parent: #gte;
		action: [ self class browseAllExamplesWithDependencies ].
		
	(aBuilder item: 'Browse all Examples ignored by Tests')
		parent: #gte;
		action: [ self class browseAllExamplesIgnoredByTests ];
		withSeparatorAfter.
]

{ #category : #private }
GTExampleNautilus >> onSubjects: examples builder: aBuilder [
	| subjects |
	examples isEmptyOrNil ifTrue: [ ^ self ].
	(subjects := examples gather: [ :each | each subjects ]) ifEmpty: [ ^ self ].
	
	(aBuilder item: #'Browse all Subjects')
		parent: #gte;
		action: [ self class browseAllExampleSubjects: examples ].
		
	
	subjects withIndexDo: [ :subject :index | 
		subject forNautilus: [ :title :action | 
			| item |
			(item := aBuilder item: title)
				parent: #gte;
				action: [ action value ].
			index = subjects size ifTrue: [ item withSeparatorAfter ] ] ]
]
