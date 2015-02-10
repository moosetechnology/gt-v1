Extension { #name : #TClassDescription }

{ #category : #'*GT-Inspector-Examples' }
TClassDescription >> examplesProvider [

	^ self
]

{ #category : #'*GT-Inspector-Examples' }
TClassDescription >> gtDisplayExamplesIn: aComposite [

	^ aComposite tree
		title: 'E.g.';
		when: [ self gtExamples notEmpty ];
		display: [ self gtExamples ];
		children: [ :anExample | anExample childrenExamples ];
		format: [ :anExample | anExample title ];
		send: [ :anExample | anExample result ];
		allExpanded;
		selectionPopulate: #selection 
			on: $o 
			entitled: 'Open source' 
			with: [ :list | list rawSelection methodReference ]
]

{ #category : #'*GT-Inspector-Examples' }
TClassDescription >> gtExamples [

	^	self gtExamplesExtractionStrategy rootExamplesFor: self
]

{ #category : #'*GT-Inspector-Examples' }
TClassDescription >> gtExamplesExtractionStrategy [

	^ GTExampleExtractionStrategy new
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
