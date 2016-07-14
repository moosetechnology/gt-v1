Extension { #name : #Pragma }

{ #category : #'*GT-ToolkitPharo6to5Backports' }
Pragma >> methodSelector [
	"Answer the selector of the method containing the pragma.
	 Do not confuse this with the selector of the pragma's message pattern."
	^ method selector
]
