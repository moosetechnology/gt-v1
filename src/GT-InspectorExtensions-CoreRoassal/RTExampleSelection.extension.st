Extension { #name : #RTExampleSelection }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTExampleSelection >> gtDisplaySourceIn: composite [
	<gtInspectorPresentationOrder: -8>
	^ composite smalltalkCode
		beForScripting;
		title: 'Source';
		format: [ 
			| source firstLine sourceWithoutFirstLine |
			source := (exampleObject class >> selector) getSource.
			firstLine := source lines first.
			sourceWithoutFirstLine := source copyFrom: firstLine size + 1 to: source size.
			sourceWithoutFirstLine ];
		act: [ :text :page |
				text selectionInterval: (1 to: text text size).
				text evaluateSelectionAndDo: [ :result | text selection: result ] ]
			icon: GLMUIThemeExtraIcons glamorousGo
			on: $g
			entitled: 'Do it all and go (g)'
		
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTExampleSelection classSide >> gtExampleAtRandom [
	<gtExample: 'Random example'>
	^ RTAbstractExample subclasses atRandom new gtExamples atRandom
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTExampleSelection classSide >> gtExampleFlags [
	<gtExample: 'Example flags'>
	^ RTExampleSelection new 
		exampleObject: RTComposedShapeExample new; 
		selector: #exampleFlags;
		yourself
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTExampleSelection >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Canvas';
		initializeView: [ exampleObject perform: selector ]
		
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTExampleSelection >> isGTExample [

	^ true
]
