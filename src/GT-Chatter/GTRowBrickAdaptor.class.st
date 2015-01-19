Class {
	#name : #GTRowBrickAdaptor,
	#superclass : #GLMBrickListAdaptor,
	#instVars : [
		'owner',
		'modelAccessor'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #private }
GTRowBrickAdaptor >> emptyMorph: aNilOrMorph [ 
	^ self owner newRowBrick
]

{ #category : #initialization }
GTRowBrickAdaptor >> initialize [
	super initialize.
	self morphAtLogic: [ :anInteger :aMorph | 
		self updateOrCreateNewMorph: aMorph at: anInteger ]
]

{ #category : #accessing }
GTRowBrickAdaptor >> modelAccessor [
	^ modelAccessor 
]

{ #category : #accessing }
GTRowBrickAdaptor >> modelAccessor: anObject [
	modelAccessor := anObject
]

{ #category : #accessing }
GTRowBrickAdaptor >> owner [
	^ owner
]

{ #category : #accessing }
GTRowBrickAdaptor >> owner: anObject [
	owner := anObject
]

{ #category : #private }
GTRowBrickAdaptor >> updateOrCreateNewMorph: aMorph at: anInteger [
	| aBrick |
	anInteger <= origin size 
		ifFalse: [ aBrick := self emptyMorph: aMorph ]
		ifTrue: [ | aModel |
			aModel := origin at: anInteger.
			aBrick := self updateOrCreateNewMorph: aMorph model: aModel ].
	^ aBrick
]

{ #category : #private }
GTRowBrickAdaptor >> updateOrCreateNewMorph: aBrickOrNil model: aModel [
	^ self owner perform: modelAccessor with: aBrickOrNil with: aModel
]
