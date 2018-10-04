Class {
	#name : #GTOUser,
	#superclass : #Object,
	#instVars : [
		'options'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'instance creation' }
GTOUser class >> named: aString [ 
	^ self new nickname: aString; yourself
]

{ #category : #'instance creation' }
GTOUser class >> signed: aGTOUserSign [ 
	^ self new sign: aGTOUserSign; yourself
]

{ #category : #accessing }
GTOUser >> chatter [
	^ self optionAt: #chatter ifAbsent: [ nil ]
]

{ #category : #accessing }
GTOUser >> chatter: aGTOChatter [
	self optionAt: #chatter put: aGTOChatter
]

{ #category : #initialization }
GTOUser >> initializeOptions [
	options := Dictionary new
]

{ #category : #accessing }
GTOUser >> nickname [
	^ self sign nickname
]

{ #category : #accessing }
GTOUser >> nickname: aString [ 
	self sign nickname: aString
]

{ #category : #accessing }
GTOUser >> optionAt: aSymbol ifAbsent: aBlockClosure [ 
	options ifNil: [ ^ aBlockClosure value ].
	^ options at: aSymbol ifAbsent: aBlockClosure 
]

{ #category : #accessing }
GTOUser >> optionAt: aSymbol ifAbsentPut: absentBlock [ 
	options ifNil: [ self initializeOptions ].
	^ options at: aSymbol ifAbsentPut: absentBlock.
	
]

{ #category : #accessing }
GTOUser >> optionAt: aSymbol ifPresent: presentBlock ifAbsent: absentBlock [ 
	options ifNil: [ ^ absentBlock value ].
	^ options at: aSymbol ifPresent: presentBlock ifAbsent: absentBlock 
]

{ #category : #accessing }
GTOUser >> optionAt: aSymbol put: anObject [ 
	options ifNil: [ self initializeOptions ].
	^ options at: aSymbol put: anObject
]

{ #category : #accessing }
GTOUser >> sign [
	^ self 
		optionAt: #sign
		ifAbsentPut: [ GTOUserSign new ]
]

{ #category : #accessing }
GTOUser >> sign: aGTOUserSign [
	^ self 
		optionAt: #sign
		put: aGTOUserSign
]
