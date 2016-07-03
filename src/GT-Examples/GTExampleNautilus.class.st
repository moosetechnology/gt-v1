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
	
	"
	self onReferences: class theNonMetaClass name builder: aBuilder.
	self onProvider: class theNonMetaClass builder: aBuilder.
	self onSource: class theNonMetaClass builder: aBuilder.
	"
	
	self onExamples: [ (class isMeta 
		ifTrue: [ class ] 
		ifFalse: [ class theNonMetaClass ]) gtExamplesContained ] builder: aBuilder
]

{ #category : #public }
GTExampleNautilus >> onCompiledMethod: aBuilder [
	| target method examples |
	
	target := aBuilder model.
	(method := target selectedMethod) ifNil: [ ^ self ].
	self onReferences: method selector builder: aBuilder.
	
	self onExamples: [ method gtExamples ] builder: aBuilder
]

{ #category : #private }
GTExampleNautilus >> onExamples: aBlock builder: aBuilder [
	(aBuilder item: #'Inspect Examples')
		order: 90000;
		action: [ (self examples: aBlock) inspect ].
	
	(aBuilder item: #'Inspect Return-Values')
		order: 90001;
		action: [ (self examples: aBlock collect: [ :example | example returnValue ]) inspect ].
		
	(aBuilder item: #'Inspect Results (full)')
		order: 90002;
		action: [ (self examples: aBlock collect: [ :example | example result ]) inspect ].
		
	(aBuilder item: #'Run Examples')
		order: 90003;
		action: [ self examples: aBlock do: #run ].
		
	(aBuilder item: #'Debug Examples')
		order: 90004;
		action: [ self examples: aBlock do: #debug ].
		
		
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
