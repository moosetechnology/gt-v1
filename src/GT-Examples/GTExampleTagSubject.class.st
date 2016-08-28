"
I describe a package tag subject of an example.
"
Class {
	#name : #GTExampleTagSubject,
	#superclass : #GTExampleSubject,
	#instVars : [
		'theTagName',
		'theTag'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExampleTagSubject class >> fromTag: aRPackageTag [
	^ self new 
		theTag: aRPackageTag;
		theTagName: aRPackageTag categoryName;
		yourself
]

{ #category : #'instance creation' }
GTExampleTagSubject class >> fromTagNamed: aString [
	^ self new 
		theTag: nil;
		theTagName: aString asString;
		yourself
]

{ #category : #testing }
GTExampleTagSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self theTagName = anExampleSubject theTagName ]
]

{ #category : #testing }
GTExampleTagSubject >> exists [
	^ self theTag notNil
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
	^ self class hash
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
