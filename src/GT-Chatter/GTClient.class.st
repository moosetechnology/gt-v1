Class {
	#name : #GTClient,
	#superclass : #Object,
	#instVars : [
		'fullName'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #comparing }
GTClient >> = aClientOrString [
	^ aClientOrString isString 
		ifTrue: [ self fullName = aClientOrString ]
		ifFalse: [ self fullName = aClientOrString fullName ]
]

{ #category : #converting }
GTClient >> asString [
	^ self fullName asString
]

{ #category : #accessing }
GTClient >> fullName [
	^ fullName ifNil: [ fullName := Author fullName  ]
]

{ #category : #accessing }
GTClient >> fullName: anObject [
	fullName := anObject
]

{ #category : #dispatch }
GTClient >> heightToDisplayInList: aList [

	^ aList font height
]

{ #category : #dispatch }
GTClient >> listRenderOn: aCanvas atRow: aRow bounds: bounds color: color backgroundColor: backgroundColor from: aMorph [

	aCanvas
		drawString: self fullName
		in: bounds
		font: aMorph font
		color: color
]

{ #category : #protocol }
GTClient >> openChat [
	^ GTChatter openChatWith: self
]

{ #category : #printing }
GTClient >> printOn: aStream [
	aStream
		nextPutAll: self fullName asString
]

{ #category : #dispatch }
GTClient >> widthToDisplayInList: aList [

	^ aList font widthOfStringOrText: self fullName
]
