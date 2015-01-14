Extension { #name : #Object }

{ #category : #'*GT-Inspector' }
Object >> gtDisplayOn: stream [
	"This offers a means to customize how the object is shown in the inspector"
	^ self printOn: stream
]

{ #category : #'*GT-Inspector' }
Object >> gtDisplayString [
	"This offers a means to customize how the object is shown in the inspector.
	Do not override this method. Override gtDisplayOn: instead"
		
	| limitedString limit |
	limit := 1000.
	limitedString := String streamContents: [:s | self gtDisplayOn: s] limitedTo: limit.
	limitedString size < limit ifTrue: [^ limitedString].
	^ limitedString , ' ...'
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorActionBrowse [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ self browse ];
		icon: GLMUIThemeExtraIcons glamorousBrowse;
		title: 'Browse'
]

{ #category : #'*GT-Inspector' }
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

{ #category : #'*GT-Inspector' }
Object >> gtInspectorExampleSourceIn: composite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 900>
	<gtInspectorTag: #examples>
	
	| previousRawSelection |
	(aGTInspector panes size > 1) 
		ifFalse: [ ^ self ].	
	previousRawSelection := (aGTInspector panes reversed second port: #rawSelection) value.
	((previousRawSelection isGTExample) "and: [
		aGTInspector first lastActivePresentation pane ~= aGTInspector panes reversed second ]")
			ifTrue: [ 
				(previousRawSelection gtDisplaySourceIn: composite) 
					title: 'E.g. source' ]
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorInterestingObject [
	^ self
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorMetaIn: composite [
	"This presentation offers the methods of the class of the current object"
	<gtInspectorPresentationOrder: 1000>
	<gtInspectorTag: #basic>
	^ composite custom: (GTSimpleMethodsBrowser new startOn: self) 
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorPresentationsIn: composite inContext: aGTInspector [
	"This is a utility method that collects all presentations for the current object.
	By default, it simply looks for the #gtInspectorPresentationOrder: pragma.
	The inspector can decice whether or not a presentation should be dispayed.
	Subclasses might want to override it for more special behavior."
	| pragmas |
	pragmas := Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: self class 
				to: Object
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas := pragmas select: [ :aPragma | 
		aGTInspector shouldDisplayPresentationCreateBy: aPragma method ].
	pragmas do: [ :eachPragma | 
		(eachPragma selector findTokens: $:) size = 1 
			ifTrue: [ self perform: eachPragma selector with: composite ]. 
		(eachPragma selector findTokens: $:) size = 2
			ifTrue: [ self perform: eachPragma selector with: composite with: aGTInspector ] ]
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorRawIn: composite [
	"This is the most basic presentation showing the state of the object"
	<gtInspectorPresentationOrder: 10>
	<gtInspectorTag: #basic>
	^ composite custom: GTObjectVariablesBrowser new
]

{ #category : #'*GT-Inspector' }
Object >> gtInspectorVariableValuePairs [
	"This is a helper method that returns a collection of 
		variable_name -> value
	for the current object.
	Subclasses can override it to specialize what appears in the variables presentation"
	| bindings |
	bindings := self class allInstVarNames asSet
					collect: [ :iv | iv -> (self instVarNamed: iv) ].
	1 to: (self basicSize min: 42) do: [ :index | 
		bindings add: (index asTwoCharacterString -> (self basicAt: index)) ].
	^ bindings
]

{ #category : #'*GT-Inspector-Examples' }
Object >> isGTExample [
	
	^ false
]
