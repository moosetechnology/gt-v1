Extension { #name : #Object }

{ #category : #'*GT-Debugger-UI' }
Object >> gtConstructDebuggerInspectorIn: composite for: aDebugger [
	
	^ composite custom: (GTDebuggerInspector new 
		debugger: aDebugger;
		startOn: self)
]

{ #category : #'*GT-Debugger-UI' }
Object >> gtDebuggerEvaluatorIn: composite [
	
	(GTObjectVariablesBrowser new evaluatorIn: composite)
		title: 'Evaluator'
]

{ #category : #'*GT-Debugger-UI' }
Object >> gtDebuggerStateIn: composite [
	
	(GTObjectVariablesBrowser new variablesIn: composite)
		title: 'State';
		send: #value
]
