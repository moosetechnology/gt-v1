Class {
	#name : #GTExampleNautilus,
	#superclass : #Object,
	#category : #'GT-Examples-UI'
}

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
	| env |
	env := RBSelectorEnvironment new.
	Smalltalk gtExamplesContained do: [ :example |
		(aBlock value: example) ifTrue: [ 
			env addClass: example methodClass selector: example selector ] ].
	env isEmpty 
		ifTrue: [ ^ UIManager default inform: 'No examples found' ].
	^ env gtBrowseFor: aString
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

{ #category : #public }
GTExampleNautilus >> onClass: aBuilder [
	| target class |
	
	target := aBuilder model.
	(class := target selectedClass) ifNil: [ ^ self ].
		
	self onExamples: [ (class isMeta 
		ifTrue: [ class ] 
		ifFalse: [ class theNonMetaClass ]) gtExamplesContained ] builder: aBuilder.
	
	(aBuilder item: #'Browse Examples having subject #' ,  class theNonMetaClass name asString)
		parent: #gte;
		order: 90101;
		keyText: 'e, s' if: Nautilus useOldStyleKeys not;
		action: [ self class browseAllExamplesWithSubject: class theNonMetaClass asGTExampleSubject ]
]

{ #category : #public }
GTExampleNautilus >> onCompiledMethod: aBuilder [
	| target method examples |
	
	target := aBuilder model.
	(method := target selectedMethod) ifNil: [ ^ self ].
	(examples := method gtExamples) ifNotEmpty: [ 
		self onExamples: [ examples ] builder: aBuilder.
		self onReferences: method selector builder: aBuilder.
		self onSubjects: method gtExamples builder: aBuilder ].
	(aBuilder item: #'Browse Examples having subject #' ,  method gtDisplayString)
		parent: #gte;
		order: 90101;
		keyText: 'e, s' if: Nautilus useOldStyleKeys not;
		action: [ self class browseAllExamplesWithSubject: method asGTExampleSubject ]
]

{ #category : #public }
GTExampleNautilus >> onExamples: aBlock builder: aBuilder [
	
	(aBuilder item: #gte)
		order: -90000;
		label: 'Examples ...';
		withSeparatorAfter.
	
	(aBuilder item: #'Inspect Examples')
		parent: #gte;
		keyText: 'e, i' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock) inspect ];
		withSeparatorAfter.
	
	(aBuilder item: #'Inspect Problems')
		parent: #gte;
		order: 90001;
		action: [ (self examples: aBlock select: [ :example | example hasProblems ]) inspect ].
		
	(aBuilder item: #'Inspect Return-Values')
		parent: #gte;
		order: 90001;
		keyText: 'e, v' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock collect: [ :example | example returnValue ]) inspect ].
		
	(aBuilder item: #'Inspect Results (full)')
		parent: #gte;
		order: 90002;
		action: [ (self examples: aBlock collect: [ :example | example result ]) inspect ];
		withSeparatorAfter.
		
	(aBuilder item: #'Run Examples')
		parent: #gte;
		order: 90003;
		keyText: 'e, r' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock do: #run ].
		
	(aBuilder item: 'Debug Examples')
		parent: #gte;
		order: 90004;
		keyText: 'e, d' if: Nautilus useOldStyleKeys not;
		action: [ self examples: aBlock do: #debug ];
		withSeparatorAfter.
		
	(aBuilder item: #'Browse all Examples')
		parent: #gte;
		order: 90005;
		keyText: 'e, a' if: Nautilus useOldStyleKeys not;
		action: [ self class browseAllExamples ].
		
	(aBuilder item: 'Browse all Examples with Problems')
		parent: #gte;
		order: 90006;
		action: [ self class browseAllExamplesWithProblems ].

	(aBuilder item: 'Browse all Examples with Dependencies')
		parent: #gte;
		order: 90007;
		action: [ self class browseAllExamplesWithDependencies ].
		
	(aBuilder item: 'Browse all Examples ignored by Tests')
		parent: #gte;
		order: 90008;
		action: [ self class browseAllExamplesIgnoredByTests ];
		withSeparatorAfter.		
]

{ #category : #public }
GTExampleNautilus >> onPackage: aBuilder [
	| target package |
	
	target := aBuilder model.
	(package := target selectedPackage) ifNil: [ ^ self ].
	package item ifNil: [ ^ self ].
	
	self onExamples: [ package gtExamplesContained ] builder: aBuilder
]

{ #category : #public }
GTExampleNautilus >> onReferences: aLiteral builder: aBuilder [
	(aBuilder item: #'Browse Examples referencing #' ,  aLiteral)
		parent: #gte;
		order: 90100;
		keyText: 'e, u' if: Nautilus useOldStyleKeys not;
		action: [ self class browseAllExamplesReferencing: aLiteral ].
		
	(aBuilder item: #'Browse Examples with subject #' ,  aLiteral asString)
		parent: #gte;
		order: 90101;
		keyText: 'e, s' if: Nautilus useOldStyleKeys not;
		action: [ self class browseAllExamplesWithSubject: aLiteral ];
		withSeparatorAfter
]

{ #category : #public }
GTExampleNautilus >> onSubjects: examples builder: aBuilder [
	examples do: [ :example |
		example subjects do: [ :subject |
			subject forNautilus: [ :title :action |
				(aBuilder item: title)
					parent: #gte;
					action: [ action value ] ] ] ]
]
