Class {
	#name : #GTMetacellerVersionName,
	#superclass : #Magnitude,
	#instVars : [
		'original',
		'splitted'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTMetacellerVersionName class >> on: aString [
	^self new
		original: aString;
		yourself
]

{ #category : #testing }
GTMetacellerVersionName >> < aVersionName [
	self splitted withIndexDo: [ :each :index |
		each ~= (aVersionName at: index) ifTrue: [ 
			(aVersionName at: index) ifNil: [ ^false ].
			^each < (aVersionName at: index) ] ].
	" And the special case "
	^(self = aVersionName) not
]

{ #category : #testing }
GTMetacellerVersionName >> = aMagnitude [
	self class == aMagnitude class ifFalse: [ ^false ].
	^self splitted = aMagnitude splitted
]

{ #category : #accessing }
GTMetacellerVersionName >> at: anIndex [
	(self splitted size < anIndex) ifTrue: [ ^nil ].
	^self splitted at: anIndex
]

{ #category : #hash }
GTMetacellerVersionName >> hash [
	^self splitted hash
]

{ #category : #accessing }
GTMetacellerVersionName >> original [
	^ original
]

{ #category : #accessing }
GTMetacellerVersionName >> original: anObject [
	original := anObject
]

{ #category : #accessing }
GTMetacellerVersionName >> size [
	^self splitted size
]

{ #category : #accessing }
GTMetacellerVersionName >> splitted [
	^splitted ifNil: [ splitted := (original subStrings: '.') collect: [ :each |
		Number readFrom: each ifFail: [ each ] ] ]
]
