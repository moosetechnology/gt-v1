Class {
	#name : #Scenery,
	#superclass : #Object,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
Scenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Scenery)
		order: 7.0; 
		withSeparatorAfter
]

{ #category : #utilities }
Scenery >> cleanWindows [
	(World submorphs 
		select: [ :each | each isKindOf: SystemWindow ])
		do: #delete
]

{ #category : #setUp }
Scenery >> setUp [
	
]
