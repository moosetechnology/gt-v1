Class {
	#name : #GTScenery,
	#superclass : #Object,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #GTScenery)
		order: 7.0; 
		label: 'Scenery';
		withSeparatorAfter
]

{ #category : #utilities }
GTScenery >> cleanWindows [
	(World submorphs 
		select: [ :each | each isKindOf: SystemWindow ])
		do: #delete
]

{ #category : #setUp }
GTScenery >> setUp [
	
]
