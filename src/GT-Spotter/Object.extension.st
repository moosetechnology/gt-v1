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
Object >> spotterPreviewIn: aComposite [

	aComposite table
		title: 'Preview';
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
