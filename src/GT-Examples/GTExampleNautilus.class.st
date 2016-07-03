Class {
	#name : #GTExampleNautilus,
	#superclass : #Object,
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleNautilus class >> methodChanged: aCompiledMethod [
	[	MethodWidget methodsIconsCache removeKey: aCompiledMethod. 
		NautilusUI allSubInstances do: #updateCategoryAndMethodList ]
			on: Error
			do: [ " ignore and continue " ]
]

{ #category : #private }
GTExampleNautilus class >> methodUpdated: aCompiledMethod with: aResult [
	[	MethodWidget methodsIconsCache 
			at: aCompiledMethod 
			put: (GTExampleNautilusAction iconForMethod: aCompiledMethod result: aResult). 
		NautilusUI allSubInstances do: #updateCategoryAndMethodList ]
			on: Error
			do: [ " ignore and continue " ]
]

{ #category : #private }
GTExampleNautilus >> examples: aBlock [
	^ aBlock value
]

{ #category : #private }
GTExampleNautilus >> examples: aBlock1 collect: aBlock2 [
	^ aBlock1 value collect: [ :example | example -> (aBlock2 value: example) ]
]

{ #category : #private }
GTExampleNautilus >> examples: aBlock1 do: aBlock2 [
	^ aBlock1 value do: aBlock2
]

{ #category : #public }
GTExampleNautilus >> onClass: aBuilder [
	| target class |
	
	target := aBuilder model.
	(class := target selectedClass) ifNil: [ ^ self ].
		
	self onExamples: [ (class isMeta 
		ifTrue: [ class ] 
		ifFalse: [ class theNonMetaClass ]) gtExamplesContained ] builder: aBuilder
]

{ #category : #public }
GTExampleNautilus >> onCompiledMethod: aBuilder [
	| target method |
	
	target := aBuilder model.
	(method := target selectedMethod) ifNil: [ ^ self ].

	self onExamples: [ method gtExamples ] builder: aBuilder.
	self onReferences: method selector builder: aBuilder.
]

{ #category : #public }
GTExampleNautilus >> onExamples: aBlock builder: aBuilder [
	
	(aBuilder item: #gte)
		order: -90000;
		label: 'Examples ...';
		withSeparatorAfter.
	
	(aBuilder item: #'Inspect Examples')
		parent: #gte;
		order: 90000;
		keyText: 'e, i' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock) inspect ];
		withSeparatorAfter.
	
	(aBuilder item: #'Inspect Return-Values')
		parent: #gte;
		order: 90001;
		keyText: 'e, v' if: Nautilus useOldStyleKeys not;
		action: [ (self examples: aBlock collect: [ :example | example returnValue ]) inspect ].
		
	(aBuilder item: #'Inspect Results (full)')
		parent: #gte;
		order: 90002;
		keyText: 'e, r' if: Nautilus useOldStyleKeys not;
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
	(aBuilder item: #'Examples referencing #' ,  aLiteral , '>')
		parent: #gte;
		order: 90100;
		keyText: 'e, u' if: Nautilus useOldStyleKeys not;
		action: [
			(SystemNavigation default examplesReferencesTo: aLiteral) 
				ifNotEmpty: [ :examples | examples inspect ]
				ifEmpty: [ UIManager default inform: 'No examples found for #', aLiteral asString ] ].
]
