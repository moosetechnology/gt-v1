Class {
	#name : #GTExampleAspectResolver,
	#superclass : #Object,
	#instVars : [
		'example',
		'meta',
		'aspectClass'
	],
	#category : #'GT-Examples-Organization'
}

{ #category : #accessing }
GTExampleAspectResolver >> aspectClass [
	^ aspectClass
]

{ #category : #accessing }
GTExampleAspectResolver >> aspectClass: anObject [
	aspectClass := anObject
]

{ #category : #private }
GTExampleAspectResolver >> ensureClass: aClass [
	(aClass isMeta not and: [ self meta ]) 
		ifTrue: [ ^ aClass class " be nice " ].
	(aClass isMeta and: [ self meta not ]) 
		ifTrue: [ ^ aClass "backward compatibility " ].
	" default case "
	^ aClass
]

{ #category : #accessing }
GTExampleAspectResolver >> example [
	^ example
]

{ #category : #accessing }
GTExampleAspectResolver >> example: anObject [
	example := anObject
]

{ #category : #accessing }
GTExampleAspectResolver >> meta [
	^ meta
]

{ #category : #accessing }
GTExampleAspectResolver >> meta: anObject [
	meta := anObject
]
