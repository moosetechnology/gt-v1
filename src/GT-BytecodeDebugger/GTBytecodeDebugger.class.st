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

{ #category : #'building presentations' }
GTBytecodeDebugger >> bytecodeIn: aComposite forContext: aContext [

	(self methodBytecodeWidgetIn: aComposite forContext: aContext)
		initialize: [ :bytecodePresentation |
				bytecodePresentation selection: (self session symbolicBytecodeForCurrentPCFrom: self currentContext) ];
		with: [ :bytecode | self installActionsForRootPragmas: self bytecodeActionsPragmas in: bytecode ].
]

{ #category : #accessing }
GTBytecodeDebugger >> bytecodePane [

	^ self browser paneNamed: #bytecode
]

{ #category : #accessing }
GTBytecodeDebugger >> bytecodePresentation [
	
	^ self bytecodePane presentations first
]

{ #category : #accessing }
GTBytecodeDebugger >> codePresentation [
	
	^ self codePane presentations first
]

{ #category : #building }
GTBytecodeDebugger >> debuggerStructureIn: browser [
	
	browser
		row: [ :row | 
					row
						column: #stack span: 2;
						column: #bytecode span: 2; 
						column: #code span: 3 ]
			span: 2;
		row: #inspector.
		
]

{ #category : #building }
GTBytecodeDebugger >> debuggerTransmissionsIn: browser [

	super debuggerTransmissionsIn: browser.
	browser transmit
		from: #stack port: #selection;
		to: #bytecode;
		andShow: [ :composite :aContext | self bytecodeIn: composite forContext: aContext ]

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
GTBytecodeDebugger >> methodBytecodeWidgetIn: aComposite forContext: aContext [

	^ aComposite tree
		title: 'Bytecode';
		rootsExpanded;
		display: [ aContext method symbolicBytecodes ];
		children: [ :each | each isArray ifTrue: [each] ifFalse: #() ];
		format: [ :each | self formatBytecode: each ].
]

{ #category : #'building actions' }
GTBytecodeDebugger >> stackDebuggingActionsPragmas [

	^ #( bytecodeStackDebuggingAction )
]
