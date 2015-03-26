Extension { #name : #Color }

{ #category : #'*GT-InspectorExtensions-Core' }
Color class >> exampleColorRed [
	<gtExample>
	
	^ Color red
]

{ #category : #'*GT-InspectorExtensions-Core' }
Color >> gtInspectorColorIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite morph 
		title: 'Color';
		display: [ BorderedMorph new color: self ]
]
