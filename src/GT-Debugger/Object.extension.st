Extension { #name : #Object }

{ #category : #'*GT-Debugger-UI' }
Object >> gtConstructDebuggerInspectorIn: composite for: aDebugger [
	
	^ composite custom: (GTDebuggerInspector new startOn: self)
]

{ #category : #'*GT-Debugger-UI' }
Object >> gtDebuggerEvaluatorIn: composite [
	<gtDebuggerPresentationOrder: 10>
	
	(GTObjectVariablesBrowser new evaluatorIn: composite)
		title: 'Evaluator'
]

{ #category : #'*GT-Debugger-UI' }
Object >> gtDebuggerPresentationsIn: composite inContext: aGTInspector [
	| pragmas |
	pragmas := (Pragma 
				allNamed: #gtDebuggerPresentationOrder: 
				from: self class 
				to: Object) asOrderedCollection.
	pragmas addAll:((Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: self class 
				to: Object)
					reject: [:pragma| pragma method selector = #gtInspectorRawIn: ]).
	pragmas := pragmas sorted: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		(eachPragma selector findTokens: $:) size = 1 
			ifTrue: [ self perform: eachPragma selector with: composite ]. 
		(eachPragma selector findTokens: $:) size = 2
			ifTrue: [ self perform: eachPragma selector with: composite with: aGTInspector ] ]

]

{ #category : #'*GT-Debugger-UI' }
Object >> gtDebuggerStateIn: composite [
	<gtDebuggerPresentationOrder: 15>
	
	(GTObjectVariablesBrowser new variablesIn: composite)
		title: 'State';
		send: #value
]
