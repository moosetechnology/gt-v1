Class {
	#name : #GTExamplePackageSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'thePackageName',
		'thePackage'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTExamplePackageSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self thePackageName = anExampleSubject thePackageName ]
]

{ #category : #UI }
GTExamplePackageSubject >> addToSelectorEnvironment: aSelectorEnvironment [
	self thePackage ifNil: [ ^ self ].
	
	self thePackage classes do: [ :class | 
		aSelectorEnvironment addClass: class ].
	self thePackage extensionMethods do: [ :method | 
		aSelectorEnvironment addClass: method methodClass selector: method selector ]
]

{ #category : #private }
GTExamplePackageSubject >> ensureInitialized [
	thePackage ifNotNil: [ thePackage isEmpty ifTrue: [ thePackage := nil ] ].
	thePackage ifNil: [ 
		thePackage := RPackageOrganizer default packages 
			detect: [ :each | each packageName = thePackageName ]
			ifNone: [ nil ] ].
	
]

{ #category : #testing }
GTExamplePackageSubject >> exists [
	^ self thePackage notNil
]

{ #category : #UI }
GTExamplePackageSubject >> forNautilus: aBlock [
	self exists ifFalse: [ ^ self ].
	
	aBlock 
		value: #'Browse Package ' ,  self thePackageName
		value: [ self thePackage browse ]
]

{ #category : #UI }
GTExamplePackageSubject >> gtDisplayOn: aStream [
	self thePackageName gtDisplayOn: aStream
]

{ #category : #testing }
GTExamplePackageSubject >> hasLiteralThorough: aLiteral [
	^ self thePackageName = aLiteral
		or: [ self exists
			and: [ (self thePackage classes anySatisfy: [ :each | each name = aLiteral ])
				or: [ self thePackage methods anySatisfy: [ :each | each hasLiteralThorough: aLiteral ] ] ] ]
]

{ #category : #testing }
GTExamplePackageSubject >> hash [
	^ self class hash
		bitXor: self thePackageName hash
]

{ #category : #accessing }
GTExamplePackageSubject >> thePackage [
	^ thePackage
]

{ #category : #accessing }
GTExamplePackageSubject >> thePackage: anObject [
	thePackage := anObject
]

{ #category : #accessing }
GTExamplePackageSubject >> thePackageName [
	^ thePackageName
]

{ #category : #accessing }
GTExamplePackageSubject >> thePackageName: anObject [
	thePackageName := anObject
]
