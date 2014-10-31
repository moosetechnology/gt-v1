Extension { #name : #TClass }

{ #category : #'*GT-Inspector-Examples' }
TClass >> examplesProvider [

	^ self
]

{ #category : #'*GT-Inspector-Examples' }
TClass >> gtDisplayExamplesIn: aComposite [

	^ aComposite tree
		title: 'E.g.';
		when: [ self gtExamples notEmpty ];
		display: [ self gtExamples ];
		children: [ :anExample | anExample childrenExamples ];
		format: [ :anExample | anExample title gtDisplayString ];
		send: [ :anExample | anExample result ];
		allExpanded;
		selectionPopulate: #selection 
			on: $o 
			entitled: 'Open source' 
			with: [ :list | list rawSelection methodReference ]
]

{ #category : #'*GT-Inspector-Examples' }
TClass >> gtExamples [

	^	self gtExamplesExtractionStrategy rootExamplesFor: self
]

{ #category : #'*GT-Inspector-Examples' }
TClass >> gtExamplesExtractionStrategy [

	^ GTExampleExtractionStrategy new
]

{ #category : #'*GT-Inspector' }
TClass >> gtInspectorExamplesIn: composite [
	"This provides a list of example objects for the current class"
	<gtInspectorPresentationOrder: 20>
	
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
