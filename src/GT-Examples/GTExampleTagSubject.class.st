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
	self thePackage ifNil: [ ^ self ].
	
	self thePackage classes do: [ :class | 
		aSelectorEnvironment addClass: class ]
]

{ #category : #testing }
GTExampleTagSubject >> exists [
	^ self theTag notNil
]

{ #category : #UI }
GTExampleTagSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse subject Tag ' ,  self theTagName
		value: [ self theTag browse ]
]

{ #category : #UI }
GTExampleTagSubject >> gtDisplayOn: aStream [
	self theTagName gtDisplayOn: aStream.
	self gtDisplayValidityOn: aStream
]

{ #category : #testing }
GTExampleTagSubject >> hasLiteralThorough: aLiteral [
	^ self theTagName = aLiteral
		or: [ self exists
			and: [ self theTag categoryName = aLiteral
				or: [ (self theTag classes anySatisfy: [ :each | each name = aLiteral asString ])
					"or: [ self theTag methods anySatisfy: [ :each | each hasLiteralThorough: aLiteral ] ]" ] ] ]
]

{ #category : #testing }
GTExampleTagSubject >> hash [
	^ super hash
		bitXor: self theTagName hash
]

{ #category : #private }
GTExampleTagSubject >> resetStub [
	theTag := nil
]

{ #category : #'accessing-dynamic' }
GTExampleTagSubject >> thePackage [
	^ self theTag package
]

{ #category : #accessing }
GTExampleTagSubject >> theTag [
	theTag ifNil: [ 
		RPackageOrganizer default packages do: [ :package |
			package classTags do: [ :tag | 
				(tag name = theTagName
					or: [ tag categoryName = theTagName ]) ifTrue: [ 
						^ theTag := tag ] ] ] ].
	^ theTag
]

{ #category : #accessing }
GTExampleTagSubject >> theTag: anObject [
	anObject ifNotNil: [ self theTagName: anObject name ].
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
