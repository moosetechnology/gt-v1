Class {
	#name : #GTExamplePackageSubject,
	#superclass : #GTAbstractExampleSubject,
	#instVars : [
		'thePackageName',
		'thePackage'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #private }
GTExamplePackageSubject >> ensure [
	thePackage ifNotNil: [ thePackage isEmpty ifTrue: [ thePackage := nil ] ].
	thePackage ifNil: [ 
		thePackage := RPackageOrganizer default packages 
			detect: [ :each | each packageName = self thePackageName ]
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

{ #category : #testing }
GTExamplePackageSubject >> hasLiteralThorough: aLiteral [
	^ self thePackageName = aLiteral
		or: [ (self thePackage classes anySatisfy: [ :each | each name = aLiteral ])
			or: [ self thePackage methods anySatisfy: [ :each | each hasLiteralThorough: aLiteral ] ] ]
]

{ #category : #accessing }
GTExamplePackageSubject >> thePackage [
	self ensure.
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
