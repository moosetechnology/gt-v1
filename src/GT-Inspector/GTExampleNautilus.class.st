Class {
	#name : #GTExampleNautilus,
	#superclass : #Object,
	#category : #'GT-Inspector-Examples-UI'
}

{ #category : #private }
GTExampleNautilus class >> methodChanged: aCompiledMethod [
	[	AbstractMethodWidget methodsIconsCache removeKey: aCompiledMethod. 
		NautilusUI allInstances do: #updateCategoryAndMethodList ]
			on: Error
			do: [ " ignore and continue " ]
]

{ #category : #private }
GTExampleNautilus >> examples: aCollection [
	^ aCollection size = 1
		ifTrue: [ aCollection first ]
		ifFalse: [ aCollection ]
]

{ #category : #private }
GTExampleNautilus >> examples: aCollection do: aSelector [
	^ aCollection size = 1
		ifTrue: [ aCollection first perform: aSelector ]
		ifFalse: [ aCollection collect: aSelector ]
]

{ #category : #public }
GTExampleNautilus >> onClass: aBuilder [
	| target class examples |
	target := aBuilder model.
	(class := target selectedClass) ifNil: [ ^ self ].
	self onReferences: class theNonMetaClass name builder: aBuilder.
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

{ #category : #private }
GTExampleNautilus >> onExamples: aCollection builder: aBuilder [
	(aBuilder item: #'Inspect Examples')
		order: 10000;
		action: [ (self examples: aCollection) inspect ].

	(aBuilder item: #'Run Examples')
		order: 10000;
		action: [ (self examples: aCollection do: #result) inspect ].
		
	(aBuilder item: #'Debug Examples')
		order: 10000;
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
GTExampleNautilus >> onReferences: aLiteral builder: aBuilder [
	(aBuilder item: #'Examples of ...')
		order: 10000;
		action: [
			(SystemNavigation default examplesReferencesTo: aLiteral) 
				ifNotEmpty: [ :examples | examples inspect ]
				ifEmpty: [ UIManager default inform: 'No examples found for #', aLiteral asString ] ].
				

]
