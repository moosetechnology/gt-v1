Class {
	#name : #GTPillarFileTextLink,
	#superclass : #TextAction,
	#instVars : [
		'fileReference',
		'presentation'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarFileTextLink >> actOnClick: anEvent for: anObject in: paragraph editor: editor [
	^ self presentation selection: fileReference
]

{ #category : #'as yet unclassified' }
GTPillarFileTextLink >> fileName: aString [
	fileReference := aString 
]

{ #category : #accessing }
GTPillarFileTextLink >> presentation [
	^ presentation
]

{ #category : #accessing }
GTPillarFileTextLink >> presentation: anObject [
	presentation := anObject
]
