Extension { #name : #DebugSession }

{ #category : #'*GT-Debugger' }
DebugSession class >> gtDebuggingActionsForPragma: aSymbol for: aDebugger [

	^ (DebugAction allSubclasses 
		select: [ :each | each hasAbstractMethods not ]) 
			inject: OrderedCollection new 
			into: [ :currentActions :aClass |  
				currentActions addAll: (
					self 
						gtDebuggingActionsFromClass: aClass 
						forPragma: aSymbol 
						forDebugger: aDebugger); yourself  ]
]

{ #category : #'*GT-Debugger' }
DebugSession class >> gtDebuggingActionsFromClass: aClass forPragma: aSymbol forDebugger: aDebugger [
	| pragmas actions |
	pragmas := Pragma 
				allNamed: aSymbol
				from: aClass class
				to: aClass class.
	
	actions := OrderedCollection new.
	pragmas do: [ :aPragma |
		actions addAll: 
			((aPragma methodClass soleInstance
				perform: aPragma selector withEnoughArguments: {aDebugger}) asOrderedCollection 
					collect: [ :each | each forDebugger: aDebugger ])  ].
		
	^ actions sort: [ :action1 :action2 | action1 order < action2 order ]
]

{ #category : #'*gt-debugger' }
DebugSession >> recompileMethodTo: aText inContext: aMethodContext notifying: anUndefinedObject [ 
	^ (self recompileMethodTo: aText inContext: aMethodContext) isNil not
]
