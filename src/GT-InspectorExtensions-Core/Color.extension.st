Extension { #name : #Color }

{ #category : #'*GT-InspectorExtensions-Core' }
Color class >> gtExampleColorRed [
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
