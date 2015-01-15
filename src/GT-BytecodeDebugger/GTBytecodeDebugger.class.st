"
I am a debugger that provides the ability to step through the execution at the bytecode level
"
Class {
	#name : #GTBytecodeDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'GT-BytecodeDebugger'
}

{ #category : #accessing }
GTBytecodeDebugger class >> defaultTitle [

	^ 'Bytecode Debugger'
]

{ #category : #'tools registry' }
GTBytecodeDebugger class >> register [

	self registerToolsOn: Smalltalk tools.
]

{ #category : #'tools registry' }
GTBytecodeDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 10.
]

{ #category : #accessing }
GTBytecodeDebugger class >> sessionClass [

	^ GTBytecodeDebuggerSession
]

{ #category : #accessing }
GTBytecodeDebugger class >> variablesBrowserClass [

	^ GTBytecodeDebuggerVariablesBrowser
]

{ #category : #'building actions' }
GTBytecodeDebugger >> bytecodeActionsPragmas [

	^ #( bytecodeDebuggingAction )
]

{ #category : #accessing }
GTBytecodeDebugger >> bytecodePresentation [
	
	^ self codePane presentations first
]

{ #category : #accessing }
GTBytecodeDebugger >> codePresentation [
	
	^ self codePane presentations second
]

{ #category : #'building actions' }
GTBytecodeDebugger >> debuggingActionsPragmas [

	^ #()
]

{ #category : #'printing/formatting' }
GTBytecodeDebugger >> formatBytecode: aBytecode [
	| textAttributes|
	
	textAttributes := {TextColor black}.
	self selectedContext pc = aBytecode offset ifTrue: [ textAttributes := {TextColor black. TextEmphasis bold} ]. 
	self selectedContext pc > aBytecode offset ifTrue: [ textAttributes := {TextColor new color: Color darkGray} ].
	^ Text 
		string: aBytecode printString
		attributes: textAttributes
]

{ #category : #'building presentations' }
GTBytecodeDebugger >> methodBytecodeIn: aComposite forContext: aContext [

	^ aComposite tree
		title: 'Bytecode';
		rootsExpanded;
		display: [ aContext method symbolicBytecodes ];
		children: [ :each | each isArray ifTrue: [each] ifFalse: #() ];
		format: [ :each | self formatBytecode: each ].
]

{ #category : #'building presentations' }
GTBytecodeDebugger >> methodCodeIn: aComposite forContext: aContext [

	(self methodBytecodeIn: aComposite forContext: aContext)
		initialize: [ :bytecodePresentation |
				bytecodePresentation selection: (self session symbolicBytecodeForCurrentPCFrom: self currentContext) ];
		with: [ :bytecode | self installActionsForRootPragmas: self bytecodeActionsPragmas in: bytecode ].
	super methodCodeIn: aComposite forContext: aContext.
]

{ #category : #'building actions' }
GTBytecodeDebugger >> stackDebuggingActionsPragmas [

	^ #( bytecodeStackDebuggingAction )
]
