Extension { #name : #SmalltalkImage }

{ #category : #'*GT-Examples-Core' }
SmalltalkImage >> examplesDo: aBlock [
	Object withAllSubclassesDo: [ :class | class examplesDo: aBlock ]
]

{ #category : #'*GT-Examples-Core' }
SmalltalkImage >> gtExamplesContained [
	| examples |
	examples := OrderedCollection new.
	Object withAllSubclasses do: [ :class |
		class gtExamplesFactory examplesDo: [ :example | 
			examples add: example ] ].
	^ examples
]

{ #category : #'*GT-Examples-Core' }
SmalltalkImage >> gtExamplesDo: aBlock [
	Object withAllSubclassesDo: [ :class | class gtExamplesDo: aBlock ]
]
