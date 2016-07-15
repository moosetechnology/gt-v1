Class {
	#name : #GTExampleWorldMenu,
	#superclass : #GTAbstractExampleMenu,
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTExampleWorldMenu class >> menuFor: aBuilder [
	<worldMenu>
	^ self new 
		menuFor: aBuilder;
		yourself
]

{ #category : #private }
GTExampleWorldMenu >> buildSubmenu: aBuilder [
	(lastItem := aBuilder item: #gte)
		order: 0.15;
		parent: 'Tools';
		label: 'GT Examples';
		withSeparatorAfter.
]

{ #category : #public }
GTExampleWorldMenu >> inspectAllExamples: aBuilder [
	(lastItem := aBuilder item: 'Inspect all Examples')
		parent: #gte;
		action: [ self examples: [ Smalltalk gtExamplesContained ] ];
		icon: Smalltalk ui icons glamorousInspect.
]

{ #category : #public }
GTExampleWorldMenu >> menuFor: aBuilder [
	self buildSubmenu: aBuilder.
	
	self inspectAllExamples: aBuilder.
	
	self buildSeparator.
	
	self browseAllExamples: aBuilder.
	self browseAllExamplesWithProblems: aBuilder.
	self browseAllExamplesWithDependencies: aBuilder.
	self browseAllExamplesIgnoredByTests: aBuilder.
]
