Extension { #name : #Object }

{ #category : #'*gt-debugger' }
Object >> gtDebuggerEvaluatorIn: composite [
	<gtDebuggerPresentationOrder: 15>
	
	(GTObjectVariablesBrowser new evaluatorIn: composite)
		title: 'Evaluator'
]

{ #category : #'*gt-debugger' }
Object >> gtDebuggerPresentationsIn: composite [
	| pragmas |
	pragmas := (Pragma 
				allNamed: #gtDebuggerPresentationOrder: 
				from: self class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)]) asOrderedCollection.
	pragmas addAll:((Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: self class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)])
					reject: [:pragma| pragma method selector = #gtInspectorStateIn: ]).
	pragmas do: [ :eachPragma | 
		self perform: eachPragma selector with: composite ]

]

{ #category : #'*gt-debugger' }
Object >> gtDebuggerStateIn: composite [
	<gtDebuggerPresentationOrder: 10>
	
	(GTObjectVariablesBrowser new variablesIn: composite)
		title: 'State'
]
