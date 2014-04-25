Extension { #name : #TraitDescription }

{ #category : #'*GT-InspectorExtensions-Core' }
TraitDescription >> gtInspectorUsersIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite list 	
		title: 'Users';
		display: [ 
			Smalltalk allClasses select: [ :class |
			   class traitComposition traits includes: self ] ]
]
