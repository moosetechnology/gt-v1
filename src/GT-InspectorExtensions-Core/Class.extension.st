Extension { #name : #Class }

{ #category : #'*GT-InspectorExtensions-Core' }
Class >> gtInspectorCommentIn: composite [
	"This provides an editable comment of the current class"
	<gtInspectorPresentationOrder: 20>
	composite text 
		title: 'Comment';
		display: [ self comment ];
		act: [ :text | 
			self comment: text text ]
			icon: GLMUIThemeExtraIcons glamorousAccept 
			on: $s
			entitled: 'Accept'
]

{ #category : #'*GT-InspectorExtensions-Core' }
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
