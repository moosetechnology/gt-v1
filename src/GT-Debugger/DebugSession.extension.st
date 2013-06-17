Extension { #name : #DebugSession }

{ #category : #'*GT-Debugger' }
DebugSession class >> gtCodeDebugAction [
	<gtCodeDebugAction>
	
	^ {  }
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtDebuggerActionsForPragma: aSymbol [
	| pragmas actions |
	pragmas := Pragma 
				allNamed: aSymbol
				from: self  class
				to: Object class.
	
	actions := OrderedCollection new.
	pragmas do: [ :eachPragma |
		actions addAll: 
			(self perform: eachPragma selector) ].
		
	^ actions sort: [ :action1 :action2 | action1 order < action2 order ]
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtDynamicStackDebugAction [
	<gtDynamicStackDebugAction>
	
	^ { 
		CreateMessageDebugAction new
			order: 50.
	 }
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtProcessDebugAction [
	<gtProcessDebugAction>

	^ { 
		ResumeDebugAction new order: 5.
		RestartDebugAction  new order: 10.
	 }
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtStackDebugAction [
	<gtStackDebugAction>
	
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
