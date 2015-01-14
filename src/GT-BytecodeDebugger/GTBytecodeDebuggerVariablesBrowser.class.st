Class {
	#name : #GTBytecodeDebuggerVariablesBrowser,
	#superclass : #GTDebuggerVariablesBrowser,
	#category : #'GT-BytecodeDebugger'
}

{ #category : #'as yet unclassified' }
GTBytecodeDebuggerVariablesBrowser >> variableTypeOf: aString in: aContext [
	|variableName|
	
	variableName := (aString includes: $[)
			ifTrue: [ (aString copyFrom: (aString indexOf: $[) +1 to: (aString indexOf: $])-1) trim  ]
			ifFalse: [ aString ].
	^ super 
		variableTypeOf: variableName
		in: aContext
]

{ #category : #'private building' }
GTBytecodeDebuggerVariablesBrowser >> variablesFromContext: aContext [ 

	^ aContext gtBytecodeDebuggerRetrieveContextValues
]

{ #category : #'private building' }
GTBytecodeDebuggerVariablesBrowser >> variablesIn: aComposite [

	^ (super variablesIn: aComposite)
		sorted: nil
]
