Class {
	#name : #GTPillarFileTextLink,
	#superclass : #TextAction,
	#instVars : [
		'fileReference',
		'presentation'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #evaluating }
GTPillarFileTextLink >> actOnClick: anEvent for: anObject in: paragraph editor: editor [
	^ self presentation selection: fileReference
]

{ #category : #accessing }
GTPillarFileTextLink >> fileReference: aFileReference [
	fileReference := aFileReference 
]

{ #category : #accessing }
GTPillarFileTextLink >> presentation [
	^ presentation
]

{ #category : #accessing }
GTPillarFileTextLink >> presentation: anObject [
	presentation := anObject
]
