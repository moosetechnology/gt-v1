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
	
	^ (RTComposedShapeExample >> #exampleFlags) gtExample
]

{ #category : #DEPRECATED }
RTExampleSelection >> gtDisplaySourceIn: composite [
	<todo: 'deprecated #gtDisplaySourceIn:'>
	^ composite smalltalkCode
		beForScripting;
		title: 'Source';
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

{ #category : #accessing }
RTExampleSelection >> icon [
	form ifNil: [ self initializeIcon ].
	^ form
]

{ #category : #DEPRECATED }
RTExampleSelection >> iconForm [
	<todo: 'deprecated #iconForm'>
	^ self icon
]

{ #category : #initializing }
RTExampleSelection >> initializeIcon [
	|icon64Mime|
	icon64Mime := self provider perform: (self method selector, 'Icon') asSymbol.
	form := TRPlatform current formClass fromBinaryStream: 
		(TRPlatform current mimeDecodeToBytes: icon64Mime readStream) 
]

{ #category : #DEPRECATED }
RTExampleSelection >> title [
	<todo: '#deprecated: #title'>
	^ self label isEmptyOrNil
		ifNotNil: [ self label ]
		ifNil: [ self method selector ]
		
]
