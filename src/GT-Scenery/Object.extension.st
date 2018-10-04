Extension { #name : #Object }

{ #category : #'*GT-Scenery' }
Object >> allInstVars [
	^ self class allInstVarNames collect: [ :each | self instVarNamed: each ]
]

{ #category : #'*GT-Scenery' }
Object >> instVars [
	^ self class instVarNames collect: [ :each | self instVarNamed: each ]
]
