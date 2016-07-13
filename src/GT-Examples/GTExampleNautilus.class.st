Class {
	#name : #GTExampleNautilus,
	#superclass : #Object,
	#category : #'GT-Examples-UI'
}

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
		ifFalse: [ class theNonMetaClass ]) gtExamples ] if: true builder: aBuilder.
	
	(aBuilder item: #'Browse Examples of Class ' ,  class name)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesOfClass: class ].
		
	(aBuilder item: #'Browse Examples in Hierarchy of Class ' , class name)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesInSubclassesOfClass: class ].
		
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
		action: [ GTExampleNavigation browseDependenciesOf: examples ].
	
	(aBuilder item: #'Browse all Dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependenciesOf: examples ];
		withSeparatorAfter
]

{ #category : #private }
GTExampleNautilus >> onDependents: examples builder: aBuilder [
	examples isEmptyOrNil ifTrue: [ ^ self ].

	(aBuilder item: #'Browse Dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseDependentsOf: examples ].
	
	(aBuilder item: #'Browse all Dependents')
		parent: #gte;
		action: [ GTExampleNavigation browseAllDependentsOf: examples ];
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
	target selectedPackage ifNil: [ ^ self ].
	(package := target selectedPackage item) ifNil: [ ^ self ].
	
	self onDefault: aBuilder.
	self onExamples: [ package gtExamplesContained ] if: true builder: aBuilder.
	
	(aBuilder item: #'Browse all Examples of Package ' ,  package packageName)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesOfPackage: package ].
		
	self onReferences: package packageName builder: aBuilder	
]

{ #category : #private }
GTExampleNautilus >> onReferences: aLiteral builder: aBuilder [		
	(aBuilder item: #'Browse all Examples referencing #' ,  aLiteral)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesReferencing: aLiteral ].
		
	(aBuilder item: #'Browse all Examples with subject #' ,  aLiteral asString)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithSubject: aLiteral ];
		withSeparatorAfter.	
			
	(aBuilder item: #'Browse all Examples')
		parent: #gte;
		keyText: 'e, a' if: Nautilus useOldStyleKeys not;
		action: [ GTExampleNavigation browseExamples ].
		
	(aBuilder item: 'Browse all Examples with Problems')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithProblems ].

	(aBuilder item: 'Browse all Examples with Dependencies')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesWithDependencies ].
		
	(aBuilder item: 'Browse all Examples ignored by Tests')
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesIgnoredByTests ];
		withSeparatorAfter.
]

{ #category : #private }
GTExampleNautilus >> onSubjects: examples builder: aBuilder [
	| subjects |
	examples isEmptyOrNil ifTrue: [ ^ self ].
	(subjects := examples gather: [ :each | each subjects ]) ifEmpty: [ ^ self ].
	
	(aBuilder item: #'Browse all Subjects')
		parent: #gte;
		action: [ GTExampleNavigation browseAllExampleSubjects: examples ].
		
	
	subjects withIndexDo: [ :subject :index | 
		subject forNautilus: [ :title :action | 
			| item |
			(item := aBuilder item: title)
				parent: #gte;
				action: [ action value ].
			index = subjects size ifTrue: [ item withSeparatorAfter ] ] ]
]
