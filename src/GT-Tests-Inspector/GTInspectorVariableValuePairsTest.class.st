Class {
	#name : #GTInspectorVariableValuePairsTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Inspector'
}

{ #category : #object }
GTInspectorVariableValuePairsTest >> testArrayPairs41 [
	| pairs |
	
	pairs := (1 to: 41) asArray gtInspectorVariableValuePairs.
	self assert: pairs size = 41.
	(pairs collect: #key) allSatisfy: [ :e | (pairs at: e) = e ].
	
	self assert: ((pairs collect: #key) = (1 to: 41) asOrderedCollection).
]

{ #category : #object }
GTInspectorVariableValuePairsTest >> testArrayPairs42 [
	| pairs |
	
	pairs := (1 to: 42) asArray gtInspectorVariableValuePairs.
	self assert: pairs size = 42.
	(pairs collect: #key) allSatisfy: [ :e | (pairs at: e) = e ].
	
	self assert: ((pairs collect: #key) = (1 to: 42) asOrderedCollection).
]

{ #category : #object }
GTInspectorVariableValuePairsTest >> testArrayPairs43 [
	| pairs |
	
	pairs := (1 to: 43) asArray gtInspectorVariableValuePairs.
	self assert: pairs size = 42.
	(pairs collect: #key) allSatisfy: [ :e | (pairs at: e) = e ].
	
	self assert: ((pairs collect: #key) = ((1 to: 21) asOrderedCollection addAll: (23 to: 43) asOrderedCollection; yourself)).
]

{ #category : #object }
GTInspectorVariableValuePairsTest >> testArrayPairsLong [
	| pairs |
	
	pairs := (1 to: 100) asArray gtInspectorVariableValuePairs.
	self assert: pairs size = 42.
	(pairs collect: #key) allSatisfy: [ :e | (pairs at: e) = e ].
	
	self assert: ((pairs collect: #key) = ((1 to: 21) asOrderedCollection addAll: (80 to: 100) asOrderedCollection; yourself)).
]

{ #category : #object }
GTInspectorVariableValuePairsTest >> testArrayPairsSmall [
	| pairs |
	
	pairs := (1 to: 10) asArray gtInspectorVariableValuePairs.
	self assert: pairs size = 10.
	(pairs collect: #key) allSatisfy: [ :e | (pairs at: e) = e ].
]

{ #category : #context }
GTInspectorVariableValuePairsTest >> testContextPairs [
	| pairs x tempVariables indexVariables instVariables |
	
	x:=42.
	pairs := [:y| y+1+x ] asContext gtInspectorVariableValuePairs withIndexCollect: [ :e :i | i -> e].	
	
	tempVariables := pairs select: [ :e | e value key asString beginsWith: '[' ].
	indexVariables := pairs select: [ :e | e value key isInteger ].
	instVariables := pairs select: [ :e | e value key isSymbol ].
	
	self assert: (tempVariables sort last key) < (indexVariables sort first key).
	self assert: (indexVariables sort last key) < (instVariables sort first key).
]

{ #category : #float }
GTInspectorVariableValuePairsTest >> testFloatPairs [
	| pairs |
	
	pairs := 4.2 gtInspectorVariableValuePairs.
	self assert: pairs size = 2.
	
	self assert: (pairs first = ('1' -> 1074842828)).
	self assert: (pairs second = ('2' -> 3435973837)).
]
