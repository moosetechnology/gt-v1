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

{ #category : #private }
GTExampleWorldMenu >> disableNotifications: aBuilder [
	(lastItem := aBuilder item: 'Disable notifications')
		parent: #gte;
		action: [ GTExampleNautilusNotifications stop ]
]

{ #category : #private }
GTExampleWorldMenu >> enableNotifications: aBuilder [
	(lastItem := aBuilder item: 'Enable notifications')
		parent: #gte;
		action: [ GTExampleNautilusNotifications start ]
]

{ #category : #private }
GTExampleWorldMenu >> inspectAllExamples: aBuilder [
	(lastItem := aBuilder item: 'Inspect all examples')
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
	
	self buildSeparator.
	
	self toggleNotifications: aBuilder.
	
	self buildSeparator.
	
	self resetAllExamples: aBuilder
]

{ #category : #private }
GTExampleWorldMenu >> resetAllExamples [
	GTExampleOrganizer reset.
	GTExampleOrganizer restart.
	Smalltalk garbageCollect; garbageCollectMost.
]

{ #category : #private }
GTExampleWorldMenu >> resetAllExamples: aBuilder [
	(lastItem := aBuilder item: 'Reset all examples')
		parent: #gte;
		action: [ self resetAllExamples ]
]

{ #category : #private }
GTExampleWorldMenu >> toggleNotifications: aBuilder [
	GTExampleNautilusNotifications isEnabled
		ifTrue: [ self disableNotifications: aBuilder ]
		ifFalse: [ self enableNotifications: aBuilder ]
]
