Extension { #name : #TClassDescription }

{ #category : #'*GT-Inspector-Examples' }
TClassDescription >> examplesProvider [

	^ GTExampleProvider on: self
]

{ #category : #'*GT-Inspector-Examples' }
TClassDescription >> gtExamples [

	^	self examplesProvider gtExamples
]

{ #category : #'*GT-Inspector-Examples' }
TClassDescription >> gtInspectorExamplesIn: composite [
	"This provides a list of example objects for the current class"
	<gtInspectorPresentationOrder: 20>
	<gtInspectorTag: #examples>
	|exampleProvider|

	exampleProvider := self examplesProvider.
	(exampleProvider gtDisplayExamplesIn: composite)
			"when: [ self exampleProvider rootExamples notEmpty ];"
			morphicSelectionAct: [ :list | 
					list rawSelection methodReference browse ] 
				icon: GLMUIThemeExtraIcons glamorousBrowse 
				on: $b 
				entitled: 'Browse source'

]
