"
I provide a different view of all variables from  a Context suitable for a bytecode debugger:
- I show the complete stack of variables stored by the context (both named and unnamed variables)
- I show the slots of the receiver object using the notation rcv0, rcv1, etc., as this is how slots are accessed in bytecode instructions
"
Class {
	#name : #GTBytecodeDebuggerVariablesBrowser,
	#superclass : #GTDebuggerVariablesBrowser,
	#category : #'GT-BytecodeDebugger-UI'
}

{ #category : #'private building' }
GTBytecodeDebuggerVariablesBrowser >> buildVariablesFromContext: aContext [ 

	^ aContext gtBytecodeDebuggerRetrieveContextValues
]

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
GTBytecodeDebuggerVariablesBrowser >> variablesIn: aComposite [

	^ (super variablesIn: aComposite)
		sorted: nil
]
