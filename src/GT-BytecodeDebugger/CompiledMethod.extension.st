Extension { #name : #CompiledMethod }

{ #category : #'*GT-BytecodeDebugger' }
CompiledMethod >> symbolicBytecodes [
	"Answer Collection that contains of all the byte codes in a method as an instance of SymbolicInstruction"

	^SymbolicBytecodeBuilder decode: self
]
