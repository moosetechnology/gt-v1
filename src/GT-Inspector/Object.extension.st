Extension { #name : #Object }

{ #category : #'*gt-inspector' }
Object >> gtDisplayOn: stream [
	"This offers a means to customize how the object is shown in the inspector"
	^ self printOn: stream
]

{ #category : #'*gt-inspector' }
Object >> gtDisplayString [
	"This offers a means to customize how the object is shown in the inspector.
	Do not override this method. Override gtDisplayOn: instead"
		
	| limitedString limit |
	limit := 1000.
	limitedString := String streamContents: [:s | self gtDisplayOn: s] limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , ' ...'
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorActionBrowse [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ self browse ];
		icon: GLMUIThemeExtraIcons glamorousBrowse;
		title: 'Browse'
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorActions [
	"This is a utility method that allows each object to define a set of actions 
	specific for itself. These actions are used when the object appears in the inspector.

	The actions are collected based on the #gtInspectorAction pragma that are defined in
	unary methods corresponding to the body of the actions"
	
	| all |
	all := (Pragma 
				allNamed: #gtInspectorAction
				from: self class 
				to: Object) collect: [:eachPragma |
					self perform: eachPragma selector ].
	^ all asSortedCollection: [:a :b | 
		| first second |
		first := a isCategorized ifTrue: [a category, a title] ifFalse: [a title].
		second := b isCategorized ifTrue: [b category, b title] ifFalse: [b title].
		first < second]
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorExampleSourceIn: composite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 900>
	
	| previousRawSelection |
	(aGTInspector first panes size > 1) 
		ifFalse: [ ^ self ].	
	previousRawSelection := (aGTInspector first panes reversed second port: #rawSelection) value.
	(previousRawSelection isKindOf: GTExample)
			ifTrue: [ 
				(previousRawSelection methodReference gtInspectorSourceIn: composite) 
					title: 'E.g. source' ]
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorMetaIn: composite [
	"This presentation offers the methods of the class of the current object"
	<gtInspectorPresentationOrder: 1000>
	^ composite custom: (GTSimpleMethodsBrowser new startOn: self) 
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorPresentationsIn: composite inContext: aGTInspector [
	"This is a utility method that collects all presentations for the current object.
	By default, it simply looks for the #gtInspectorPresentationOrder: pragma.
	Subclasses might want to override it for more special behavior."
	| pragmas |
	pragmas := Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: self class 
				to: Object
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		(eachPragma selector findTokens: $:) size = 1 
			ifTrue: [ self perform: eachPragma selector with: composite ]. 
		(eachPragma selector findTokens: $:) size = 2
			ifTrue: [ self perform: eachPragma selector with: composite with: aGTInspector ] ]
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorStateIn: composite [
	"This is the most basic presentation showing the state of the object"
	<gtInspectorPresentationOrder: 10>
	^ composite custom: (GTObjectVariablesBrowser new startOn: self)
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorVariableValuePairs [
	"This is a helper method that returns a collection of 
		variable_name -> value
	for the current object.
	Subclasses can override it to specialize what appears in the variables presentation"
	| bindings |
	bindings := self class allInstVarNames 
					collect: [ :iv | iv -> (self instVarNamed: iv) ].
	^ Set new
		addAll: bindings;
		yourself
]
