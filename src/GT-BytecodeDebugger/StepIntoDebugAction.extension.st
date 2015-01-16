Extension { #name : #StepIntoDebugAction }

{ #category : #'*GT-BytecodeDebugger' }
StepIntoDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousInto;
			label: 'Step into bytecode'
			
]
