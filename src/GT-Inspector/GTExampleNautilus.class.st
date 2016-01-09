Class {
	#name : #GTExampleNautilus,
	#superclass : #Object,
	#category : #'GT-Inspector-Examples-UI'
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
GTExampleNautilus >> examples: aCollection [
	^ aCollection size = 1
		ifTrue: [ aCollection anyOne ]
		ifFalse: [ aCollection ]
]

{ #category : #private }
GTExampleNautilus >> examples: aCollection do: aSelector [
	^ aCollection size = 1
		ifTrue: [ aCollection anyOne perform: aSelector ]
		ifFalse: [ aCollection collect: aSelector ]
]

{ #category : #public }
GTExampleNautilus >> onClass: aBuilder [
	| target class examples |
	target := aBuilder model.
	(class := target selectedClass) ifNil: [ ^ self ].
	self onReferences: class theNonMetaClass name builder: aBuilder.
	self onProvider: class theNonMetaClass builder: aBuilder.
	self onSource: class theNonMetaClass builder: aBuilder.
	(examples := class theNonMetaClass gtExamplesContained) isEmptyOrNil ifTrue: [ ^ self ].
	self onExamples: examples builder: aBuilder
]

{ #category : #public }
GTExampleNautilus >> onCompiledMethod: aBuilder [
	| target method examples |
	target := aBuilder model.
	(method := target selectedMethod) ifNil: [ ^ self ].
	self onReferences: method selector builder: aBuilder.
	(examples := method gtExamplesContained) isEmptyOrNil ifTrue: [ ^ self ].
	self onExamples: examples builder: aBuilder

]

{ #category : #public }
GTExampleNautilus >> onExamples: aCollection builder: aBuilder [
	(aBuilder item: #'Inspect Examples')
		order: 90003;
		action: [ (self examples: aCollection) inspect ].
	
	(aBuilder item: #'Inspect Return-Values')
		order: 90004;
		action: [ (self examples: aCollection do: #returnValue) inspect ].
		
	(aBuilder item: #'Run Examples')
		order: 10004;
		action: [ (self examples: aCollection do: #run) inspect ].
		
	(aBuilder item: #'Debug Examples')
		order: 10005;
		action: [ (self examples: aCollection do: #debug) ].
		
		
]

{ #category : #public }
GTExampleNautilus >> onPackage: aBuilder [
	| target package examples |
	target := aBuilder model.
	(package := target selectedPackage) ifNil: [ ^ self ].
	package item ifNil: [ ^ self ].
	(examples := package item gtExamplesContained) isEmptyOrNil ifTrue: [ ^ self ].
	self onExamples: examples builder: aBuilder
]

{ #category : #public }
GTExampleNautilus >> onProvider: aClass builder: aBuilder [
	aClass gtExamplesProvider = aClass ifTrue: [ ^ self ].
	aClass gtExamplesSource = aClass ifTrue: [ ^ self ].
	
	(aBuilder item: #'Browse Example Source ...')
		order: 90002;
		action: [ aClass gtExamplesSource browse ].
]

{ #category : #public }
GTExampleNautilus >> onReferences: aLiteral builder: aBuilder [
	(aBuilder item: #'Examples of ...')
		order: 90000;
		action: [
			(SystemNavigation default examplesReferencesTo: aLiteral) 
				ifNotEmpty: [ :examples | examples inspect ]
				ifEmpty: [ UIManager default inform: 'No examples found for #', aLiteral asString ] ].
				

]

{ #category : #public }
GTExampleNautilus >> onSource: aClass builder: aBuilder [
	aClass gtExamplesProvider = aClass ifTrue: [ ^ self ].
	aClass gtExamplesProvider class = aClass ifTrue: [ ^ self ].
	
	(aBuilder item: #'Browse Example Provider ...')
		order: 90001;
		action: [ aClass gtExamplesProvider browse ].
]
