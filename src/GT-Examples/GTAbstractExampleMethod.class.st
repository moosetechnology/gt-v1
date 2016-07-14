Class {
	#name : #GTAbstractExampleMethod,
	#superclass : #GTAbstractExampleObject,
	#instVars : [
		'methodClassName',
		'methodClass',
		'selector'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleMethod class >> isAbstract [
	^ self == GTAbstractExampleMethod
]

{ #category : #testing }
GTAbstractExampleMethod >> = anExampleMethod [
	^ self class = anExampleMethod class 
		and: [ self methodClassName = anExampleMethod methodClassName 
			and: [ self selector = anExampleMethod selector ] ]
]

{ #category : #ui }
GTAbstractExampleMethod >> addToSelectorEnvironment: aSelectorEnvironment [
	self exists ifFalse: [ ^ self ].
	
	aSelectorEnvironment addClass: self methodClass selector: self selector
]

{ #category : #private }
GTAbstractExampleMethod >> ensureInitialized [
	" 1) reset -> 2) reinitialize  "
	methodClass ifNotNil: [ methodClass isObsolete ifTrue: [ methodClass := nil ] ].
	methodClass	ifNil: [ methodClass := Smalltalk classNamed: methodClassName ]
		
]

{ #category : #testing }
GTAbstractExampleMethod >> exists [
	^ self methodClassName notNil
		and: [ self methodClass notNil
			and: [ self methodClass includesSelector: self selector ] ]
]

{ #category : #ui }
GTAbstractExampleMethod >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock
		value: #'Browse Method ' ,  self method gtDisplayString
		value: [ self method browse ]
]

{ #category : #ui }
GTAbstractExampleMethod >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	self isValid 
		ifTrue: [ 
			aStream nextPutAll: ' ('. 
			self method gtDisplayOn: aStream. 
			aStream nextPut: $) ] 
		ifFalse: [ 
			aStream 
				nextPutAll: ' (';
				nextPutAll: self methodClassName asString; 
				nextPutAll: ' >> #'; 
				nextPutAll: self selector asString;
				nextPut: $);
				nextPutAll: ' [ invalid ]' ]
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> gtExample [
	^ self hasExample 
		ifTrue: [ self method gtExample ]
		ifFalse: [ nil ]
]

{ #category : #ui }
GTAbstractExampleMethod >> gtSpotterPreviewIn: aComposite [
	<spotterPreview: 1>
	self exists ifFalse: [ ^ self ].
	
	aComposite pharoMethod
		title: [ self gtDisplayString ]; 
		display: [ :entity | entity method sourceCode ];
		smalltalkClass: [ self method methodClass ];
		entity: self
]

{ #category : #testing }
GTAbstractExampleMethod >> hasExample [
	^ self exists
		and: [ self method isGTExampleMethod ]
]

{ #category : #testing }
GTAbstractExampleMethod >> hasLiteralThorough: aLiteral [
	^ self methodClassName = aLiteral 
		or: [ self selector = aLiteral
			or: [ self exists 
				and: [ self method hasLiteralThorough: aLiteral ] ] ]
]

{ #category : #testing }
GTAbstractExampleMethod >> hash [
	^ (self class hash 
		bitXor: self methodClassName hash)
			bitXor: self selector hash
]

{ #category : #testing }
GTAbstractExampleMethod >> isValid [
	^ self exists
]

{ #category : #testing }
GTAbstractExampleMethod >> matchesExample: aGTExample [
	^ self exists 
		and: [ aGTExample isGTExample
			and: [ aGTExample methodClass = self methodClass
				and: [ aGTExample selector = self selector ] ] ]
]

{ #category : #testing }
GTAbstractExampleMethod >> matchesMethod: aCompiledMethod [
	^ self exists
		and: [ self methodClass = aCompiledMethod methodClass
			and: [ self selector = aCompiledMethod selector ] ]
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> method [
	^ self exists 
		ifTrue: [ self methodClass >> self selector ]
		ifFalse: [ nil ]
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> methodArgumentNames [
	^ self exists
		ifTrue: [ self method argumentNames ]
		ifFalse: [ #() ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClass [
	^ methodClass
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClass: anObject [
	methodClass := anObject
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClassName [
	^ methodClassName
]

{ #category : #accessing }
GTAbstractExampleMethod >> methodClassName: anObject [
	methodClassName := anObject
]

{ #category : #'accessing-dynamic' }
GTAbstractExampleMethod >> provider [ 
	self exists ifFalse: [ ^ nil ].
	^ self methodClass isMeta
		ifTrue: [ self methodClass ]
		ifFalse: [ self methodClass new ]
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector [
	^ selector
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector: anObject [
	selector := anObject
]
