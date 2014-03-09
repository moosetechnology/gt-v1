Extension { #name : #Class }

{ #category : #'*gt-inspector' }
Class >> gtInspectorExamplesIn: composite [
	"This provides a list of example objects for the current class"
	<gtInspectorPresentationOrder: 20>
	composite custom: (GTExamplesBrowser new startOn: self)
]

{ #category : #'*gt-inspector' }
Class >> gtInspectorMethodsIn: composite [
	"This provides a list of all methods provided by the current class"
	<gtInspectorPresentationOrder: 20>
	composite list 
		title: 'Methods';
		display: [ (self allMethods collect: #asRingDefinition) 
						sorted: [ :x :y | x selector < y selector ] ];
		format: #selector;
		tags: [ :each | {each methodClass name} ]
]
