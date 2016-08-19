Class {
	#name : #GTAbstractExampleMethod,
	#superclass : #GTAbstractExampleObject,
	#traits : 'TGTExampleMethod',
	#classTraits : 'TGTExampleMethod classTrait',
	#instVars : [
		'methodClassName',
		'methodClass',
		'selector'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #'instance creation' }
GTAbstractExampleMethod class >> fromClass: aClass selector: aSelector [
	^ self new 
		methodClass: aClass;
		methodClassName: aClass name;
		selector: aSelector;
		yourself
]

{ #category : #'instance creation' }
GTAbstractExampleMethod class >> fromClassNamed: aString selector: aSelector [
	^ self new 
		methodClass: nil;
		methodClassName: aString asString;
		selector: aSelector;
		yourself
]

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
	aStream 
		nextPutAll: self methodClassName asString; 
		nextPutAll: ' >> #'; 
		nextPutAll: self selector asString.
		
	self gtDisplayValidityOn: aStream
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
	^ methodClass ifNil: [ methodClass := Smalltalk classNamed: methodClassName ]
		
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
		ifTrue: [ self methodClass theNonMetaClass ]
		ifFalse: [ self methodClass theNonMetaClass new ]
]

{ #category : #private }
GTAbstractExampleMethod >> resetStub [
	" 1) reset -> 2) reinitialize  "
	methodClass := nil
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector [
	^ selector
]

{ #category : #accessing }
GTAbstractExampleMethod >> selector: anObject [
	selector := anObject
]
