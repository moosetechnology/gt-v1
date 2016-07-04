Class {
	#name : #GTExampleTagSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'theTagName',
		'theTag'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExampleTagSubject >> = anExampleSubject [
	^ super = anExampleSubject
		and: [ self theTagName = anExampleSubject theTagName ]
]

{ #category : #UI }
GTExampleTagSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self thePackage ifNotNil: [ :pkg | 
		pkg classes do: [ :class | 
			aSelectorEnvironment addClass: class ] ]
]

{ #category : #private }
GTExampleTagSubject >> ensure [
	theTag ifNotNil: [ theTag isEmpty ifTrue: [ theTag := nil ] ].
	theTag ifNil: [ 
		RPackageOrganizer default packages do: [ :package |
			package classTags do: [ :tag | 
				(tag name = self theTagName
					or: [ tag categoryName = self theTagName ]) ifTrue: [ ^ theTag := tag ] ] ] ]
]

{ #category : #testing }
GTExampleTagSubject >> exists [
	^ self theTag notNil
]

{ #category : #UI }
GTExampleTagSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse Tag ' ,  self theTagName
		value: [ self theTag browse ]
]

{ #category : #UI }
GTExampleTagSubject >> gtDisplayOn: aStream [
	aStream printOn: self theTagName
]

{ #category : #testing }
GTExampleTagSubject >> hasLiteralThorough: aLiteral [
	^ self theTag name = aLiteral
		or: [ self theTag categoryName = aLiteral
			or: [ (self theTag classes anySatisfy: [ :each | each name = aLiteral ])
				"or: [ self theTag methods anySatisfy: [ :each | each hasLiteralThorough: aLiteral ] ]" ] ]
]

{ #category : #testing }
GTExampleTagSubject >> hash [
	^ super hash
		bitXor: self theTagName hash
]

{ #category : #accessing }
GTExampleTagSubject >> theTag [
	self ensure.
	^ theTag
]

{ #category : #accessing }
GTExampleTagSubject >> theTag: anObject [
	theTag := anObject
]

{ #category : #accessing }
GTExampleTagSubject >> theTagName [
	^ theTagName
]

{ #category : #accessing }
GTExampleTagSubject >> theTagName: anObject [
	theTagName := anObject
]
