Class {
	#name : #GTExampleNautilusClassMenu,
	#superclass : #GTAbstractExampleNautilusMenu,
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTExampleNautilusClassMenu class >> menuFor: aBuilder [
	<contextMenu>
	<nautilusGlobalClassMenu>
	^ self new
		menuFor: aBuilder
		yourself
]

{ #category : #private }
GTExampleNautilusClassMenu >> browseClass: aClass builder: aBuilder [
	(lastItem := aBuilder item: 'Browse Examples of Class ' ,  aClass name)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesOfClass: aClass ].
]

{ #category : #private }
GTExampleNautilusClassMenu >> browseHierarchyOf: aClass builder: aBuilder [
	(lastItem := aBuilder item: 'Browse Examples in Hierarchy of Class ' , aClass name)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesInHierarchyOfClass: aClass ].
]

{ #category : #private }
GTExampleNautilusClassMenu >> browseSubclassesOf: aClass builder: aBuilder [
	(lastItem := aBuilder item: 'Browse Examples in Subclasses of Class ' , aClass name)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesInSubclassesOfClass: aClass ].
]

{ #category : #private }
GTExampleNautilusClassMenu >> browseSuperclassesOf: aClass builder: aBuilder [
	(lastItem := aBuilder item: 'Browse Examples in Superclasses of Class ' , aClass name)
		parent: #gte;
		action: [ GTExampleNavigation browseExamplesInSuperclassesOfClass: aClass ].
]

{ #category : #public }
GTExampleNautilusClassMenu >> menuFor: aBuilder [
	| model class |
	(model := aBuilder model) ifNil: [ ^ self ].
	(class := model selectedClass) ifNil: [ ^ self ].
	
	self buildSubmenu: aBuilder.
	self inspectExamples: [ class gtExamples ] builder: aBuilder.
	self inspectReturnValue: [ class gtExamples ] builder: aBuilder.
	self inspectResults: [ class gtExamples ] builder: aBuilder.
	self inspectProblems: [ class gtExamples ] builder: aBuilder.
	self buildSeparator.
	self runExamples: [ class gtExamples ] builder: aBuilder.
	self debugExamples: [ class gtExamples ] builder: aBuilder.
	self buildSeparator.
	self browseClass: class builder: aBuilder.
	self browseSubclassesOf: class builder: aBuilder.
	self browseSuperclassesOf: class builder: aBuilder.
	self browseHierarchyOf: class builder: aBuilder.
	self buildSeparator.
	self browseExamplesReferencing: class theNonMetaClass name builder: aBuilder.
	self browseExamplesWithSubject: class theNonMetaClass name builder: aBuilder.
	self buildSeparator.
	self browseAllExamples: aBuilder.
	self browseAllExamplesWithProblems: aBuilder.
	self browseAllExamplesWithDependencies: aBuilder.
	self browseAllExamplesIgnoredByTests: aBuilder.
]
