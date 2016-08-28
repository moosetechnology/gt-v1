"
I describe a package subject of an example.
"
Class {
	#name : #GTExamplePackageSubject,
	#superclass : #GTExampleSubject,
	#instVars : [
		'thePackageName',
		'thePackage'
	],
	#category : #'GT-Examples-Subjects'
}

{ #category : #'instance creation' }
GTExamplePackageSubject class >> fromPackage: aRPackage [
	^ self new 
		thePackage: aRPackage;
		thePackageName: aRPackage packageName;
		yourself
]

{ #category : #'instance creation' }
GTExamplePackageSubject class >> fromPackageNamed: aString [
	^ self new 
		thePackage: nil;
		thePackageName: aString asString;
		yourself
]

{ #category : #testing }
GTExamplePackageSubject >> = anExampleSubject [
	^ self class = anExampleSubject class
		and: [ self thePackageName = anExampleSubject thePackageName ]
]

{ #category : #testing }
GTExamplePackageSubject >> exists [
	^ self thePackage notNil
]

{ #category : #testing }
GTExamplePackageSubject >> hasLiteralThorough: aLiteral [
	^ self thePackageName = aLiteral
		or: [ self exists
			and: [ (self thePackage classes anySatisfy: [ :each | each name = aLiteral asString ])
				or: [ self thePackage methods anySatisfy: [ :each | each hasLiteralThorough: aLiteral ] ] ] ]
]

{ #category : #testing }
GTExamplePackageSubject >> hash [
	^ self class hash
		bitXor: self thePackageName hash
]

{ #category : #private }
GTExamplePackageSubject >> resetStub [
	thePackage := nil
]

{ #category : #accessing }
GTExamplePackageSubject >> thePackage [
	^ thePackage ifNil: [ thePackage := RPackageOrganizer default packages 
		detect: [ :each | each packageName = thePackageName ]
		ifNone: [ nil ] ]
]

{ #category : #accessing }
GTExamplePackageSubject >> thePackage: anObject [
	anObject ifNotNil: [ self thePackageName: anObject packageName ].
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
