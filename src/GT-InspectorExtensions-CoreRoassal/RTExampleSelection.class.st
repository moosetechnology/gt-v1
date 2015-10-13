Class {
	#name : #RTExampleSelection,
	#superclass : #GTExample,
	#category : #'GT-InspectorExtensions-CoreRoassal'
}

{ #category : #examples }
RTExampleSelection class >> gtExampleAtRandom [
	<gtExample>
	<label: 'Random example'>
	
	^ RTAbstractExample subclasses atRandom new gtExamples atRandom
]

{ #category : #examples }
RTExampleSelection class >> gtExampleFlags1 [
	<gtExample>
	<label: 'Example flags 1'>
	
	^ RTComposedShapeExample gtExamples
		detect: [ :example | example method selector = #exampleFlags ]
		ifNone: [ nil ]
]

{ #category : #examples }
RTExampleSelection class >> gtExampleFlags2 [
	<gtExample>
	<label: 'Example flags 2'>
	
	^ (RTComposedShapeExample >> #exampleFlags) gtExamples first
]

{ #category : #examples }
RTExampleSelection class >> gtExampleFlags3 [
	<gtExample>
	<label: 'Example flags 3'>
	
	^ (RTComposedShapeExample >> #exampleFlags) gtExample
]

{ #category : #ui }
RTExampleSelection >> gtDisplayPlaygroundIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite pharoPlayground
		title: 'Playground';
		format: [ 
			| sourceCode firstLine sourceCodeWithoutFirstLine |
			sourceCode := self method sourceCode.
			firstLine := sourceCode lines first.
			sourceCodeWithoutFirstLine := sourceCode copyFrom: firstLine size + 1 to: sourceCode size.
			sourceCodeWithoutFirstLine ];
		act: [ :text :page |
				text selectionInterval: (1 to: text text size).
				text evaluateSelectionAndDo: [ :anObject | text selection: anObject ] ]
			icon: GLMUIThemeExtraIcons glamorousGo
			on: $g
			entitled: 'Do it all and go (g)'
		
]

{ #category : #ui }
RTExampleSelection >> gtInspectorRoassalViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Canvas';
		initializeView: [ self returnValue ]
		
]

{ #category : #ui }
RTExampleSelection >> gtInspectorViewIn: composite [
	self deprecated: 'Please use #gtInspectorRoassalViewIn: instead'.
	^ self gtInspectorRoassalViewIn: composite
]

{ #category : #accessing }
RTExampleSelection >> icon [
	form ifNil: [ self initializeIcon ].
	^ form
]

{ #category : #public }
RTExampleSelection >> iconForm [
	self deprecated: 'Please use #icon'.
	^ self icon
]

{ #category : #public }
RTExampleSelection >> initializeIcon [
	|icon64Mime|
	(self provider class canPerform: (self method selector, 'Icon') asSymbol)
		ifFalse: [ form := Form extent: 16@16. ^ self ].
	
	icon64Mime := self provider perform: (self method selector, 'Icon') asSymbol.
	form := TRPlatform current formClass fromBinaryStream: 
		(TRPlatform current mimeDecodeToBytes: icon64Mime readStream) 
]
