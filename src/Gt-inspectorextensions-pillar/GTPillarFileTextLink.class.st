Class {
	#name : #GTPillarFileTextLink,
	#superclass : #TextLink,
	#instVars : [
		'fileReference'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarFileTextLink >> actOnClick: anEvent for: anObject in: paragraph editor: editor [
	^ fileReference inspect
]

{ #category : #'as yet unclassified' }
GTPillarFileTextLink >> fileName: aString [
	fileReference := aString 
]
