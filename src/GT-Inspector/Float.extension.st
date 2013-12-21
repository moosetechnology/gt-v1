Extension { #name : #Float }

{ #category : #'*gt-inspector' }
Float >> gtInspectorRetrieveVariableValuePairs [
	"We override the default variables to add significand and exponent"
	| bindings |
	bindings := super gtInspectorRetrieveVariableValuePairs.
	bindings
		add: 'significand' -> self significand;
		add: 'exponent' -> self exponent.
	^ bindings
]
