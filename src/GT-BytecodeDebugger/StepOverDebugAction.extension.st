Extension { #name : #StepOverDebugAction }

{ #category : #'*GT-BytecodeDebugger' }
StepOverDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousOver;
			label: 'Step over bytecode'
]
