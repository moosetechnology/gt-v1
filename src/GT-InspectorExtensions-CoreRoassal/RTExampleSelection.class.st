Class {
	#name : #RTExampleSelection,
	#superclass : #GTExample,
	#category : #'GT-InspectorExtensions-CoreRoassal'
}

{ #category : #'as yet unclassified' }
RTExampleSelection class >> gtExampleAtRandom [
	<gtExample>
	<label: 'Random example'>
	
	^ RTAbstractExample subclasses atRandom new gtExamples atRandom
]

{ #category : #'as yet unclassified' }
RTExampleSelection class >> gtExampleFlags [
	<gtExample>
	<label: 'Example flags'>
	
	^ RTExampleSelection new 
		provider: RTComposedShapeExample new; 
		selector: #exampleFlags;
		yourself
]

{ #category : #'as yet unclassified' }
RTExampleSelection >> gtDisplaySourceIn: composite [

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

{ #category : #'as yet unclassified' }
RTExampleSelection >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Canvas';
		initializeView: [ self returnValue ]
		
]

{ #category : #accessing }
RTExampleSelection >> iconForm [
	self icon ifNil: [ self initializeIcon ].
	^ self icon
]

{ #category : #initializing }
RTExampleSelection >> initializeIcon [
	|icon64Mime|
	icon64Mime := self provider perform: (self method selector, 'Icon') asSymbol.
	form := TRPlatform current formClass fromBinaryStream: 
		(TRPlatform current mimeDecodeToBytes: icon64Mime readStream) 
]
