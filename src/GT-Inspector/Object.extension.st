Extension { #name : #Object }

{ #category : #'*gt-inspector' }
Object >> gtInspectorMethodsIn: composite [
	<gtInspectorPresentationOrder: 1000>
	composite custom: (GTSimpleMethodsBrowser new startOn: self) 
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorPresentationsIn: composite [
	| pragmas |
	pragmas := Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: self class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		self perform: eachPragma selector with: composite ]

]

{ #category : #'*gt-inspector' }
Object >> gtInspectorRetrieveVariableValuePairs [
	"This is a helper method that returns a collection of variable names -> value for the current object.
	Subclasses can override it to specialize what appears in the variables presentation"
	| bindings |
	bindings := self class allInstVarNames 
					collect: [ :iv | iv -> (self instVarNamed: iv) ].
	^ OrderedCollection new
		add: '_self' -> self;
		addAll: bindings;
		yourself
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorStateIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite custom: (GTObjectVariablesBrowser new browser startOn: self)
]
