Class {
	#name : #GTLiveBouncingAtomsScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTLiveBouncingAtomsScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 0.1; 
		parent: #GTScenery;
		label: 'Live - Bouncing Atoms';
		action:[self new setUp]
]

{ #category : #setUp }
GTLiveBouncingAtomsScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'BouncingAtomsMorph new openInWorld') maximize
]
