Extension { #name : #GLMTabulator }

{ #category : #'*GT-InspectorExtensions-Core' }
GLMTabulator class >> gtExampleSimple [
	<example>
	^ GLMTabulator new 
		with: [ :t |
			t column: #one.
			t transmit to: #one; andShow: [ :a | a text] ];
		startOn: 42
]
