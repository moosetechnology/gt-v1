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

{ #category : #'building actions' }
GTBytecodeDebugger >> debuggingActionsPragmas [

	^ #( bytecodeDebuggingAction )
]

{ #category : #'building presentations' }
GTBytecodeDebugger >> methodCodeIn: aComposite forContext: aContext [

	(self methodCodeWidgetIn: aComposite forContext: aContext)
		initialize: [ :bytecodePresentation |
				bytecodePresentation selection: (self session symbolicBytecodeForCurrentPCFrom: self currentContext) ];
		with: [ :bytecodePresentation | "self installCodeActionsFor: code "]
]

{ #category : #'building presentations' }
GTBytecodeDebugger >> methodCodeWidgetIn: aComposite forContext: aContext [

	^ aComposite tree
		title: 'Bytecode';
		rootsExpanded;
		display: [ aContext method symbolicBytecodes ];
		children: [ :each | each isArray ifTrue: [each] ifFalse: #() ];
		format: [ :each | each printString].
]

{ #category : #'building actions' }
GTBytecodeDebugger >> stackDebuggingActionsPragmas [

	^ #( bytecodeStackDebuggingAction )
]
