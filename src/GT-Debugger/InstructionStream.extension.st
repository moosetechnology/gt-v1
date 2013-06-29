Extension { #name : #InstructionStream }

{ #category : #'*GT-Debugger' }
InstructionStream >> isInitialnstruction [

	^ self pc = self method initialPC
]
