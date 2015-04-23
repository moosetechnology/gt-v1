Extension { #name : #RTExampleSelection }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTExampleSelection >> gtDisplaySourceIn: composite [

	^ composite smalltalkCode
		beForScripting;
		title: 'Source';
		format: [ 
			| source firstLine sourceWithoutFirstLine |
			source := (self provider class >> selector) getSource.
			firstLine := source lines first.
			sourceWithoutFirstLine := source copyFrom: firstLine size + 1 to: source size.
			sourceWithoutFirstLine ];
		act: [ :text :page |
				text selectionInterval: (1 to: text text size).
				text evaluateSelectionAndDo: [ :anObject | text selection: anObject ] ]
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
		provider: RTComposedShapeExample new; 
		selector: #exampleFlags;
		yourself
]

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
RTExampleSelection >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Canvas';
		initializeView: [ self result]
		
]
