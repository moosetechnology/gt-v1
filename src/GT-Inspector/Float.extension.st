Extension { #name : #Float }

{ #category : #'*gt-inspector' }
Float >> gtInspectorVariableValuePairs [
	"We override the default variables to add significand and exponent"
	| bindings |
	bindings := super gtInspectorVariableValuePairs.
	bindings
		add: 'significand' -> self significand;
		add: 'exponent' -> self exponent.
	^ bindings
]
