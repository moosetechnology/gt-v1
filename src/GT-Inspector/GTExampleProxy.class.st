Class {
	#name : #GTExampleProxy,
	#superclass : #Object,
	#instVars : [
		'owner',
		'provider',
		'selector',
		'example'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #testing }
GTExampleProxy >> = anExampleProxy [
	^ self class = anExampleProxy class 
		and: [ self owner = anExampleProxy owner 
			and: [ self selector = anExampleProxy selector ] ]
]

{ #category : #private }
GTExampleProxy >> detachFromSystem [
	example ifNotNil: [ example parents remove: self ifAbsent: [ ] ].
	example := nil
]

{ #category : #testing }
GTExampleProxy >> equalsExample: anExampleOrExampleProxy [
	^ self withExampleDo: [ anExampleOrExampleProxy equalsExample: self example ] ifAbsent: [ false ] 
]

{ #category : #accessing }
GTExampleProxy >> example [
	example ifNil: [ self resolve ].
	^ example
]

{ #category : #accessing }
GTExampleProxy >> example: anObject [
	example := anObject
]

{ #category : #testing }
GTExampleProxy >> exists [
	^ self owner finder proxyExists: self
]

{ #category : #ui }
GTExampleProxy >> gtDebuggerSourceIn: composite [
	<gtDebuggerPresentationOrder: 1>
	self withExampleDo: [ self example gtDebuggerSourceIn: composite ]
]

{ #category : #ui }
GTExampleProxy >> gtDisplayOn: aStream [
	self withExampleDo: [ self example gtDisplayOn: aStream ] ifAbsent: [ 
		aStream nextPutAll: 'anExample ('.
		aStream nextPutAll: self provider class name; nextPutAll: '>>#'; nextPutAll: self selector.
		aStream nextPutAll: ')' ]
]

{ #category : #ui }
GTExampleProxy >> gtDisplaySummaryOn: aStream [
	self withExampleDo: [ self example gtDisplaySummaryOn: aStream ] 
]

{ #category : #ui }
GTExampleProxy >> gtInspectorDependenciesIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ self withExampleDo: [ self example gtInspectorDependenciesIn: composite ]
]

{ #category : #ui }
GTExampleProxy >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ self withExampleDo: [ self example gtInspectorSourceIn: composite ]
]

{ #category : #ui }
GTExampleProxy >> gtSpotterDependenciesFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Example Dependencies';
		allCandidates: [ self example arguments ];
		itemName: [ :each | each gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExampleProxy >> gtSpotterDependentsFor: aStep [
	<spotterOrder: 2>
	aStep listProcessor
		title: 'Example Dependents';
		allCandidates: [ self example dependents ];
		itemName: [ :each | each gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExampleProxy >> gtSpotterPreviewIn: aComposite [
	<spotterPreview: 1>
	self withExampleDo: [ self example gtSpotterPreviewIn: aComposite ]
]

{ #category : #public }
GTExampleProxy >> hash [
	^ (self class hash 
		bitXor: self owner hash) 
			bitXor: self selector hash
]

{ #category : #testing }
GTExampleProxy >> isValid [
	^ self withExampleDo: [ self example isValid ] ifAbsent: [ false ]
]

{ #category : #testing }
GTExampleProxy >> matchesMethod: aCompiledMethod [
	^ self owner finder proxy: self matchesMethod: aCompiledMethod
]

{ #category : #public }
GTExampleProxy >> method [
	" todo ... "
	^ self provider class >> self selector
]

{ #category : #accessing }
GTExampleProxy >> owner [
	^ owner
]

{ #category : #accessing }
GTExampleProxy >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
GTExampleProxy >> provider [
	^ provider
]

{ #category : #accessing }
GTExampleProxy >> provider: anObject [
	provider := anObject
]

{ #category : #private }
GTExampleProxy >> resolve [
	example := (self owner finder copy
		subjects: nil; " do not inherit subjects from the owner -> #initializeFromFinder:withPragma: "
		yourself) proxy: self.
	example ifNotNil: [ example parents add: self ]
]

{ #category : #accessing }
GTExampleProxy >> selector [
	^ selector
]

{ #category : #accessing }
GTExampleProxy >> selector: anObject [
	selector := anObject
]

{ #category : #private }
GTExampleProxy >> withExampleDo: aBlock [
	^ self withExampleDo: aBlock ifAbsent: [ " ignore " ]
]

{ #category : #private }
GTExampleProxy >> withExampleDo: aBlock ifAbsent: anotherBlock [
	^ [ aBlock value ]
		on: Error
		do: anotherBlock
]
