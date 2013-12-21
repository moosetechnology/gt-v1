Extension { #name : #Integer }

{ #category : #'*gt-inspector' }
Integer >> gtInspectorRetrieveVariableValuePairs [
	"We override the default variables to add representations for various bases"
	^ super gtInspectorRetrieveVariableValuePairs
		add: 'hex' -> self printStringHex;
		add: 'octal' -> (self printStringBase: 8);
		add: 'binary' -> (self printStringBase: 2);
		yourself
]
