Extension { #name : #Object }

{ #category : #'*gt-debugger' }
Object >> gtConstructDebuggerInspectorIn: composite [
	
	^ composite custom: (GTDebuggerInspector new startOn: self)
]

{ #category : #'*gt-debugger' }
Object >> gtDebuggerEvaluatorIn: composite [
	<gtDebuggerPresentationOrder: 15>
	
	(GTObjectVariablesBrowser new evaluatorIn: composite)
		title: 'Evaluator'
]

{ #category : #'*gt-debugger' }
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

{ #category : #'*gt-debugger' }
Object >> gtDebuggerStateIn: composite [
	<gtDebuggerPresentationOrder: 10>
	
	(GTObjectVariablesBrowser new variablesIn: composite)
		title: 'State';
		send: #value
]
