Extension { #name : #Object }

{ #category : #'*GT-Spotter' }
Object >> asSpotterCandidateLink [

	^ GTSpotterCandidateLink value: self
]

{ #category : #'*GT-Spotter' }
Object >> asSpotterProcessorLink [

	^ GTSpotterProcessorLink value: self
]

{ #category : #'*GT-Spotter' }
Object >> spotterActDefault [
	^ self inspect
]

{ #category : #'*GT-Spotter' }
Object >> spotterPreviewIn: aComposite inContext: aSpotter [

	| pragmas |
	pragmas := Pragma 
				allNamed: #spotterPreview: 
				from: self class 
				to: Object
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
				
	self flag: 'for now we allow only one preview per object. So we create only the top most preview in the ordered list'.
	pragmas isEmpty ifFalse: [ |eachPragma| eachPragma := pragmas first.
		(eachPragma selector findTokens: $:) size = 1 
			ifTrue: [ self perform: eachPragma selector with: aComposite ]. 
		(eachPragma selector findTokens: $:) size = 2
			ifTrue: [ self perform: eachPragma selector with: aComposite with: aSpotter ] ].
	
	"pragmas do: [ :eachPragma | 
		(eachPragma selector findTokens: $:) size = 1 
			ifTrue: [ self perform: eachPragma selector with: aComposite ]. 
		(eachPragma selector findTokens: $:) size = 2
			ifTrue: [ self perform: eachPragma selector with: aComposite with: aSpotter ] ]"
]

{ #category : #'*GT-Spotter' }
Object >> spotterPreviewRawIn: aComposite [
	<spotterPreview: 40>

	aComposite table
		title: [ self gtDisplayString ];
		display: [ :anObject | (anObject gtInspectorVariableValuePairs asSortedCollection asOrderedCollection yourself) addFirst: 'self' -> anObject; yourself ];
		column: 'Variable'
			evaluated: [:assoc |	GTObjectPrinter new asNonTruncatedTextFrom: assoc key ]
			styled: [ :aBrick | aBrick textPosition: #rightCenter; margin: #(0 15 0 0); textColor: Color lightGray; height: 30 ];
		column: 'Value'
			evaluated: [:assoc | GTObjectPrinter new asTruncatedTextFrom: assoc value ]
			styled: [ :aBrick | aBrick margin: #(0 0 0 15); height: 30 ];
		entity: self.
		
	self flag: 'move "entity: self" somewhere else, maybe'
]

{ #category : #'*GT-Spotter' }
Object >> spotterProcessorsFor: aSpotterStep [
	
	^ ((Pragma 
		allNamed: #spotterOrder:
		from: self class 
		to: Object)
			sort: [ :first :second | (first argumentAt: 1) < (second argumentAt: 1) ])
			do: [ :pragma |
				self 
					perform: pragma selector 
					with: aSpotterStep ]
]
