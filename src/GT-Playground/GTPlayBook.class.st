Class {
	#name : #GTPlayBook,
	#superclass : #Object,
	#instVars : [
		'pages'
	],
	#classVars : [
		'instance'
	],
	#category : #'GT-Playground'
}

{ #category : #'as yet unclassified' }
GTPlayBook class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #'as yet unclassified' }
GTPlayBook class >> reset [
	instance := nil
]

{ #category : #accessing }
GTPlayBook >> addPage: aPage [
	self pages addFirst: aPage
]

{ #category : #accessing }
GTPlayBook >> initialize [
	pages := OrderedCollection new
]

{ #category : #accessing }
GTPlayBook >> pages [
	^ pages
]

{ #category : #accessing }
GTPlayBook >> pages: anObject [
	pages := anObject
]

{ #category : #accessing }
GTPlayBook >> removePage: aPage [
	self pages remove: aPage
]
