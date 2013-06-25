Extension { #name : #DebugSession }

{ #category : #'*GT-Debugger' }
DebugSession class >> gtChangeDebuggerActionsFor: aDebugger [
	<gtContextDebuggingAction>
	
	^ (aDebugger debuggersForContext: aDebugger selectedContext) collect: [ :aDebuggerClass | 
		ChangeDebuggerAction new
			debuggerClass: aDebuggerClass
		]
		
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtCodeDebugActionFor: aDebugger [
	<gtCodeDebuggingActions>
	
	^ {  
		WhereIsDebugAction new order: 5.
		RunToHereDebugAction new order: 10.
		SaveDebugAction new order: 15.
	}
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtDebuggerActionsForPragma: aSymbol for: aDebugger [
	| pragmas actions |
	pragmas := Pragma 
				allNamed: aSymbol
				from: self  class
				to: DebugSession class.
	
	actions := OrderedCollection new.
	pragmas do: [ :eachPragma |
		actions addAll: 
			(self perform: eachPragma selector with: aDebugger) ].
		
	^ actions sort: [ :action1 :action2 | action1 order < action2 order ]
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtDynamicStackDebugActionFor: aDebugger [
	<gtContextDebuggingAction>
	
	^ { 
		CreateMessageDebugAction new
			order: 50.
	 }
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtProcessDebugActionFor: aDebugger [
	<gtDebuggingActions>

	^ { 
		ResumeDebugAction new order: 5.
		RestartDebugAction new order: 10.
	 }
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtStackDebugActionFor: aDebugger [
	<gtDebuggingActions>
	
	^ { 
		StackDebugAction new
			label: 'Step Into';
			action: #stepInto:;
			icon: GLMUIThemeExtraIcons glamorousInto;
			order: 20.
			
		StackDebugAction new
			label: 'Step Over';
			action: #stepOver:;
			icon: GLMUIThemeExtraIcons glamorousOver;
			order: 25.
			
		StackDebugAction new
			label: 'Step Through';
			action: #stepThrough:;
			icon: GLMUIThemeExtraIcons glamorousThrough;
			order: 30.
	 }
]

{ #category : #'*gt-debugger' }
DebugSession >> recompileMethodTo: aText inContext: aMethodContext notifying: anUndefinedObject [ 
	^ (self recompileMethodTo: aText inContext: aMethodContext) isNil not
]
