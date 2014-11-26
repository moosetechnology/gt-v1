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
