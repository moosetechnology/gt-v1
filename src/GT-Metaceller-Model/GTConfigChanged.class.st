Class {
	#name : #GTConfigChanged,
	#superclass : #Announcement,
	#instVars : [
		'config'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTConfigChanged class >> on: aConfig [
	^self new
		config: aConfig;
		yourself
]

{ #category : #accessing }
GTConfigChanged >> config [
	^config
]

{ #category : #accessing }
GTConfigChanged >> config: aConfiguration [
	config := aConfiguration
]
