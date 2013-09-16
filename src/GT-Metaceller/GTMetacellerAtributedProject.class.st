Class {
	#name : #GTMetacellerAtributedProject,
	#superclass : #GTMetacellerProject,
	#instVars : [
		'platformDescription'
	],
	#category : #'GT-Metaceller'
}

{ #category : #'instance creation' }
GTMetacellerAtributedProject class >> on: aConfigurationClass platform: aPlatformDescription [
	^self basicNew
		initialize: aConfigurationClass platform: aPlatformDescription;
		yourself
]

{ #category : #testing }
GTMetacellerAtributedProject >> hasAttributes [
	^true
]

{ #category : #initialization }
GTMetacellerAtributedProject >> initialize: aConfigurationClass platform: aPlatformDescription [
	self initialize: aConfigurationClass.
	platformDescription := aPlatformDescription
]

{ #category : #accessing }
GTMetacellerAtributedProject >> platformDescription [
	^ platformDescription
]

{ #category : #accessing }
GTMetacellerAtributedProject >> project [
	^project ifNil: [ 
		GTMetacelloPlatform defaultPlatformDescription: self platformDescription.
		[ project := configuration project ] ensure: [ GTMetacelloPlatform defaultPlatformDescription: nil ] ]
]
